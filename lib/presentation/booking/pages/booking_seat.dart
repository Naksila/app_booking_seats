import 'package:app_booking_seat/core/utils/contant.dart';
import 'package:app_booking_seat/domain/domain.dart';
import 'package:app_booking_seat/presentation/presentation.dart';
import 'package:app_booking_seat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingSeatPage extends StatefulWidget {
  static const ROUTE_NAME = '${route}/booking_seat';

  const BookingSeatPage({super.key});

  @override
  State<BookingSeatPage> createState() => _BookingSeatPageState();
}

class _BookingSeatPageState extends State<BookingSeatPage> {
  List<String> rowName = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];

  List<SeatEntity>? seats;
  List seatSelected = [];
  int? rows;
  int? columns;
  bool isSelected = false;

  int? configSeat = 1;

  @override
  void initState() {
    context.read<GetSeatCubit>().getSeatResult();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'เลือกที่นั่ง',
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<GetSeatCubit, GetSeatState>(
                builder: (context, state) {
              if (state is GetSeatLoading) {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.amberAccent));
              } else if (state is GetSeatHasData) {
                final data = state.result;
                List groups = [];

                rows = data.seatLayout?.rows;
                columns = data.seatLayout?.columns;
                seats = data.seatLayout?.seats;

                for (var i = 0; i < seats!.length; i += columns!) {
                  groups.add(seats!.sublist(
                      i,
                      i + columns! > seats!.length
                          ? seats!.length
                          : i + columns!));
                }

                return Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            for (int i = 0; i < columns!; i++) ...{
                              SizedBox(
                                width: 50,
                                height: 40,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${i + 1}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            },
                          ],
                        ),
                        for (final (_index, item) in rowName.indexed) ...{
                          if (_index < rows!) ...{
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                for (final (index, data) in groups.indexed) ...{
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: ((groups[_index]
                                                          [index]
                                                      .isSelected ??
                                                  false))
                                              ? Colors.amber[700]
                                              : Colors.grey),
                                      onPressed: () {
                                        SeatEntity seatEntity =
                                            groups[_index][index];

                                        isSelected =
                                            seatEntity.isSelected ?? false;

                                        setState(() {
                                          if ((seatSelected.length + 1) <=
                                              configSeat!) {
                                            seatEntity.isSelected = !isSelected;
                                          } else {
                                            seatEntity.isSelected = false;
                                          }
                                        });

                                        seatSelected = groups
                                            .expand((element) => element)
                                            .where((i) => i.isSelected == true)
                                            .toList();

                                        seatSelected.forEach(
                                            (element) => element.seatNumber);
                                      },
                                      child: const Text(''),
                                    ),
                                  ),
                                  const SizedBox(width: 10)
                                },
                              ],
                            ),
                          },
                          const SizedBox(
                            height: 10,
                          ),
                        },
                        const SizedBox(
                          height: 100,
                        ),
                        const Divider(
                          height: 20,
                          color: Colors.grey,
                        ),
                        const Text(
                          'ที่นั่ง',
                          style: TextStyle(fontSize: 22),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Wrap(
                          runSpacing: 5,
                          spacing: 5,
                          children: [
                            for (final data in seatSelected) ...{
                              if (data.isSelected == true) ...{
                                Tabs(
                                  title: data.seatNumber,
                                  onPressed: () {
                                    setState(() {
                                      data.isSelected = !data.isSelected;
                                    });
                                    seatSelected = groups
                                        .expand((element) => element)
                                        .where((i) => i.isSelected == true)
                                        .toList();
                                  },
                                ),
                              }
                            }
                          ],
                        ),
                      ]),
                );
              } else if (state is GetSeatFailed) {
                return Column(children: [Text(state.message)]);
              } else {
                return Container();
              }
            }),
          ),
        ));
  }
}

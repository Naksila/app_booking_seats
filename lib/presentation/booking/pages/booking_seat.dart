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

enum ShirtSize { extraSmall, small, medium, large, extraLarge }

const List<(ShirtSize, String)> shirtSizeOptions = <(ShirtSize, String)>[
  (ShirtSize.extraSmall, 'XS'),
  (ShirtSize.small, 'S'),
  (ShirtSize.medium, 'M'),
  (ShirtSize.large, 'L'),
  (ShirtSize.extraLarge, 'XL'),
];

class _BookingSeatPageState extends State<BookingSeatPage> {
  List<String> rowName = [
    'A',
    'B',
    'C',
    'D',
    'E',
  ];

  List<SeatEntity>? seats;
  List _seat = [];
  int? rows;
  int? columns;
  bool isSelected = false;

  @override
  void initState() {
    context.read<GetSeatCubit>().getSeatResult();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.amberAccent,
          title: const Text('เลือกที่นั่ง'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<GetSeatCubit, GetSeatState>(
              builder: (context, state) {
            if (state is GetSeatLoading) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.amberAccent));
            } else if (state is GetSeatHasData) {
              final data = state.result;

              rows = data.seatLayout?.rows;
              columns = data.seatLayout?.columns;
              seats = data.seatLayout?.seats;

              List groups = [];

              for (var i = 0; i < seats!.length; i += columns!) {
                groups.add(seats!.sublist(
                    i,
                    i + columns! > seats!.length
                        ? seats!.length
                        : i + columns!));
              }

              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(),
                        for (int i = 0; i < columns!; i++) ...{
                          Text('${i + 1}'),
                        },
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    for (final (_index, item) in rowName.indexed) ...{
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(item),
                          for (final (index, data) in groups.indexed) ...{
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      groups[_index][index].isSelected ?? false
                                          ? Colors.black
                                          : Colors.blue),
                              onPressed: () {
                                SeatEntity seatEntity = groups[_index][index];
                                // isSelected = seatEntity.isSelected ?? false;

                                setState(() {
                                  seatEntity.isSelected = !isSelected;
                                });

                                _seat = groups
                                    .expand((element) => element)
                                    .where((i) => i.isSelected == true)
                                    .toList();

                                _seat.forEach((element) => element.seatNumber);
                              },
                              child: Text(''),
                              // Text('${groups[_index][index].seatNumber}'),
                            ),
                          },
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    },
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'ที่นั่ง',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      runSpacing: 5,
                      spacing: 5,
                      children: [
                        for (final data in _seat) ...{
                          if (data.isSelected == true) ...{
                            Tabs(
                              title: data.seatNumber,
                              onPressed: () {
                                setState(() {
                                  data.isSelected = !data.isSelected;
                                });
                              },
                            ),
                          }
                        }
                      ],
                    ),
                  ]);
            } else if (state is GetSeatFailed) {
              return Column(children: [Text(state.message)]);
            } else {
              return Container();
            }
          }),
        ));
  }
}

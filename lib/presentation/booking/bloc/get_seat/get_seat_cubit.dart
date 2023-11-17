import 'package:app_booking_seat/domain/domain.dart';
import 'package:app_booking_seat/domain/entities/entities.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_seat_state.dart';

class GetSeatCubit extends Cubit<GetSeatState> {
  final GetBookingSeatUsecase getBookingSeatUsecase;

  GetSeatCubit(this.getBookingSeatUsecase) : super(GetSeatInitial());

  void getSeatResult() async {
    emit(GetSeatLoading());

    final reponse = await getBookingSeatUsecase.execute();

    reponse.fold((l) => {emit(GetSeatFailed(l.message))},
        (r) => {emit(GetSeatHasData(r))});
  }
}

part of 'get_seat_cubit.dart';

sealed class GetSeatState extends Equatable {
  const GetSeatState();

  @override
  List<Object> get props => [];
}

final class GetSeatInitial extends GetSeatState {}

class GetSeatLoading extends GetSeatState {}

class GetSeatFailed extends GetSeatState {
  final message;
  const GetSeatFailed(this.message);
}

class GetSeatCancel extends GetSeatState {}

class GetSeatHasData extends GetSeatState {
  final BookingSeatEntity result;

  const GetSeatHasData(
    this.result,
  );

  @override
  List<Object> get props => [];
}

import 'package:app_booking_seat/core/utils/failure.dart';
import 'package:app_booking_seat/domain/entities/entities.dart';
import 'package:app_booking_seat/domain/repositories/resource_repository.dart';
import 'package:dartz/dartz.dart';

class GetBookingSeatUsecase {
  final ResourceRepository repository;

  GetBookingSeatUsecase({required this.repository});

  Future<Either<Failure, BookingSeatEntity>> execute() {
    return repository.getBookingSeat();
  }
}

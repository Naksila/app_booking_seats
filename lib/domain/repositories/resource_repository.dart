import 'package:app_booking_seat/core/utils/failure.dart';
import 'package:app_booking_seat/domain/entities/entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dartz/dartz.dart';

abstract class ResourceRepository {
  Future<Either<Failure, BookingSeatEntity>> getBookingSeat();
}

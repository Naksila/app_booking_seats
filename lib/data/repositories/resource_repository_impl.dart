import 'package:app_booking_seat/core/utils/failure.dart';
import 'package:app_booking_seat/data/datasource/datasource.dart';
import 'package:app_booking_seat/domain/domain.dart';
import 'package:app_booking_seat/data/data.dart';

import 'package:dartz/dartz.dart';

class ResourceReprositoryImpl implements ResourceRepository {
  final ResourceRemoteDataSource resourceRemoteDataSource;

  ResourceReprositoryImpl(this.resourceRemoteDataSource);

  @override
  Future<Either<Failure, BookingSeatEntity>> getBookingSeat() async {
    try {
      var result = await resourceRemoteDataSource.getBookingSeat();

      return Right(result.toEntity(bookingSeatModel: result));
    } on ServerFailure catch (e) {
      return Left(ServerFailure('Error'));
    }
  }
}

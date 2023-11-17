import 'package:app_booking_seat/data/data.dart';
import 'package:app_booking_seat/domain/domain.dart';
import 'package:app_booking_seat/presentation/booking/bloc/bloc.dart';

import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // DataSource
  if (!locator.isRegistered<ResourceRemoteDataSource>()) {
    locator.registerLazySingleton<ResourceRemoteDataSource>(
        () => ResourceRemoteDataSourceImpl());
  }

  // Repository
  if (!locator.isRegistered<ResourceRepository>()) {
    locator.registerLazySingleton<ResourceRepository>(
        () => ResourceReprositoryImpl(locator()));
  }

  // Usecase
  if (!locator.isRegistered<GetBookingSeatUsecase>()) {
    locator.registerLazySingleton(() => GetBookingSeatUsecase(
          repository: locator(),
        ));
  }

  // bloc
  if (!locator.isRegistered<GetSeatCubit>()) {
    locator.registerLazySingleton(() => GetSeatCubit(locator()));
  }
}

void exit() {}

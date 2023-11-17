import 'package:app_booking_seat/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_booking_seat/inject.dart' as di;

import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

void main() {
  di.init();
  runApp(MaterialApp(
      home: MyApp(),
      theme: ThemeData(
        fontFamily: 'DB Heavent',
      )));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di.locator<GetSeatCubit>()),
      ],
      child: const BookingSeatPage(),
    );
  }
}

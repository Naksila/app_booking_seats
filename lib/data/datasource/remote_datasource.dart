import 'dart:convert';

import 'package:app_booking_seat/core/utils/failure.dart';
import 'package:app_booking_seat/data/models/booking_seat_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

abstract class ResourceRemoteDataSource {
  Future<BookingSeatModel> getBookingSeat();
}

class ResourceRemoteDataSourceImpl extends ResourceRemoteDataSource {
  @override
  Future<BookingSeatModel> getBookingSeat() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://xokthilat.github.io/json/seating.json',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode != 200) {
        print('error');
        print(response.statusMessage);

        throw ServerFailure(response.statusMessage.toString());
      }

      print(json.encode(response.data));
      return BookingSeatModel.fromJson(response.data);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}

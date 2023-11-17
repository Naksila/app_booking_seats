import 'dart:convert';
import 'dart:math';
import 'package:meta/meta.dart';

import 'package:app_booking_seat/domain/entities/entities.dart';

class BookingSeatModel {
  final Venue venue;
  final SeatLayout seatLayout;

  BookingSeatModel({
    required this.venue,
    required this.seatLayout,
  });

  BookingSeatEntity toEntity({BookingSeatModel? bookingSeatModel}) {
    return BookingSeatEntity(
        venue: VenueEntity(
            name: bookingSeatModel?.venue.name,
            capacity: bookingSeatModel?.venue.capacity),
        seatLayout: SeatLayoutEntity(
            columns: bookingSeatModel?.seatLayout.columns,
            rows: bookingSeatModel?.seatLayout.rows,
            seats: bookingSeatModel?.seatLayout.seats
                .map((e) => SeatEntity(
                      seatNumber: e.seatNumber,
                      status: e.status,
                      isSelected: false,
                    ))
                .toList()));
  }

  factory BookingSeatModel.fromRawJson(String str) =>
      BookingSeatModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookingSeatModel.fromJson(Map<String, dynamic> json) =>
      BookingSeatModel(
        venue: Venue.fromJson(json["venue"]),
        seatLayout: SeatLayout.fromJson(json["seatLayout"]),
      );

  Map<String, dynamic> toJson() => {
        "venue": venue.toJson(),
        "seatLayout": seatLayout.toJson(),
      };
}

class SeatLayout {
  final int rows;
  final int columns;
  final List<Seat> seats;

  SeatLayout({
    required this.rows,
    required this.columns,
    required this.seats,
  });

  factory SeatLayout.fromRawJson(String str) =>
      SeatLayout.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SeatLayout.fromJson(Map<String, dynamic> json) => SeatLayout(
        rows: json["rows"],
        columns: json["columns"],
        seats: List<Seat>.from(json["seats"].map((x) => Seat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "rows": rows,
        "columns": columns,
        "seats": List<dynamic>.from(seats.map((x) => x.toJson())),
      };
}

class Seat {
  final String seatNumber;
  final String status;

  Seat({
    required this.seatNumber,
    required this.status,
  });

  factory Seat.fromRawJson(String str) => Seat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        seatNumber: json["seatNumber"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {"seatNumber": seatNumber, "status": status};
}

class Venue {
  final String name;
  final int capacity;

  Venue({
    required this.name,
    required this.capacity,
  });

  factory Venue.fromRawJson(String str) => Venue.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        name: json["name"],
        capacity: json["capacity"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "capacity": capacity,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

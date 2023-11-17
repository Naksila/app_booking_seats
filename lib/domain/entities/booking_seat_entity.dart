import 'package:meta/meta.dart';
import 'dart:convert';

class BookingSeatEntity {
  final VenueEntity? venue;
  final SeatLayoutEntity? seatLayout;

  BookingSeatEntity({
    this.venue,
    this.seatLayout,
  });
}

class SeatLayoutEntity {
  final int? rows;
  final int? columns;
  final List<SeatEntity>? seats;

  SeatLayoutEntity({
    this.rows,
    this.columns,
    this.seats,
  });
}

class SeatEntity {
  final String? seatNumber;
  final String? status;
  bool? isSelected = false;

  SeatEntity({
    this.seatNumber,
    this.status,
    this.isSelected,
  });
}

class VenueEntity {
  final String? name;
  final int? capacity;

  VenueEntity({
    this.name,
    this.capacity,
  });
}

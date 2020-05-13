import 'package:flutter/foundation.dart';

class Flight {
  final String logo;
  final String name;
  final String date;
  final String type;
  final int seat;
  final double price;
  Flight(
      {@required this.logo,
      @required this.name,
      @required this.date,
      @required this.type,
      @required this.seat,
      @required this.price});

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      date: json['date'],
      logo: json['logo'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      type: json['type'],
      seat: int.parse(json['seat'].toString()),
    );
  }
}

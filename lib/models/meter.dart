import 'package:flutter/foundation.dart';

class Meter {
  final int id;
  final String type;
  final String maxStay;
  final int cost;
  final bool inUse;
  final String latlng;
  final String freeTime;

  Meter({
    this.id,
    this.type,
    this.maxStay,
    this.cost,
    this.inUse,
    this.latlng,
    this.freeTime,
  });

  factory Meter.fromJson(Map<String, dynamic> json) {
    return Meter(
      id: json['id'] as int,
      type: json['type'] as String,
      maxStay: json['maxStay'] as String,
      cost: json['cost'] as int,
      inUse: json['inUse'] as bool,
      latlng: json['latlng'] as String,
      freeTime: json['freeTime'] as String,
    );
  }
}

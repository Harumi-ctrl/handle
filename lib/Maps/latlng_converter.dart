import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

class LatLngConverter implements JsonConverter<LatLng?, Map<String, dynamic>?> {
  const LatLngConverter();

  @override
  LatLng? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return LatLng(json['latitude'] as double, json['longitude'] as double);
  }

  @override
  Map<String, dynamic>? toJson(LatLng? object) {
    if (object == null) return null;
    return <String, dynamic>{
      'latitude': object.latitude,
      'longitude': object.longitude,
    };
  }
}

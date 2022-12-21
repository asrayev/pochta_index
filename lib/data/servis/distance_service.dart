import '../models/user_location_model.dart';
import 'dart:math' as math;

num distance(lat2, lon2) {
  double lat1 = UserLocation.lat;
  double lon1 = UserLocation.long;
  int r = 6371;
  lon1 = (lon1 * math.pi) / 180;
  lon2 = (lon2 * math.pi) / 180;
  lat1 = (lat1 * math.pi) / 180;
  lat2 = (lat2 * math.pi) / 180;

  num dlon = lon2 - lon1;
  num dlat = lat2 - lat1;

  num a = math.pow(math.sin(dlat / 2), 2) +
      math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dlon / 2), 2);
  num c = 2 * math.asin(math.sqrt(a));
  return c * r;
}
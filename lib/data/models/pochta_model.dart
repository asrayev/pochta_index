import 'dart:convert';

PochtaModel pochtaFromJson(String str) => PochtaModel.fromJson(json.decode(str));

String pochtaToJson(PochtaModel data) => json.encode(data.toJson());

class PochtaModel {
  PochtaModel({
    required this.pochtaId,
    required this.address,
    required this.phoneNumber,
    required this.oldIndex,
    required this.newIndex,
    required this.workDay,
    required this.workHour,
    required this.lat,
    required this.lon,
  });

  String? pochtaId;
  String? address;
  String? phoneNumber;
  String? oldIndex;
  String? newIndex;
  int? workDay;
  int? workHour;
  double? lat;
  double? lon;
  bool isSaved=false;

  factory PochtaModel.fromJson(Map<String, dynamic> json) => PochtaModel(
    pochtaId: json["pochta_id"]??"",
    address: json["address"]??"",
    phoneNumber: json["phone_number"]??"",
    oldIndex: json["old_index"]??"",
    newIndex: json["new_index"]??"",
    workDay: json["work_day"]?? 0,
    workHour: json["work_hour"]?? 0,
    lat: json["lat"].toDouble()?? 0.0,
    lon: json["lon"].toDouble()?? 0.0,
  );
print("asd");
  Map<String, dynamic> toJson() => {
    "pochta_id": pochtaId,
    "address": address,
    "phone_number": phoneNumber,
    "old_index": oldIndex,
    "new_index": newIndex,
    "work_day": workDay,
    "work_hour": workHour,
    "lat": lat,
    "lon": lon,
  };
}

// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

HistoryModel historyModelFromJson(String str) => HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
    HistoryModel({
        this.status,
        this.message,
        this.dataHistory,
    });

    int status;
    String message;
    List<DataHistory> dataHistory;

    factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        dataHistory: json["dataHistory"] == null ? null : List<DataHistory>.from(json["dataHistory"].map((x) => DataHistory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "dataHistory": dataHistory == null ? null : List<dynamic>.from(dataHistory.map((x) => x.toJson())),
    };
}

class DataHistory {
    DataHistory({
        this.idAbsen,
        this.checkIn,
        this.checkOut,
        this.dateToday,
        this.jamKerja,
        this.place,
        this.checkinBy,
        this.checkoutBy,
        this.latitudeLoc,
        this.longitudeLoc,
        this.idUser,
    });

    String idAbsen;
    DateTime checkIn;
    dynamic checkOut;
    DateTime dateToday;
    String jamKerja;
    String place;
    String checkinBy;
    String checkoutBy;
    String latitudeLoc;
    String longitudeLoc;
    String idUser;

    factory DataHistory.fromJson(Map<String, dynamic> json) => DataHistory(
        idAbsen: json["id_absen"] == null ? null : json["id_absen"],
        checkIn: json["check_in"] == null ? null : DateTime.parse(json["check_in"]),
        checkOut: json["check_out"],
        dateToday: json["date_today"] == null ? null : DateTime.parse(json["date_today"]),
        jamKerja: json["jam_kerja"] == null ? null : json["jam_kerja"],
        place: json["place"] == null ? null : json["place"],
        checkinBy: json["checkin_by"] == null ? null : json["checkin_by"],
        checkoutBy: json["checkout_by"] == null ? null : json["checkout_by"],
        latitudeLoc: json["latitude_loc"] == null ? null : json["latitude_loc"],
        longitudeLoc: json["longitude_loc"] == null ? null : json["longitude_loc"],
        idUser: json["id_user"] == null ? null : json["id_user"],
    );

    Map<String, dynamic> toJson() => {
        "id_absen": idAbsen == null ? null : idAbsen,
        "check_in": checkIn == null ? null : checkIn.toIso8601String(),
        "check_out": checkOut,
        "date_today": dateToday == null ? null : "${dateToday.year.toString().padLeft(4, '0')}-${dateToday.month.toString().padLeft(2, '0')}-${dateToday.day.toString().padLeft(2, '0')}",
        "jam_kerja": jamKerja == null ? null : jamKerja,
        "place": place == null ? null : place,
        "checkin_by": checkinBy == null ? null : checkinBy,
        "checkout_by": checkoutBy == null ? null : checkoutBy,
        "latitude_loc": latitudeLoc == null ? null : latitudeLoc,
        "longitude_loc": longitudeLoc == null ? null : longitudeLoc,
        "id_user": idUser == null ? null : idUser,
    };
}

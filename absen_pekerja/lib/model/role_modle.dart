// To parse this JSON data, do
//
//     final roleModel = roleModelFromJson(jsonString);

import 'dart:convert';

RoleModel roleModelFromJson(String str) => RoleModel.fromJson(json.decode(str));

String roleModelToJson(RoleModel data) => json.encode(data.toJson());

class RoleModel {
    RoleModel({
        this.message,
        this.status,
        this.dataRole,
    });

    String message;
    int status;
    List<DataRole> dataRole;

    factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
        dataRole: json["dataRole"] == null ? null : List<DataRole>.from(json["dataRole"].map((x) => DataRole.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "status": status == null ? null : status,
        "dataRole": dataRole == null ? null : List<dynamic>.from(dataRole.map((x) => x.toJson())),
    };
}

class DataRole {
    DataRole({
        this.idRole,
        this.nameRole,
    });

    String idRole;
    String nameRole;

    factory DataRole.fromJson(Map<String, dynamic> json) => DataRole(
        idRole: json["id_role"] == null ? null : json["id_role"],
        nameRole: json["name_role"] == null ? null : json["name_role"],
    );

    Map<String, dynamic> toJson() => {
        "id_role": idRole == null ? null : idRole,
        "name_role": nameRole == null ? null : nameRole,
    };
}

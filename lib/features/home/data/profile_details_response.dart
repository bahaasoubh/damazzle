import 'package:damazzle/core/CoreModels/base_result_model.dart';

class ProfileDetailsResponseModel extends BaseResultModel{
  int id;
  String email;
  bool hasVerifiedEmail;
  String phone;
  bool hasVerifiedPhone;
  String name;
  List<Permissions> permissions;

  ProfileDetailsResponseModel(
      {this.id,
        this.email,
        this.hasVerifiedEmail,
        this.phone,
        this.hasVerifiedPhone,
        this.name,
        this.permissions,
     });

  ProfileDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    hasVerifiedEmail = json['has_verified_email'];
    phone = json['phone'];
    hasVerifiedPhone = json['has_verified_phone'];
    name = json['name'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions.add(new Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['has_verified_email'] = this.hasVerifiedEmail;
    data['phone'] = this.phone;
    data['has_verified_phone'] = this.hasVerifiedPhone;
    data['name'] = this.name;
    if (this.permissions != null) {
      data['permissions'] = this.permissions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permissions {
  int id;
  String name;

  Permissions({this.id, this.name});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
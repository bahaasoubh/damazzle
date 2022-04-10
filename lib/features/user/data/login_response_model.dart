import 'package:damazzle/core/CoreModels/base_result_model.dart';

class LoginResponseModel extends BaseResultModel {
  String tokenType;
  String accessToken;
  String accessExpiresAt;
  String refreshToken;
  String refreshExpiresAt;
  Me me;

  LoginResponseModel(
      {this.tokenType,
        this.accessToken,
        this.accessExpiresAt,
        this.refreshToken,
        this.refreshExpiresAt,
        this.me});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    accessToken = json['access_token'];
    accessExpiresAt = json['access_expires_at'];
    refreshToken = json['refresh_token'];
    refreshExpiresAt = json['refresh_expires_at'];
    me = json['me'] != null ? new Me.fromJson(json['me']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token_type'] = this.tokenType;
    data['access_token'] = this.accessToken;
    data['access_expires_at'] = this.accessExpiresAt;
    data['refresh_token'] = this.refreshToken;
    data['refresh_expires_at'] = this.refreshExpiresAt;
    if (this.me != null) {
      data['me'] = this.me.toJson();
    }
    return data;
  }
}

class Me {
  int id;
  String email;
  bool hasVerifiedEmail;
  String phone;
  bool hasVerifiedPhone;
  String name;
  Null image;
  List<Permissions> permissions;
  Null addresses;
  Null cards;

  Me(
      {this.id,
        this.email,
        this.hasVerifiedEmail,
        this.phone,
        this.hasVerifiedPhone,
        this.name,
        this.image,
        this.permissions,
        this.addresses,
        this.cards});

  Me.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    hasVerifiedEmail = json['has_verified_email'];
    phone = json['phone'];
    hasVerifiedPhone = json['has_verified_phone'];
    name = json['name'];
    image = json['image'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions.add(new Permissions.fromJson(v));
      });
    }
    addresses = json['addresses'];
    cards = json['cards'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['has_verified_email'] = this.hasVerifiedEmail;
    data['phone'] = this.phone;
    data['has_verified_phone'] = this.hasVerifiedPhone;
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.permissions != null) {
      data['permissions'] = this.permissions.map((v) => v.toJson()).toList();
    }
    data['addresses'] = this.addresses;
    data['cards'] = this.cards;
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
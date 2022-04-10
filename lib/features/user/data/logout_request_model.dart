class LogoutRequestModel {
  String accessToken;

  LogoutRequestModel({
    this.accessToken,
  });

  LogoutRequestModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    return data;
  }
}

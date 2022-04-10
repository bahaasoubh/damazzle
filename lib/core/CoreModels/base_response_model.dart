
import 'base_result_model.dart';

class BaseResponseModel <Result extends BaseResultModel>{
  int statusCode;
  Result data;
  Message message;


  BaseResponseModel(
      {this.statusCode,
        this.data,
        this.message
      });

  BaseResponseModel.fromJson({
      Map<String, dynamic> json ,
      Result Function(Map<String, dynamic>) fromJson ,

      }) {

    print('from json');
    print(json);

    if(json == null)
      {
        print("error");
      }
    else {
      statusCode = json['status_code'];
        message = json['message'] != null ? Message(code:json['status_code'],content:json['message'],type: "") : null ;


        if(fromJson != null)
          if (json['data'] != null) {
            if((json['data'] is List)) {
              data = fromJson(json);
            }
            else
            data = fromJson(json['data']);
          } else {
            if(statusCode==200)
            data = fromJson({"":""});
          }
      }
  }

}

class Message extends BaseResultModel{
  Message({
    this.type,
    this.code,
    this.content,
  });

  String type;
  int code;
  String content;

  Message.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['status_code'];
    if (json["message"] is List) {
      List list = json["message"];
      if(list.length!=0)
        content = list[0];
      else
        content='';
    } else {
      content = json["message"];
    }}


  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "status_code": code == null ? null : code,
    "message": content == null ? null : content,
  };
}



class BaseModel {
  late bool error;
  late int code;
  late BaseModelData data;
  late String message;

  BaseModel({
    required this.error,
    required this.code,
    required this.data,
    required this.message,
  });

  BaseModel.fromJson(dynamic json, BaseModelData baseModelData) {
    error = json["error"];
    code = json["code"];
    data = baseModelData;
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    map["code"] = code;
    map["data"] = data;
    map["message"] = message;
    return map;
  }
}

class BaseModelData<T> {
  late T _value;
  BaseModelData(this._value);

  T get value => _value;

  set value(T value) {
    _value = value;
  }
}

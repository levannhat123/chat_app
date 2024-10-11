
class UserModel {
  String? id;
  String? name;
  String? email;
  String? img;
  String? phone;

  UserModel({this.id, this.name, this.email, this.img, this.phone});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    img = json["img"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["img"] = img;
    _data["phone"] = phone;
    return _data;
  }
}
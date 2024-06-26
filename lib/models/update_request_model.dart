class UpdateUserRequestModel {
  String? id;
  String? email;
  String? fullname;
  String? location;
  String? phone;
  String? avatar;

  UpdateUserRequestModel(
      {this.id,
      this.email,
      this.fullname,
      this.location,
      this.phone,
      this.avatar});

  UpdateUserRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullname = json['fullname'];
    location = json['location'];
    phone = json['phone'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['fullname'] = fullname;
    data['location'] = location;
    data['phone'] = phone;
    data['avatar'] = avatar;
    return data;
  }
}

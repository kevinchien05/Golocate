class User {
  int? id;
  String? username;
  String? email;
  String? password;
  int? point;
  String? phone;
  String? gender;
  String? birth;
  String? place;
  String? bio;

  User(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.point,
      this.phone,
      this.gender,
      this.birth,
      this.place,
      this.bio});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    map['point'] = point;
    map['phone'] = phone;
    map['gender'] = gender;
    map['birth'] = birth;
    map['place'] = place;
    map['bio'] = bio;
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.username = map['username'];
    this.email = map['email'];
    this.password = map['password'];
    this.point = map['point'];
    this.phone = map['phone'];
    this.gender = map['gender'];
    this.birth = map['birth'];
    this.place = map['place'];
    this.bio = map['bio'];
  }
}

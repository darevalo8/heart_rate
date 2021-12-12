
class User{
  int? age;
  String? displayName;
  String? avatar150;
  String? dateOfBirth;
  String? fullName;
  String? gender;
  double? height;
  double? weight;

  User({
    this.age,
    this.displayName,
    this.avatar150,
    this.dateOfBirth,
    this.fullName,
    this.gender,
    this.height,
    this.weight
  });

  factory User.fromJsonMap(Map<String, dynamic> json) => User(
    age: json['age'],
    displayName: json["displayName"],
    avatar150: json["avatar150"],
    dateOfBirth: json["dateOfBirth"],
    fullName: json["fullName"],
    gender: json["gender"],
    height: json["height"],
    weight: json["weight"]
  );
  @override
  String toString() {
    return "${this.fullName} Ha llegado";
  }
}
class UserModel {
  String? name;
  int? gender;
  int? age;
  bool? withoutValidator;
  List<String>? address;
  bool? checkTerm;

  UserModel({
    this.name,
    this.gender,
    this.age,
    this.withoutValidator,
    this.address,
    this.checkTerm,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'] as String?,
        gender: json['gender'] as int?,
        age: json['age'] as int?,
        withoutValidator: json['withoutValidator'] as bool?,
        address: json['address'] as List<String>?,
        checkTerm: json['checkTerm'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'gender': gender,
        'age': age,
        'withoutValidator': withoutValidator,
        'address': address,
        'checkTerm': checkTerm,
      };
}

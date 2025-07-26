class UserModel {
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  late String phone;
  String? photo;

  String get fullName {
    return '$firstName $lastName';
  }

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.photo,
  });

  UserModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['_id'];
    email = jsonData['email'];
    firstName = jsonData['firstName'];
    lastName = jsonData['lastName'];
    phone = jsonData['mobile'];
    photo = jsonData['photo'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': phone,
      'photo': photo,
    };
  }
}
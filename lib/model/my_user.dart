class MyUser {
  static const String collectionName = 'users';
  String id;
  String firstName;
  String lastName;
  String userName;
  String email;

  MyUser(
      {required this.email,
      required this.firstName,
      required this.id,
      required this.lastName,
      required this.userName});
  MyUser.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          firstName: json['firstName'] as String,
          email: json['email'] as String,
          lastName: json['lastName'] as String,
          userName: json['userName'] as String,
        );
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "email": email,
      "lastName": lastName,
      "userName": userName,
    };
  }
}

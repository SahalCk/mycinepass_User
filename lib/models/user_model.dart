class UserModel {
  String userName;
  String email;
  String phoneNumber;
  String password;
  String confirmPassword;

  UserModel(
      {required this.userName,
      required this.email,
      required this.phoneNumber,
      required this.password,
      required this.confirmPassword});
}

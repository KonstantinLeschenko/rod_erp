class User {

  late String userName;
  late String userPassword;
  late String userRole;

  User({
    required this.userName,
    required this.userPassword,
    required this.userRole
});

  setName(String name) {
    userName = name;
  }

  setPasswsord(String password) {
    userPassword = password;
  }

  setRole(String role) {
    userRole = role;
  }

}
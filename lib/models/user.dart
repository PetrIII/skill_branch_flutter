import "../string_util.dart";

enum LoginType { email, phone }

mixin UserUtils {
  String capitalize(String s) =>
      s[0].toUpperCase() + s.substring(1).toLowerCase();
}

class User with UserUtils {
  String email;
  String phone;
  String _lastName;
  String _firstName;
  LoginType _type;

  List<User> friends = [];

  User._({String firstName, String lastName, String phone, String email})
      : _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    print("User is created");
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception("User name is empty");
    if ((phone?.isEmpty ?? true) && (email?.isEmpty ?? true))
      throw Exception("phone or email is empty");
    return User._(
        firstName: _getFirstName(name),
        lastName: _getLastName(name),
        phone: phone == null ? "" : checkPhone(phone),
        email: email == null ? "" : checkEmail(email));
  }

  static String _getLastName(String userName) => userName.split(" ")[1];
  static String _getFirstName(String userName) => userName.split(" ")[0];

  static String checkPhone(String phone) {
    String pattern = r"^(?:[+0]?[0-9]{11})";
    phone = phone.replaceAll(RegExp("[^+\\d]"), "");
    if (phone == null || phone.isEmpty) {
      throw Exception("Enter don't empty phone number");
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception(
          "Enter a valid phone number starting with a + and containing 11 digits");
    }
    return phone;
  }

  static String checkEmail(String email) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    if (email == null || email.isEmpty) {
      throw Exception("Enter don't empty email");
    } else if (!RegExp(pattern).hasMatch(email)) {
      throw Exception("Email is not valid registerUserByPhone");
    }
    return email;
  }

  String get login {
    return _type == LoginType.phone ? phone : email;
  }

  String get name =>
      "${capitalize(_firstName)} ${capitalize(_lastName)}"; // _firstName + " ".capitalize(_lastName);

  @override
  bool operator ==(Object object) {
    if (object == null) {
      return false;
    }

    if (object is User) {
      return _firstName == object._firstName &&
          _lastName == object._lastName &&
          (phone == object.phone || email == object.email);
    }
  }

  void addFriends(Iterable<User> newfiends) {
    friends.addAll(newfiends);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  String get userinfo => '''
    name: $name
    email: $email
    firstName: $_firstName
    lastName: $_lastName
    friends: ${friends.toList()}
  ''';
/*
  @override
  String toString() {
    return '''
      name: $name
      email: $email
      friends: ${friends.toList()}
  ''';
  }*/
}

import 'models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);
    print(user.toString());
    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("A user with this name already exists");
    }
  }

  User registerUserByEmail(String fullName, String email) {
    User user = User(name: fullName, email: email);
    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw new Exception(
          'Exception(A user with this email already exists) registerUserByPhone');
    }
    return user;
  }

  User registerUserByPhone(String fullName, String phone) {
    User user = User(name: fullName, phone: phone);
    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw new Exception('A user with this phone already exists');
    }
    return user;
  }

  User getUserByLogin(String login) {
    if (users.containsKey(login)) {
      return users[login];
    } else {
      throw Exception("A user with this name already exists");
    }
  }

  User findUserInFriends(String fullName, User user) {
    var usr = getUserByLogin(fullName);
    var existFriend = usr.friends
        .firstWhere((element) => element == user, orElse: () => null);
    if (existFriend == null) {
      throw Exception("${user.login} is not a friend of the login");
    }
    return existFriend;
  }

  void setFriends(String login, Iterable<User> friends) {
    var usr = getUserByLogin(login);
    usr.addFriends(friends);
  }

  List<User> importUsers(List<String> fieldsArr) {
    List<User> users = [];
    fieldsArr.forEach((element) {
      var fields = element.replaceAll("\n", "").trim().split(";");
      if (fields.length < 3) {
        throw Exception("Not enough arguments");
      }
      var name = fields[0].trim();
      var email = fields[1].trim();
      var phone = fields[2].trim();
      User usr = User(name: name, email: email, phone: phone);
      users.add(usr);
    });
    return users;
  }
}

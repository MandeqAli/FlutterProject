import 'package:get/get.dart';

class AuthController extends GetxController {
  RxString currentUser = ''.obs;
  final Map<String, String> _users = {}; // email -> password

  bool signup(String name, String email, String password) {
    if (_users.containsKey(email)) return false; // user exists
    _users[email] = password;
    currentUser.value = name;
    return true;
  }

  bool login(String email, String password) {
    if (_users[email] == password) {
      return true;
    }
    return false;
  }
}

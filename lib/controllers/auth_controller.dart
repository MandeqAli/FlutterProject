import 'package:get/get.dart';

class AuthController extends GetxController {
  // ✅ store logged in user info
  final RxString currentUserName = ''.obs;
  final RxString currentUserEmail = ''.obs;
  final RxString currentUserPhone = ''.obs;

  // demo local users (email -> password)
  final Map<String, String> _users = {};

  bool signup(String name, String email, String password, {String phone = ""}) {
    if (_users.containsKey(email)) return false;
    _users[email] = password;

    // ✅ set logged-in user
    currentUserName.value = name;
    currentUserEmail.value = email;
    currentUserPhone.value = phone;

    return true;
  }

  bool login(String email, String password) {
    if (_users[email] == password) {
      // ✅ set logged-in user (name not known in demo)
      currentUserEmail.value = email;

      // If you don’t have name from backend yet, show email as fallback:
      if (currentUserName.value.isEmpty) {
        currentUserName.value = email.split("@").first;
      }
      return true;
    }
    return false;
  }

  void logout() {
    currentUserName.value = '';
    currentUserEmail.value = '';
    currentUserPhone.value = '';
  }
}

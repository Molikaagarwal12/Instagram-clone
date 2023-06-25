
import 'package:instagram_clone/resources/auth_repo.dart';
import 'package:flutter/foundation.dart';

import 'models/model.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthRepo _authRepo = AuthRepo();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authRepo.getUserDetails();
    _user = user;
    notifyListeners();
  }
}

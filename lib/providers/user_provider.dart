import 'package:flutter/material.dart';
import '/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    imageUrl: '',
    cart: [],
    wishList: [],
    searchHistory: [],
    returnList: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }

  // void addToHistory(String searchQuery) {
  //   _user.searchHistory!.add(searchQuery.trim());
  //   notifyListeners();
  // }
}

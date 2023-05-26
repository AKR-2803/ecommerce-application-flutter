import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  List<String>? suggestionList = [];

  List<String>? get getSuggetions => suggestionList;

  void addToSuggestions(String item) {
    suggestionList!.add(item);
    notifyListeners();
  }

  void removeFromSuggestions(String item) {
    suggestionList!.removeWhere((elem) => elem == item);
    notifyListeners();
  }
}

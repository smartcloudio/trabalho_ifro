import 'dart:math';

import 'package:flutter_app/data/dummy_users.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Users with ChangeNotifier {
  Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void remove(User user) {
    if (user != null || user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    } else {
      print("User is null can't remove this...");
    }
  }

  void put(User user) {
    if (user == null) {
      print("User is null....");
      return;
    }
    print("User is not null....");

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      print("User exist now update....");

      print(user.name);
      print(user.email);
      print(user.avatarUrl);
      print(user.id);

      _items.update(
          user.id,
          (_) => User(
                id: user.id,
                name: user.name,
                email: user.email,
                avatarUrl: user.avatarUrl,
              ));
    } else {
      print("User not exist now insert....");
      final id = Random().nextDouble().toString();

      _items.putIfAbsent(
          id,
          () => User(
                id: id,
                name: user.name,
                email: user.email,
                avatarUrl: user.avatarUrl,
              ));
    }
    notifyListeners();
  }
}

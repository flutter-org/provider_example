import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:provider_example/models/item_model.dart';

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  int get totalPrice => _items.length * 42;

  void add(Item item) {
    _items.add(item);

    /// 当模型发生改变并且需要更新 UI 的时候可以调用该方法
    notifyListeners();
  }

  void removeAll() {
    _items.clear();

    /// 当模型发生改变并且需要更新 UI 的时候可以调用该方法
    notifyListeners();
  }
}

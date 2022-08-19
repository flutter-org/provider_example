import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:provider_example/models/catalog.dart';

class CartModel extends ChangeNotifier {
  late CatalogModel _catalog;
  final List<int> _itemIds = [];

  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;

    /// 当模型发生改变并且需要更新 UI 的时候可以调用该方法
    notifyListeners();
  }

  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  int get totalPrice => items.fold(0, (total, current) => total + current.price);

  void add(Item item) {
    _itemIds.add(item.id);

    /// 当模型发生改变并且需要更新 UI 的时候可以调用该方法
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);

    /// 当模型发生改变并且需要更新 UI 的时候可以调用该方法
    notifyListeners();
  }
}

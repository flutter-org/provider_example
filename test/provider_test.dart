import 'package:flutter_test/flutter_test.dart';
import 'package:provider_example/models/cart_model.dart';
import 'package:provider_example/models/item_model.dart';

void main() {
  test('adding item increases total cost', () {
    final cart = CartModel();
    final startingPrice = cart.totalPrice;
    cart.addListener(() { 
      expect(cart.totalPrice, greaterThan(startingPrice));
    });
    cart.add(Item('Dash'));
  });
}

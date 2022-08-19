import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/models/cart.dart';
import 'package:provider_example/models/catalog.dart';
import 'package:provider_example/screens/cart.dart';
import 'package:provider_example/screens/catalog.dart';
import 'package:provider_example/screens/login.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontFamily: 'Corben',
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyLogin(),
          '/catalog': (context) => const MyCatalog(),
          '/cart': (context) => const MyCart(),
        },
      ),
    );
  }
}

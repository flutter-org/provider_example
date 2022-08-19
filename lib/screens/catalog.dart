import 'package:flutter/material.dart';
import 'package:provider_example/models/cart.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/models/catalog.dart';

class MyCatalog extends StatelessWidget {
  const MyCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// context.select<T，R>(R cb(T value))，允许 widget 只监听 T 上的一部分内容的改变。
    var isInCart = context.select<CartModel, bool>(
      (cart) => cart.items.contains(item),
    );
    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              /// context.read<T>()，直接返回 T，不会监听改变。
              var cart = context.read<CartModel>();
              /// 调用 add 方法
              cart.add(item);
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null;
        }),
      ),
      child: isInCart ? const Icon(Icons.check, semanticLabel: 'ADDED') : const Text('ADD'),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  const _MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        'Catalog',
        style: Theme.of(context).textTheme.headline1,
      ),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index);

  @override
  Widget build(BuildContext context) {
    /// context.select<T，R>(R cb(T value))，允许 widget 只监听 T 上的一部分内容的改变。
    var item = context.select<CatalogModel, Item>(
      (catalog) => catalog.getByPosition(index),
    );
    var textTheme = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            const SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

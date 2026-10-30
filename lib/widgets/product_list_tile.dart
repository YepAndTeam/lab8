import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductListTile extends StatelessWidget {
  final Product product;
  const ProductListTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      color: scheme.surface, // opaque, so red background doesn't show through
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: scheme.primaryContainer,
          child: Icon(Icons.shopping_bag, color: scheme.onPrimaryContainer),
        ),
        title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(product.category, style: const TextStyle(fontSize: 12)),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.star, size: 16, color: Colors.amber),
            Text(product.rating.toStringAsFixed(1)),
          ],
        ),
        trailing: Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
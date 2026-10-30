import 'dart:math';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/empty_state.dart';
import '../widgets/product_grid_card.dart';
import '../widgets/product_list_tile.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  static const _categories = ['Audio', 'Peripherals', 'Wearables', 'Accessories', 'Displays', 'Storage'];

  final Random _random = Random();
  late List<Product> _products;
  int _nextId = 11;
  bool _isGrid = false;

  @override
  void initState() {
    super.initState();
    _products = buildSeedProducts().toList(); // mutable copy
  }

  // ---------- Pull-to-Refresh ----------
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1500)); // fake network
    if (!mounted) return;
    final id = _nextId++;
    final newProduct = Product(
      id: id,
      title: 'New Product #$id',
      category: _categories[_random.nextInt(_categories.length)],
      rating: double.parse((3 + _random.nextDouble() * 2).toStringAsFixed(1)),
      price: double.parse((10 + _random.nextDouble() * 290).toStringAsFixed(2)),
    );
    setState(() => _products.insert(0, newProduct));
  }

  // ---------- Swipe-to-Delete + Undo ----------
  void _onDismissed(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index == -1) return;
    setState(() => _products.removeAt(index));

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('"${product.title}" removed'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              // restore at original index (clamped in case list shrank)
              _products.insert(min(index, _products.length), product);
            });
          },
        ),
      ),
    );
  }

  void _resetCatalog() {
    setState(() {
      _products = buildSeedProducts().toList();
      _nextId = 11;
    });
  }

  Widget _dismissible(Product product, Widget child, {double radius = 0}) {
    return Dismissible(
      key: ValueKey(product.id), // mandatory unique key
      direction: DismissDirection.endToStart, // right -> left
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete, color: Colors.white, size: 32),
      ),
      onDismissed: (_) => _onDismissed(product),
      child: child,
    );
  }

  Widget _buildList() {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(), // needed for refresh
      itemCount: _products.length,
      separatorBuilder: (_, __) => const Divider(height: 1, thickness: 0.5),
      itemBuilder: (context, i) {
        final p = _products[i];
        return _dismissible(p, ProductListTile(product: p));
      },
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: _products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, i) {
        final p = _products[i];
        return _dismissible(p, ProductGridCard(product: p), radius: 12);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Catalog (${_products.length})'),
        actions: [
          IconButton(
            tooltip: _isGrid ? 'Show list' : 'Show grid',
            icon: Icon(_isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => _isGrid = !_isGrid),
          ),
        ],
      ),
      body: _products.isEmpty
          ? EmptyState(onReset: _resetCatalog)
          : RefreshIndicator(
        onRefresh: _onRefresh,
        child: _isGrid ? _buildGrid() : _buildList(),
      ),
    );
  }
}
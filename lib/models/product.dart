class Product {
  final int id;
  final String title;
  final String category;
  final double rating;
  final double price;

  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.rating,
    required this.price,
  });
}

/// Initial seed data (also used by "Reset Catalog").
List<Product> buildSeedProducts() => const [
  Product(id: 1, title: 'Wireless Headphones', category: 'Audio', rating: 4.5, price: 59.99),
  Product(id: 2, title: 'Mechanical Keyboard', category: 'Peripherals', rating: 4.7, price: 89.50),
  Product(id: 3, title: 'Smart Watch', category: 'Wearables', rating: 4.2, price: 129.00),
  Product(id: 4, title: 'USB-C Hub', category: 'Accessories', rating: 4.0, price: 34.90),
  Product(id: 5, title: 'Gaming Mouse', category: 'Peripherals', rating: 4.6, price: 45.00),
  Product(id: 6, title: 'Bluetooth Speaker', category: 'Audio', rating: 4.3, price: 39.99),
  Product(id: 7, title: '4K Monitor', category: 'Displays', rating: 4.8, price: 299.00),
  Product(id: 8, title: 'Webcam HD', category: 'Accessories', rating: 3.9, price: 29.99),
  Product(id: 9, title: 'Portable SSD 1TB', category: 'Storage', rating: 4.9, price: 109.00),
  Product(id: 10, title: 'Fitness Band', category: 'Wearables', rating: 4.1, price: 24.50),
];
class Product {
  final String id;
  final String title;
  final String image;
  final String ingredients;
  final double price;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.ingredients,
    required this.price,
    this.rating = 0.0,
  });
}

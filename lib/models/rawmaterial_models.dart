class RawMaterial {
  final double weight;
  final double length;
  final double price;
  final String name;

  RawMaterial({
    required this.weight,
    required this.length,
    required this.price,
    required this.name,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'length': length,
      'price': price,
      'weight': weight,
    };
  }
}

class FoodItem {
  final String id;
  final String name;
  final int price;
  // final String type;
  // final String image;

  // FoodItem({required this.id, required this.name, required this.price,  this.type,  this.image});
  FoodItem({required this.id, required this.name, required this.price});

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      // 'type': type,
      // 'image': image,
    };
  }

}
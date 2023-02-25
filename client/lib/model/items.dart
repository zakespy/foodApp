class Item {
  final String name;
  final String unit;
  final int price;
  final String image;
  int quantity;

  Item({required this.name, required this.unit, required this.price, required this.image, required this.quantity});

  Map toJson() {
    return {
      'name': name,
      'unit': unit,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  void addQuantity(){
    quantity += quantity;
  }

}
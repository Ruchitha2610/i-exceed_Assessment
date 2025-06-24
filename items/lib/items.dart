class Item {
  String? name;
  String? type;
  String? image;
  Item({this.name, this.type, this.image});
}

List obj = [
  Item(
    name: "Ice cream",
    type: "Medium-sized",
    image: "assets/images/things/icecream.jpeg",
  ),
  Item(
    name: "Vegetables",
    type: "Fresh",
    image: "assets/images/things/vegetables.jpeg",
  ),
  Item(
    name: "Fruits",
    type: "Sweet",
    image: "assets/images/things/fruits.jpeg",
  ),
  Item(
    name: "Biscuits",
    type: "All types",
    image: "assets/images/things/biscuit.jpeg",
  ),
];

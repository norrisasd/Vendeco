class AvailableItems {
  String? item, product_name, price, dispense_time, quality_left;

  AvailableItems(
      {this.item,
      this.product_name,
      this.price,
      this.dispense_time,
      this.quality_left});
}

List<AvailableItems> demoAvailableItems = [
  AvailableItems(
      item: "1",
      product_name: "Shampoo",
      price: "\$10/XML",
      dispense_time: "30 sec",
      quality_left: "5"),
  AvailableItems(
      item: "4",
      product_name: "Shampoo",
      price: "\$10/XML",
      dispense_time: "30 sec",
      quality_left: "5"),
  AvailableItems(
      item: "5",
      product_name: "Shampoo",
      price: "\$10/XML",
      dispense_time: "30 sec",
      quality_left: "5"),
  AvailableItems(
      item: "6",
      product_name: "Shampoo",
      price: "\$10/XML",
      dispense_time: "30 sec",
      quality_left: "5"),
];

import 'package:flutter/material.dart';

class Sales {
  final String? title, total;

  Sales({this.title, this.total});
}

List demoSales = [
  Sales(title: "Shampoo", total: "P0.00"),
  Sales(title: "Hair Conditioner", total: "P0.00"),
  Sales(title: "Liquid Detergent", total: "P0.00"),
  Sales(title: "Fabric Conditioner", total: "P0.00"),
];

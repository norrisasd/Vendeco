// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class VendecoTransaction {
  final String? date, product_name, input_amount, dispensed_mL, price;

  VendecoTransaction(
      {this.date,
      this.input_amount,
      this.product_name,
      this.dispensed_mL,
      this.price});

  @override
  String toString() {
    return 'VendecoTransaction(date: $date, product_name: $product_name, input_amount: $input_amount, dispensed_mL: $dispensed_mL, price: $price)';
  }
}

List demoTransactions = [
  VendecoTransaction(
      date: "2021-09-01",
      product_name: "Coca-Cola",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-03",
      product_name: "Sprite",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-05",
      product_name: "Royal",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-02",
      product_name: "RC",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-02",
      product_name: "RC",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-02",
      product_name: "RC",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-01",
      product_name: "Coca-Cola",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-03",
      product_name: "Sprite",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-05",
      product_name: "Royal",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-02",
      product_name: "RC",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-02",
      product_name: "RC",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-02",
      product_name: "RC",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-01",
      product_name: "Coca-Cola",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-03",
      product_name: "Sprite",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-05",
      product_name: "Royal",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-02",
      product_name: "RC",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-02",
      product_name: "RC",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
  VendecoTransaction(
      date: "2021-09-02",
      product_name: "RC",
      input_amount: "1000",
      dispensed_mL: "1000",
      price: "10"),
];

import 'dart:async';

class MenuItem {
  final String name;
  final double price;

  MenuItem({required this.name, required this.price});
}

class MenuRepository {
  Future<List<MenuItem>> fetchMenu() async {
    await Future.delayed(const Duration(seconds: 2));

    return [
      MenuItem(name: "Burger", price: 5.99),
      MenuItem(name: "Pizza", price: 8.49),
      MenuItem(name: "Pasta", price: 6.75),
      MenuItem(name: "Salad", price: 4.50),
    ];
  }
}
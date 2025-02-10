// transaction_model.dart
class Transaction {
  String itemName;
  String itemPrice;
  String itemDescription;

  Transaction({
    required this.itemName,
    required this.itemPrice,
    required this.itemDescription, required int quantity,
  });

  get quantity => null;
}

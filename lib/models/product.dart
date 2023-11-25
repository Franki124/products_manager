class Product {
  String? id;
  String? name;
  String? description;
  int? price;
  List<Map<String, String>>? history;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.history,
  });

  static Map<String, String> createHistoryEntry(String action, String details) {
    return {
      'timestamp': DateTime.now().toIso8601String(),
      'action': action,
      'details': details,
    };
  }

  void addHistoryEntry(String action, String details) {
    history = history ?? [];
    history!.add(Product.createHistoryEntry(action, details));
  }
}

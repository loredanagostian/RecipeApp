class Ingredient {
  final String id;
  final String name;
  final String amount;
  final String unit;

  const Ingredient({
    required this.id,
    required this.name,
    required this.amount,
    required this.unit,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'].toString(),
      name: json['nameClean'],
      amount: json['amount'].toString(),
      unit: json['unit'],
    );
  }
}

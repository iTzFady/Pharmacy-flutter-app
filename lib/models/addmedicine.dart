class Medicine {
  String name;
  String api;
  String date;
  String expDate;
  int quantity;
  int code;
  int sold;
  Medicine({
    required this.name,
    required this.api,
    required this.date,
    required this.code,
    required this.expDate,
    required this.quantity,
    required this.sold,
  });
  Medicine.fromJson(Map<String, Object?> json)
    : this(
        name: json['Name']! as String,
        api: json['API']! as String,
        date: json['Date']! as String,
        expDate: json['Expiration Date']! as String,
        quantity: json['Quantity']! as int,
        code: json['Code']! as int,
        sold: json['Sold']! as int,
      );
  Medicine copyWith({
    String? name,
    String? api,
    String? date,
    String? expDate,
    int? quantity,
    int? code,
    int? sold,
  }) {
    return Medicine(
      name: name ?? this.name,
      api: api ?? this.api,
      date: date ?? this.date,
      code: code ?? this.code,
      expDate: expDate ?? this.expDate,
      quantity: quantity ?? this.quantity,
      sold: sold ?? this.sold,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'Name': name,
      'API': api,
      'Date': date,
      'Expiration Date': expDate,
      'Quantity': quantity,
      'Code': code,
      'Sold': sold,
    };
  }
}

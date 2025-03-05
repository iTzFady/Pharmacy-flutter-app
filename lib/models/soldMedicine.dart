class Soldmedicine {
  String productName;
  String paitientName;
  String api;
  String date;
  int code;
  int sold;
  Soldmedicine({
    required this.productName,
    required this.api,
    required this.date,
    required this.code,
    required this.paitientName,
    required this.sold,
  });
  Soldmedicine.fromJson(Map<String, Object?> json)
    : this(
        productName: json['Product Name']! as String,
        api: json['API']! as String,
        date: json['Purchase Date']! as String,
        paitientName: json['Paitient Name']! as String,
        code: json['Code']! as int,
        sold: json['Sold']! as int,
      );
  Soldmedicine copyWith({
    String? productName,
    String? api,
    String? date,
    String? paitentName,
    int? code,
    int? sold,
  }) {
    return Soldmedicine(
      paitientName: paitientName ?? this.paitientName,
      api: api ?? this.api,
      date: date ?? this.date,
      code: code ?? this.code,
      productName: productName ?? this.productName,
      sold: sold ?? this.sold,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'Paitient Name': paitientName,
      'API': api,
      'Purchase Date': date,
      'Product Name': productName,
      'Code': code,
      'Sold': sold,
    };
  }
}

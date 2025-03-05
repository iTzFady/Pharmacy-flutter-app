class Requestedmedicine {
  String medicineName;
  String patientName;
  int quantity;

  Requestedmedicine({
    required this.medicineName,
    required this.patientName,
    required this.quantity,
  });
  Requestedmedicine.fromJson(Map<String, Object?> json)
    : this(
        medicineName: json['Medicine name']! as String,
        patientName: json['Patient name']! as String,
        quantity: json['Quantity']! as int,
      );
  Requestedmedicine copyWith({
    String? medicineName,
    String? patientName,
    int? quantity,
  }) {
    return Requestedmedicine(
      medicineName: medicineName ?? this.medicineName,
      patientName: patientName ?? this.patientName,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'Medicine name': medicineName,
      'Patient name': patientName,
      'Quantity': quantity,
    };
  }
}

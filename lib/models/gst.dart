class Gst {
  final String name;
  final String gstNumber;
  final String payerType;
  final String businessType;
  final String status;
  final String address;
  final String registrationDate;

  Gst({
    required this.name,
    required this.gstNumber,
    required this.payerType,
    required this.businessType,
    required this.status,
    required this.address,
    required this.registrationDate,
  });

  factory Gst.fromJson(Map<String, dynamic> json) {
    return Gst(
      name: json['name'],
      gstNumber: json['id'],
      payerType: json['payer_type'],
      businessType: json['business_type'],
      status: json['status'],
      address: json['address'],
      registrationDate: json['registration_date'],
    );
  }
}

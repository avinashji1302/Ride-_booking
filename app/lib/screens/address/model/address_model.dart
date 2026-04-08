class AddressModel {
  final String id;
  final String addressType;
  final String zipCode;
  final String latitude;
  final String longitude;
  final String completeAddress;
  final bool defaultAddress;
  final String floor;
  final String howToReach;
  final String area;

  AddressModel({
    required this.id,
    required this.addressType,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
    required this.completeAddress,
    required this.defaultAddress,
    required this.floor,
    required this.howToReach,
    required this.area,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    try {
      final coordinates =
          json['location']?['coordinates'] as List? ?? [];

      String lat = "";
      String lng = "";

      if (coordinates.length >= 2) {
        lng = coordinates[0].toString();
        lat = coordinates[1].toString();
      }

      return AddressModel(
        id: json['_id']?.toString() ?? "",
        addressType: json['addressType']?.toString() ?? "",
        zipCode: json['zipCode']?.toString() ?? "",
        latitude: lat,
        longitude: lng,
        completeAddress: json['completeAddress']?.toString() ?? "",
        defaultAddress: json['defaultAddress'] ?? false,
        floor: json['floor']?.toString() ?? "",
        howToReach: json['howToReach']?.toString() ?? "",
        area: json['area']?.toString() ?? "",
      );
    } catch (e) {
      throw Exception("Address parsing failed: $e");
    }
  }
}
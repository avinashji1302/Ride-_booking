class UpiPayemntResponseModel {
  final UpiDetails? upi;

  UpiPayemntResponseModel({this.upi});

  factory UpiPayemntResponseModel.fromJson(Map<String, dynamic> json) {
    return UpiPayemntResponseModel(
      upi: json['upi'] != null ? UpiDetails.fromJson(json['upi']) : null,
    );
  }
}

class UpiDetails {
  final String upiId;
  final String qrCode;

  UpiDetails({
    required this.upiId,
    required this.qrCode,
  });

  factory UpiDetails.fromJson(Map<String, dynamic> json) {
    return UpiDetails(
      upiId: json['upiId'] ?? '',
      qrCode: json['qrCode'] ?? '',
    );
  }
}
class EstimatedFare {
  final String vehicleType;
  final double estimatedFare;

  EstimatedFare({
    required this.vehicleType,
    required this.estimatedFare,
  });

  factory EstimatedFare.fromJson(Map<String, dynamic> json) {
    return EstimatedFare(
      vehicleType: json['vehicleType'],
      estimatedFare: (json['estimatedFare'] as num).toDouble(),
    );
  }
}

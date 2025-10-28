class Booking {
  final num id;
  final String carImage;
  final String carName;
  final String carCategory;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final bool rated;

  Booking({
    required this.id,
    required this.carImage,
    required this.carName,
    required this.carCategory,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.rated,
  });
}

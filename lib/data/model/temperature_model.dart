class Temperature {
  final String roomId;
  final double temperature;
  final DateTime timestamp;

  Temperature({
    required this.roomId,
    required this.temperature,
    required this.timestamp,
  });

  bool get isSafe => temperature >= -20 && temperature <= -16;
}

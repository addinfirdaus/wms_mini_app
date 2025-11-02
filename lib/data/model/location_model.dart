class LocationModel {
  final String id;
  final String label;
  final int capacity;
  final int currentLoad;

  bool get isFull => currentLoad >= capacity;

  LocationModel({
    required this.id,
    required this.label,
    required this.capacity,
    required this.currentLoad,
  });
}

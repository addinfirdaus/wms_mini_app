import 'location_model.dart';

class InventoryItem {
  final String sku;
  final String batch;
  final DateTime expiry;
  final int qty;
  final LocationModel location;

  InventoryItem({
    required this.sku,
    required this.batch,
    required this.expiry,
    required this.qty,
    required this.location,
  });

  bool get isNearExpiry =>
      expiry.isBefore(DateTime.now().add(const Duration(days: 30)));
}

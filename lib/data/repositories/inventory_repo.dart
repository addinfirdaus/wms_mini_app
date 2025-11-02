import 'package:riverpod/legacy.dart';
import '../model/inventory_item_model.dart';

final inventoryRepositoryProvider =
StateNotifierProvider<InventoryRepository, List<InventoryItem>>(
        (ref) => InventoryRepository());

class InventoryRepository extends StateNotifier<List<InventoryItem>> {
  InventoryRepository() : super([]);

  void addItem(InventoryItem item) {
    state = [...state, item];
  }

  List<InventoryItem> search(String query) {
    if (query.isEmpty) return state;
    return state
        .where((e) =>
    e.sku.toLowerCase().contains(query.toLowerCase()) ||
        e.location.id.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

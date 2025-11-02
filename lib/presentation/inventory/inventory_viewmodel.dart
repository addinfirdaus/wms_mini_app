import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../data/repositories/inventory_repo.dart';
import '../../data/model/inventory_item_model.dart';

final inventorySearchQueryProvider = StateProvider<String>((ref) => '');

final filteredInventoryProvider = Provider<List<InventoryItem>>((ref) {
  final query = ref.watch(inventorySearchQueryProvider);
  final repo = ref.watch(inventoryRepositoryProvider);
  return repo
      .where((e) =>
  e.sku.toLowerCase().contains(query.toLowerCase()) ||
      e.location.id.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

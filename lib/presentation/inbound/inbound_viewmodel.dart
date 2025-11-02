import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../data/repositories/inventory_repo.dart';
import '../../../data/repositories/mock_api.dart';
import '../../data/model/inventory_item_model.dart';
import '../../data/model/location_model.dart';

final locationsProvider = FutureProvider<List<LocationModel>>((ref) async {
  final api = MockApi();
  return api.getLocations();
});

class InboundForm {
  String sku = '';
  String batch = '';
  DateTime? expiry;
  int qty = 0;
  LocationModel? location;
}

final inboundFormProvider = StateProvider<InboundForm>((ref) => InboundForm());

final inboundSubmitProvider = Provider((ref) {
  return () {
    final form = ref.read(inboundFormProvider);
    final repo = ref.read(inventoryRepositoryProvider.notifier);

    if (form.location == null ||
        form.sku.isEmpty ||
        form.batch.isEmpty ||
        form.expiry == null ||
        form.qty <= 0) {
      throw Exception('Semua field wajib diisi & valid!');
    }

    if (form.location!.isFull) {
      throw Exception('Lokasi penuh!');
    }

    repo.addItem(InventoryItem(
      sku: form.sku,
      batch: form.batch,
      expiry: form.expiry!,
      qty: form.qty,
      location: form.location!,
    ));
  };
});

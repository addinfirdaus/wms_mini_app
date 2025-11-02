import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_badge.dart';
import 'inventory_viewmodel.dart';

class InventoryPage extends ConsumerWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(filteredInventoryProvider);
    final query = ref.watch(inventorySearchQueryProvider);

    Future<void> refresh() async {
      ref.invalidate(filteredInventoryProvider);
      await Future.delayed(const Duration(milliseconds: 300));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search by SKU or Location',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) =>
              ref.read(inventorySearchQueryProvider.notifier).state = v,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: RefreshIndicator(
                onRefresh: refresh,
                child: items.isEmpty
                    ? ListView(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text('No inventory data'),
                      ),
                    ),
                  ],
                )
                    : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    final item = items[i];
                    return Card(
                      child: ListTile(
                        title: Text(
                          item.sku,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Batch: ${item.batch}\n"
                              "Qty: ${item.qty}\n"
                              "Loc: ${item.location.id}\n"
                              "Exp: ${item.expiry.toShortDate()}",
                        ),
                        trailing: item.isNearExpiry
                            ? const CustomBadge(
                          label: "Near Expiry",
                          color: Colors.orange,
                        )
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

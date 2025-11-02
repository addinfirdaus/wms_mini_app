import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/model/location_model.dart';
import 'inbound_viewmodel.dart';

class InboundPage extends ConsumerWidget {
  const InboundPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(inboundFormProvider);
    final locations = ref.watch(locationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbound Form'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: 'Simulasi Scan',
            onPressed: () async {
              final result = await Navigator.pushNamed(context, '/fake_scanner');
              if (result != null && context.mounted) {
                final data = result as Map<String, dynamic>;
                ref.read(inboundFormProvider.notifier).state = InboundForm()
                  ..sku = data['sku']
                  ..batch = data['batch']
                  ..qty = data['qty']
                  ..expiry = data['expiry']
                  ..location = data['location'];
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("✅ Scan berhasil! Data otomatis terisi.")),
                );
              }
            },
          ),

        ],
      ),
      body: locations.when(
        data: (locs) => Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'SKU'),
                initialValue: form.sku,
                onChanged: (v) => form.sku = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Batch'),
                onChanged: (v) => form.batch = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (v) => form.qty = int.tryParse(v) ?? 0,
              ),
              const SizedBox(height: 12),
              InputDatePickerFormField(
                fieldLabelText: "Expiry Date",
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                onDateSubmitted: (v) => form.expiry = v,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<LocationModel>(
                decoration: const InputDecoration(labelText: "Location"),
                items: locs
                    .map((l) => DropdownMenuItem(
                  enabled: !l.isFull,
                  value: l,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l.label),
                      if (l.isFull)
                        const Text("Penuh",
                            style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ))
                    .toList(),
                onChanged: (v) => form.location = v,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  try {
                    ref.read(inboundSubmitProvider)();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Inbound sukses!")),
                    );
                    Navigator.pushReplacementNamed(context, '/inventory');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_mini_app/presentation/dashboard/dashboard_page.dart';
import 'package:wms_mini_app/presentation/inbound/fake_scanner_page.dart';
import 'package:wms_mini_app/presentation/inbound/inbound_page.dart';
import 'package:wms_mini_app/presentation/inventory/inventory_page.dart';

void main() {
  runApp(const ProviderScope(child: ColdStorageApp()));
}

class ColdStorageApp extends StatelessWidget {
  const ColdStorageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ColdStorage WMS',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      routes: {
        '/': (_) => const DashboardPage(),
        '/inbound': (_) => const InboundPage(),
        '/inventory': (_) => const InventoryPage(),
        '/fake_scanner': (_) => const FakeScannerPage(), // 👈 Tambah ini

      },
    );
  }
}

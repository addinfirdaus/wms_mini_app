import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/custom_badge.dart';
import 'dashboard_viewmodel.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempsAsync = ref.watch(dashboardViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: tempsAsync.when(
        data: (temps) => RefreshIndicator(
          onRefresh: () async => ref.refresh(dashboardViewModelProvider),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                "Cold Room Temperatures",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...temps.map((t) {
                final badge = t.isSafe
                    ? const CustomBadge(label: "Safe", color: Colors.green)
                    : const CustomBadge(label: "Alert!", color: Colors.red);
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          t.roomId,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${t.temperature.toStringAsFixed(1)}°C",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: t.isSafe ? Colors.green : Colors.red,
                          ),
                        ),
                        const SizedBox(height: 8),
                        badge,
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.input),
                label: const Text("Inbound"),
                onPressed: () => Navigator.pushNamed(context, '/inbound'),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.list_alt),
                label: const Text("Inventory"),
                onPressed: () => Navigator.pushNamed(context, '/inventory'),
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

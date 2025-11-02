import 'dart:math';
import 'package:flutter/material.dart';
import '../../../data/repositories/mock_api.dart';

class FakeScannerPage extends StatefulWidget {
  const FakeScannerPage({super.key});

  @override
  State<FakeScannerPage> createState() => _FakeScannerPageState();
}

class _FakeScannerPageState extends State<FakeScannerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Simulasikan proses "scan" selama 3 detik
    Future.delayed(const Duration(seconds: 3), () async {
      final random = Random();
      final locations = await MockApi().getLocations();
      final availableLocs = locations.where((l) => !l.isFull).toList();
      final randomLoc = (availableLocs..shuffle()).firstOrNull ?? locations.first;

      final fakeData = {
        'sku': 'SKU-${1000 + random.nextInt(9000)}',
        'batch':
        'BATCH-${String.fromCharCode(65 + random.nextInt(26))}${random.nextInt(99)}',
        'qty': 10 + random.nextInt(90),
        'expiry': DateTime.now().add(Duration(days: 5 + random.nextInt(120))),
        'location': randomLoc,
      };

      if (mounted) {
        Navigator.pop(context, fakeData);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fake Scanner')),
      body: Stack(
        children: [
          Container(
            color: Colors.black87,
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              return Align(
                alignment: Alignment(0, (2 * _animation.value) - 1),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  height: 3,
                  color: Colors.redAccent,
                ),
              );
            },
          ),
          const Center(
            child: Text(
              "Scanning...",
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

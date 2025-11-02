import 'dart:math';

import '../model/location_model.dart';
import '../model/temperature_model.dart';

class MockApi {
  final Random _rnd = Random();

  Future<List<Temperature>> getTemperatures() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      Temperature(roomId: "COLD-01", temperature: -18.3 + _rnd.nextDouble() * 2 - 1, timestamp: DateTime.now()),
      Temperature(roomId: "COLD-02", temperature: -17.0 + _rnd.nextDouble() * 2 - 1, timestamp: DateTime.now()),
      Temperature(roomId: "COLD-03", temperature: -19.5 + _rnd.nextDouble() * 2 - 1, timestamp: DateTime.now()),
    ];
  }

  Future<List<LocationModel>> getLocations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      LocationModel(id: "A1-01", label: "Zone A / Rack 1 / Slot 01", capacity: 100, currentLoad: 72),
      LocationModel(id: "A1-02", label: "Zone A / Rack 1 / Slot 02", capacity: 120, currentLoad: 120),
      LocationModel(id: "B2-05", label: "Zone B / Rack 2 / Slot 05", capacity: 80, currentLoad: 30),
    ];
  }
}

import 'package:riverpod/riverpod.dart';

import '../../../data/repositories/mock_api.dart';
import '../../data/model/temperature_model.dart';

final dashboardViewModelProvider =
StreamProvider.autoDispose<List<Temperature>>((ref) async* {
  final api = MockApi();
  while (true) {
    final temps = await api.getTemperatures();
    yield temps;
    await Future.delayed(const Duration(seconds: 5));
  }
});

import 'package:flutter/foundation.dart';
import 'package:sleeptracker/repositories/sleep_records_repo.dart';

class RecordsListNotifier extends ChangeNotifier {
  final SleepRecordsRepo _sleepRecordsRepo;
  final List<SleepRecord> _recordsList;

  RecordsListNotifier(this._sleepRecordsRepo) : _recordsList = [];

  bool _loading = true;
  bool _hasError = false;

  bool get isLoading => _loading;
  bool get hasError => _hasError;
  List<SleepRecord> get records => _recordsList;

  Future<void> loadRecords() async {
    try {
      final records = await _sleepRecordsRepo.getRecords();
      _recordsList.addAll(records);
    } catch (error) {
      debugPrint('$error');
      _hasError = true;
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> removeRecord(int recordId) async {
    await _sleepRecordsRepo.removeRecord(recordId);
    _recordsList.removeWhere((record) => record.id == recordId);
    notifyListeners();
  }
}

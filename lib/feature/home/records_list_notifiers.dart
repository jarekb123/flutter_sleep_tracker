import 'package:flutter/foundation.dart';
import 'package:sleeptracker/repositories/sleep_records_repo.dart';

class RecordsListNotifier extends ChangeNotifier {
  final SleepRecordsRepo _sleepRecordsRepo;
  final List<SleepRecord> _recordsList;

  RecordsListNotifier(this._sleepRecordsRepo) : _recordsList = [];

  List<SleepRecord> get records => _recordsList;

  Future<void> loadRecords() async {
    final records = await _sleepRecordsRepo.getRecords();
    _recordsList.addAll(records);
    notifyListeners();
  }

  Future<void> removeRecord(int recordId) async {
    await _sleepRecordsRepo.removeRecord(recordId);
    _recordsList.removeWhere((record) => record.id == recordId);
    notifyListeners();
  }
}

import 'package:sleeptracker/repositories/sleep_records_repo.dart';

class MemorySleepRecordsRepo implements SleepRecordsRepo {
  final _recordsList = <SleepRecord>[];

  @override
  Future<void> addRecord(
      DateTime createdAt, Duration duration, SleepType sleepType) async {
    _recordsList.add(SleepRecord(
      id: _nextId(),
      createdAt: createdAt,
      duration: duration,
      sleepType: sleepType,
    ));
  }

  @override
  Future<Iterable<SleepRecord>> getRecords() async => _recordsList;

  @override
  Future<void> removeRecord(int id) async {
    _recordsList.removeWhere((record) => record.id == id);
  }

  int _nextId() {
    if (_recordsList.isEmpty) {
      return 1;
    } else {
      return _recordsList.last.id + 1;
    }
  }
}

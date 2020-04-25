import 'package:flutter/foundation.dart';
import 'package:sleeptracker/repositories/sleep_records_repo.dart';
import 'package:sleeptracker/utils/date_utils.dart';

enum AddRecordState { idle, loading, success, error }

class AddRecordNotifier extends ChangeNotifier {
  final SleepRecordsRepo _sleepRecordsRepo;
  final DateTime _date;

  AddRecordNotifier(this._sleepRecordsRepo, DateUtils _dateUtils)
      : _date = _dateUtils.now(),
        _state = AddRecordState.idle;

  AddRecordState _state;

  DateTime get date => _date;
  AddRecordState get addState => _state;

  Future<void> add(SleepType sleepType, Duration sleepDuration) async {
    _state = AddRecordState.loading;
    notifyListeners();

    try {
      await _sleepRecordsRepo.addRecord(_date, sleepDuration, sleepType);
      _state = AddRecordState.success;
      notifyListeners();
    } catch (error) {
      _state = AddRecordState.error;
      notifyListeners();
    }
  }
}

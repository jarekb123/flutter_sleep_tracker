import 'package:freezed_annotation/freezed_annotation.dart';

part 'sleep_records_repo.freezed.dart';

abstract class SleepRecordsRepo {
  Future<Iterable<SleepRecord>> getRecords();

  Future<void> addRecord(
      DateTime createdAt, Duration duration, SleepType sleepType);
  
  Future<void> removeRecord(int id);
}

enum SleepType { night, nap }

@freezed
abstract class SleepRecord with _$SleepRecord {
  const factory SleepRecord({
    @required int id,
    @required DateTime createdAt,
    @required Duration duration,
    @required SleepType sleepType,
  }) = _SleepRecord;
}

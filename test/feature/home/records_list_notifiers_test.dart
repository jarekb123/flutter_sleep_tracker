import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sleeptracker/feature/home/records_list_notifiers.dart';
import 'package:sleeptracker/repositories/sleep_records_repo.dart';

class _MockSleepRecordsRepo extends Mock implements SleepRecordsRepo {}

SleepRecord _dummySleepRecord(int id) => SleepRecord(
      id: id,
      createdAt: DateTime(2020),
      duration: const Duration(),
      sleepType: SleepType.nap,
    );

void main() {
  group('RecordsListNotifier', () {
    _MockSleepRecordsRepo _mockSleepRecordsRepo;
    RecordsListNotifier recordsListNotifier;

    final recordsInRepo = [_dummySleepRecord(1), _dummySleepRecord(2)];

    setUp(() {
      _mockSleepRecordsRepo = _MockSleepRecordsRepo();
      recordsListNotifier = RecordsListNotifier(_mockSleepRecordsRepo);

      when(_mockSleepRecordsRepo.getRecords())
          .thenAnswer((_) => Future.value(recordsInRepo));
    });

    test('loadRecords fetches data from SleepRecordsRepo', () async {
      List<SleepRecord> records;
      recordsListNotifier.addListener(() {
        records = recordsListNotifier.records;
      });
      await recordsListNotifier.loadRecords();
      expect(records, recordsInRepo);
    });

    test('loadRecords propagates errors', () async {
      when(_mockSleepRecordsRepo.getRecords())
          .thenAnswer((_) => Future.error('error'));
      dynamic error;
      List<SleepRecord> records;
      try {
        recordsListNotifier.addListener(() {
          records = recordsListNotifier.records;
        });
        await recordsListNotifier.loadRecords();
      } catch (err) {
        error = err;
      }
      expect(records, isNull);
      expect(error, isNotNull);
    });

    test('removeRecord removes data from repository', () async {
      await recordsListNotifier.loadRecords();

      List<SleepRecord> records;
      recordsListNotifier.addListener(() {
        records = recordsListNotifier.records;
      });
      await recordsListNotifier.removeRecord(1);
      expect(records, [_dummySleepRecord(2)]);
    });

    test('removeRecord propagates errors', () async {
      when(_mockSleepRecordsRepo.removeRecord(any))
          .thenAnswer((_) => Future.error('error'));

      await recordsListNotifier.loadRecords();

      dynamic error;
      List<SleepRecord> records;
      try {
        recordsListNotifier.addListener(() {
          records = recordsListNotifier.records;
        });
        await recordsListNotifier.removeRecord(1);
      } catch (err) {
        error = err;
      }
      expect(records, isNull);
      expect(error, isNotNull);
    });
  });
}

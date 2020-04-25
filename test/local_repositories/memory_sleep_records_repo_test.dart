import 'package:flutter_test/flutter_test.dart';
import 'package:sleeptracker/local_repositories/memory_sleep_records_repo.dart';
import 'package:sleeptracker/repositories/sleep_records_repo.dart';

void main() {
  group('MemorySleepRecordsRepo', () {
    MemorySleepRecordsRepo memorySleepRecordsRepo;

    setUp(() {
      memorySleepRecordsRepo = MemorySleepRecordsRepo();
    });

    test('addRecord adds new record to the list', () async {
      expect(await memorySleepRecordsRepo.getRecords(), isEmpty);

      await memorySleepRecordsRepo.addRecord(
          DateTime(2020, 4, 24), const Duration(hours: 6), SleepType.nap);

      expect(
        await memorySleepRecordsRepo.getRecords(),
        [
          SleepRecord(
            id: 1,
            createdAt: DateTime(2020, 4, 24),
            duration: const Duration(hours: 6),
            sleepType: SleepType.nap,
          ),
        ],
      );
    });

    test('added record has id == lastRecord.id + 1', () async {
      await memorySleepRecordsRepo.addRecord(
          DateTime(2020, 4, 1), const Duration(seconds: 10), SleepType.night);

      final lastRecordId = (await memorySleepRecordsRepo.getRecords()).last.id;
      expect(lastRecordId, 1);

      await memorySleepRecordsRepo.addRecord(
          DateTime(2020, 4, 2), const Duration(hours: 10), SleepType.nap);

      final newRecordId = (await memorySleepRecordsRepo.getRecords()).last.id;
      expect(newRecordId, 2); // lastRecordId + 1
    });

    test('removeRecord removes record from records list', () async {
      await memorySleepRecordsRepo.addRecord(
          DateTime(2020, 4, 2), const Duration(hours: 10), SleepType.nap);
      await memorySleepRecordsRepo.addRecord(
          DateTime(2020, 4, 1), const Duration(seconds: 10), SleepType.night);

      expect(await memorySleepRecordsRepo.getRecords(), hasLength(2));

      await memorySleepRecordsRepo.removeRecord(1);
      final list = await memorySleepRecordsRepo.getRecords();
      expect(list, hasLength(1));
      expect(
        list.first,
        SleepRecord(
          id: 2,
          createdAt: DateTime(2020, 4, 1),
          duration: const Duration(seconds: 10),
          sleepType: SleepType.night,
        ),
      );
    });

    test('records are sorted by date (starting with latest)', () async {
      await memorySleepRecordsRepo.addRecord(
          DateTime(2020, 4, 1), const Duration(hours: 10), SleepType.nap);
      await memorySleepRecordsRepo.addRecord(DateTime(2020, 4, 1, 10),
          const Duration(seconds: 10), SleepType.night);

      final list = await memorySleepRecordsRepo.getRecords();
      expect(list, hasLength(2));
      expect(
        list,
        [
          SleepRecord(
            id: 2,
            createdAt: DateTime(2020, 4, 1, 10),
            duration: const Duration(seconds: 10),
            sleepType: SleepType.night,
          ),
          SleepRecord(
            id: 1,
            createdAt: DateTime(2020, 4, 1),
            duration: const Duration(hours: 10),
            sleepType: SleepType.nap,
          ),
        ],
      );
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sleeptracker/feature/add_record/add_record_notifiers.dart';
import 'package:sleeptracker/repositories/sleep_records_repo.dart';
import 'package:sleeptracker/utils/date_utils.dart';

class _MockSleepRecordsRepo extends Mock implements SleepRecordsRepo {}

class _MockDateUtils extends Mock implements DateUtils {}

void main() {
  group('AddRecordNotifier', () {
    final currentTime = DateTime(2020, 5, 5, 11, 15);

    _MockSleepRecordsRepo _mockSleepRecordsRepo;
    _MockDateUtils _mockDateUtils;
    AddRecordNotifier addRecordNotifier;

    setUp(() {
      _mockSleepRecordsRepo = _MockSleepRecordsRepo();
      _mockDateUtils = _MockDateUtils();
      when(_mockDateUtils.now()).thenReturn(currentTime);

      addRecordNotifier =
          AddRecordNotifier(_mockSleepRecordsRepo, _mockDateUtils);
    });

    test('date returns currentTime', () {
      expect(addRecordNotifier.date, currentTime);
    });

    test('init addState == idle', () {
      expect(addRecordNotifier.addState, AddRecordState.idle);
    });

    test('on succesful add() state changes to loading, then to success',
        () async {
      when(_mockSleepRecordsRepo.addRecord(
              currentTime, const Duration(), SleepType.nap))
          .thenAnswer((realInvocation) async => null);

      final expected = [AddRecordState.loading, AddRecordState.success];
      final states = <AddRecordState>[];
      addRecordNotifier.addListener(() {
        states.add(addRecordNotifier.addState);
      });

      await addRecordNotifier.add(SleepType.nap, const Duration());

      expect(states, expected);
    });

    test('on add() failure state changes to loading, then to error', () async {
      when(_mockSleepRecordsRepo.addRecord(
              currentTime, const Duration(), SleepType.nap))
          .thenAnswer((realInvocation) => Future.error('error'));

      final expected = [AddRecordState.loading, AddRecordState.error];
      final states = <AddRecordState>[];
      addRecordNotifier.addListener(() {
        states.add(addRecordNotifier.addState);
      });

      await addRecordNotifier.add(SleepType.nap, const Duration());

      expect(states, expected);
    });
  });
}

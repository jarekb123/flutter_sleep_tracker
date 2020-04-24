// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'sleep_records_repo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$SleepRecordTearOff {
  const _$SleepRecordTearOff();

  _SleepRecord call(
      {@required int id,
      @required DateTime createdAt,
      @required Duration duration,
      @required SleepType sleepType}) {
    return _SleepRecord(
      id: id,
      createdAt: createdAt,
      duration: duration,
      sleepType: sleepType,
    );
  }
}

// ignore: unused_element
const $SleepRecord = _$SleepRecordTearOff();

mixin _$SleepRecord {
  int get id;
  DateTime get createdAt;
  Duration get duration;
  SleepType get sleepType;

  $SleepRecordCopyWith<SleepRecord> get copyWith;
}

abstract class $SleepRecordCopyWith<$Res> {
  factory $SleepRecordCopyWith(
          SleepRecord value, $Res Function(SleepRecord) then) =
      _$SleepRecordCopyWithImpl<$Res>;
  $Res call(
      {int id, DateTime createdAt, Duration duration, SleepType sleepType});
}

class _$SleepRecordCopyWithImpl<$Res> implements $SleepRecordCopyWith<$Res> {
  _$SleepRecordCopyWithImpl(this._value, this._then);

  final SleepRecord _value;
  // ignore: unused_field
  final $Res Function(SleepRecord) _then;

  @override
  $Res call({
    Object id = freezed,
    Object createdAt = freezed,
    Object duration = freezed,
    Object sleepType = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      duration: duration == freezed ? _value.duration : duration as Duration,
      sleepType:
          sleepType == freezed ? _value.sleepType : sleepType as SleepType,
    ));
  }
}

abstract class _$SleepRecordCopyWith<$Res>
    implements $SleepRecordCopyWith<$Res> {
  factory _$SleepRecordCopyWith(
          _SleepRecord value, $Res Function(_SleepRecord) then) =
      __$SleepRecordCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id, DateTime createdAt, Duration duration, SleepType sleepType});
}

class __$SleepRecordCopyWithImpl<$Res> extends _$SleepRecordCopyWithImpl<$Res>
    implements _$SleepRecordCopyWith<$Res> {
  __$SleepRecordCopyWithImpl(
      _SleepRecord _value, $Res Function(_SleepRecord) _then)
      : super(_value, (v) => _then(v as _SleepRecord));

  @override
  _SleepRecord get _value => super._value as _SleepRecord;

  @override
  $Res call({
    Object id = freezed,
    Object createdAt = freezed,
    Object duration = freezed,
    Object sleepType = freezed,
  }) {
    return _then(_SleepRecord(
      id: id == freezed ? _value.id : id as int,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      duration: duration == freezed ? _value.duration : duration as Duration,
      sleepType:
          sleepType == freezed ? _value.sleepType : sleepType as SleepType,
    ));
  }
}

class _$_SleepRecord implements _SleepRecord {
  const _$_SleepRecord(
      {@required this.id,
      @required this.createdAt,
      @required this.duration,
      @required this.sleepType})
      : assert(id != null),
        assert(createdAt != null),
        assert(duration != null),
        assert(sleepType != null);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final Duration duration;
  @override
  final SleepType sleepType;

  @override
  String toString() {
    return 'SleepRecord(id: $id, createdAt: $createdAt, duration: $duration, sleepType: $sleepType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SleepRecord &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)) &&
            (identical(other.sleepType, sleepType) ||
                const DeepCollectionEquality()
                    .equals(other.sleepType, sleepType)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(sleepType);

  @override
  _$SleepRecordCopyWith<_SleepRecord> get copyWith =>
      __$SleepRecordCopyWithImpl<_SleepRecord>(this, _$identity);
}

abstract class _SleepRecord implements SleepRecord {
  const factory _SleepRecord(
      {@required int id,
      @required DateTime createdAt,
      @required Duration duration,
      @required SleepType sleepType}) = _$_SleepRecord;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  Duration get duration;
  @override
  SleepType get sleepType;
  @override
  _$SleepRecordCopyWith<_SleepRecord> get copyWith;
}

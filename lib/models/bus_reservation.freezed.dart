// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BusReservation _$BusReservationFromJson(Map<String, dynamic> json) {
  return _BusReservation.fromJson(json);
}

/// @nodoc
mixin _$BusReservation {
  int? get reservationId => throw _privateConstructorUsedError;
  set reservationId(int? value) => throw _privateConstructorUsedError;
  Customer get customer => throw _privateConstructorUsedError;
  set customer(Customer value) => throw _privateConstructorUsedError;
  BusSchedule get busSchedule => throw _privateConstructorUsedError;
  set busSchedule(BusSchedule value) => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  set timestamp(int value) => throw _privateConstructorUsedError;
  String get departureDate => throw _privateConstructorUsedError;
  set departureDate(String value) => throw _privateConstructorUsedError;
  int get totalSeatBooked => throw _privateConstructorUsedError;
  set totalSeatBooked(int value) => throw _privateConstructorUsedError;
  String get seatNumbers => throw _privateConstructorUsedError;
  set seatNumbers(String value) => throw _privateConstructorUsedError;
  String get reservationStatus => throw _privateConstructorUsedError;
  set reservationStatus(String value) => throw _privateConstructorUsedError;
  int get totalPrice => throw _privateConstructorUsedError;
  set totalPrice(int value) => throw _privateConstructorUsedError;

  /// Serializes this BusReservation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusReservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusReservationCopyWith<BusReservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusReservationCopyWith<$Res> {
  factory $BusReservationCopyWith(
          BusReservation value, $Res Function(BusReservation) then) =
      _$BusReservationCopyWithImpl<$Res, BusReservation>;
  @useResult
  $Res call(
      {int? reservationId,
      Customer customer,
      BusSchedule busSchedule,
      int timestamp,
      String departureDate,
      int totalSeatBooked,
      String seatNumbers,
      String reservationStatus,
      int totalPrice});

  $CustomerCopyWith<$Res> get customer;
  $BusScheduleCopyWith<$Res> get busSchedule;
}

/// @nodoc
class _$BusReservationCopyWithImpl<$Res, $Val extends BusReservation>
    implements $BusReservationCopyWith<$Res> {
  _$BusReservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusReservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservationId = freezed,
    Object? customer = null,
    Object? busSchedule = null,
    Object? timestamp = null,
    Object? departureDate = null,
    Object? totalSeatBooked = null,
    Object? seatNumbers = null,
    Object? reservationStatus = null,
    Object? totalPrice = null,
  }) {
    return _then(_value.copyWith(
      reservationId: freezed == reservationId
          ? _value.reservationId
          : reservationId // ignore: cast_nullable_to_non_nullable
              as int?,
      customer: null == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer,
      busSchedule: null == busSchedule
          ? _value.busSchedule
          : busSchedule // ignore: cast_nullable_to_non_nullable
              as BusSchedule,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      departureDate: null == departureDate
          ? _value.departureDate
          : departureDate // ignore: cast_nullable_to_non_nullable
              as String,
      totalSeatBooked: null == totalSeatBooked
          ? _value.totalSeatBooked
          : totalSeatBooked // ignore: cast_nullable_to_non_nullable
              as int,
      seatNumbers: null == seatNumbers
          ? _value.seatNumbers
          : seatNumbers // ignore: cast_nullable_to_non_nullable
              as String,
      reservationStatus: null == reservationStatus
          ? _value.reservationStatus
          : reservationStatus // ignore: cast_nullable_to_non_nullable
              as String,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of BusReservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerCopyWith<$Res> get customer {
    return $CustomerCopyWith<$Res>(_value.customer, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }

  /// Create a copy of BusReservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BusScheduleCopyWith<$Res> get busSchedule {
    return $BusScheduleCopyWith<$Res>(_value.busSchedule, (value) {
      return _then(_value.copyWith(busSchedule: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BusReservationImplCopyWith<$Res>
    implements $BusReservationCopyWith<$Res> {
  factory _$$BusReservationImplCopyWith(_$BusReservationImpl value,
          $Res Function(_$BusReservationImpl) then) =
      __$$BusReservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? reservationId,
      Customer customer,
      BusSchedule busSchedule,
      int timestamp,
      String departureDate,
      int totalSeatBooked,
      String seatNumbers,
      String reservationStatus,
      int totalPrice});

  @override
  $CustomerCopyWith<$Res> get customer;
  @override
  $BusScheduleCopyWith<$Res> get busSchedule;
}

/// @nodoc
class __$$BusReservationImplCopyWithImpl<$Res>
    extends _$BusReservationCopyWithImpl<$Res, _$BusReservationImpl>
    implements _$$BusReservationImplCopyWith<$Res> {
  __$$BusReservationImplCopyWithImpl(
      _$BusReservationImpl _value, $Res Function(_$BusReservationImpl) _then)
      : super(_value, _then);

  /// Create a copy of BusReservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservationId = freezed,
    Object? customer = null,
    Object? busSchedule = null,
    Object? timestamp = null,
    Object? departureDate = null,
    Object? totalSeatBooked = null,
    Object? seatNumbers = null,
    Object? reservationStatus = null,
    Object? totalPrice = null,
  }) {
    return _then(_$BusReservationImpl(
      reservationId: freezed == reservationId
          ? _value.reservationId
          : reservationId // ignore: cast_nullable_to_non_nullable
              as int?,
      customer: null == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer,
      busSchedule: null == busSchedule
          ? _value.busSchedule
          : busSchedule // ignore: cast_nullable_to_non_nullable
              as BusSchedule,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      departureDate: null == departureDate
          ? _value.departureDate
          : departureDate // ignore: cast_nullable_to_non_nullable
              as String,
      totalSeatBooked: null == totalSeatBooked
          ? _value.totalSeatBooked
          : totalSeatBooked // ignore: cast_nullable_to_non_nullable
              as int,
      seatNumbers: null == seatNumbers
          ? _value.seatNumbers
          : seatNumbers // ignore: cast_nullable_to_non_nullable
              as String,
      reservationStatus: null == reservationStatus
          ? _value.reservationStatus
          : reservationStatus // ignore: cast_nullable_to_non_nullable
              as String,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusReservationImpl implements _BusReservation {
  _$BusReservationImpl(
      {this.reservationId,
      required this.customer,
      required this.busSchedule,
      required this.timestamp,
      required this.departureDate,
      required this.totalSeatBooked,
      required this.seatNumbers,
      required this.reservationStatus,
      required this.totalPrice});

  factory _$BusReservationImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusReservationImplFromJson(json);

  @override
  int? reservationId;
  @override
  Customer customer;
  @override
  BusSchedule busSchedule;
  @override
  int timestamp;
  @override
  String departureDate;
  @override
  int totalSeatBooked;
  @override
  String seatNumbers;
  @override
  String reservationStatus;
  @override
  int totalPrice;

  @override
  String toString() {
    return 'BusReservation(reservationId: $reservationId, customer: $customer, busSchedule: $busSchedule, timestamp: $timestamp, departureDate: $departureDate, totalSeatBooked: $totalSeatBooked, seatNumbers: $seatNumbers, reservationStatus: $reservationStatus, totalPrice: $totalPrice)';
  }

  /// Create a copy of BusReservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusReservationImplCopyWith<_$BusReservationImpl> get copyWith =>
      __$$BusReservationImplCopyWithImpl<_$BusReservationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusReservationImplToJson(
      this,
    );
  }
}

abstract class _BusReservation implements BusReservation {
  factory _BusReservation(
      {int? reservationId,
      required Customer customer,
      required BusSchedule busSchedule,
      required int timestamp,
      required String departureDate,
      required int totalSeatBooked,
      required String seatNumbers,
      required String reservationStatus,
      required int totalPrice}) = _$BusReservationImpl;

  factory _BusReservation.fromJson(Map<String, dynamic> json) =
      _$BusReservationImpl.fromJson;

  @override
  int? get reservationId;
  set reservationId(int? value);
  @override
  Customer get customer;
  set customer(Customer value);
  @override
  BusSchedule get busSchedule;
  set busSchedule(BusSchedule value);
  @override
  int get timestamp;
  set timestamp(int value);
  @override
  String get departureDate;
  set departureDate(String value);
  @override
  int get totalSeatBooked;
  set totalSeatBooked(int value);
  @override
  String get seatNumbers;
  set seatNumbers(String value);
  @override
  String get reservationStatus;
  set reservationStatus(String value);
  @override
  int get totalPrice;
  set totalPrice(int value);

  /// Create a copy of BusReservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusReservationImplCopyWith<_$BusReservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

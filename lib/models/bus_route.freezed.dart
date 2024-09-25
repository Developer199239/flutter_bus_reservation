// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BusRoute _$BusRouteFromJson(Map<String, dynamic> json) {
  return _BusRoute.fromJson(json);
}

/// @nodoc
mixin _$BusRoute {
  int? get routeId => throw _privateConstructorUsedError;
  set routeId(int? value) => throw _privateConstructorUsedError;
  String get routeName => throw _privateConstructorUsedError;
  set routeName(String value) => throw _privateConstructorUsedError;
  String get cityFrom => throw _privateConstructorUsedError;
  set cityFrom(String value) => throw _privateConstructorUsedError;
  String get cityTo => throw _privateConstructorUsedError;
  set cityTo(String value) => throw _privateConstructorUsedError;
  double get distanceInKm => throw _privateConstructorUsedError;
  set distanceInKm(double value) => throw _privateConstructorUsedError;

  /// Serializes this BusRoute to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusRoute
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusRouteCopyWith<BusRoute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusRouteCopyWith<$Res> {
  factory $BusRouteCopyWith(BusRoute value, $Res Function(BusRoute) then) =
      _$BusRouteCopyWithImpl<$Res, BusRoute>;
  @useResult
  $Res call(
      {int? routeId,
      String routeName,
      String cityFrom,
      String cityTo,
      double distanceInKm});
}

/// @nodoc
class _$BusRouteCopyWithImpl<$Res, $Val extends BusRoute>
    implements $BusRouteCopyWith<$Res> {
  _$BusRouteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusRoute
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routeId = freezed,
    Object? routeName = null,
    Object? cityFrom = null,
    Object? cityTo = null,
    Object? distanceInKm = null,
  }) {
    return _then(_value.copyWith(
      routeId: freezed == routeId
          ? _value.routeId
          : routeId // ignore: cast_nullable_to_non_nullable
              as int?,
      routeName: null == routeName
          ? _value.routeName
          : routeName // ignore: cast_nullable_to_non_nullable
              as String,
      cityFrom: null == cityFrom
          ? _value.cityFrom
          : cityFrom // ignore: cast_nullable_to_non_nullable
              as String,
      cityTo: null == cityTo
          ? _value.cityTo
          : cityTo // ignore: cast_nullable_to_non_nullable
              as String,
      distanceInKm: null == distanceInKm
          ? _value.distanceInKm
          : distanceInKm // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusRouteImplCopyWith<$Res>
    implements $BusRouteCopyWith<$Res> {
  factory _$$BusRouteImplCopyWith(
          _$BusRouteImpl value, $Res Function(_$BusRouteImpl) then) =
      __$$BusRouteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? routeId,
      String routeName,
      String cityFrom,
      String cityTo,
      double distanceInKm});
}

/// @nodoc
class __$$BusRouteImplCopyWithImpl<$Res>
    extends _$BusRouteCopyWithImpl<$Res, _$BusRouteImpl>
    implements _$$BusRouteImplCopyWith<$Res> {
  __$$BusRouteImplCopyWithImpl(
      _$BusRouteImpl _value, $Res Function(_$BusRouteImpl) _then)
      : super(_value, _then);

  /// Create a copy of BusRoute
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routeId = freezed,
    Object? routeName = null,
    Object? cityFrom = null,
    Object? cityTo = null,
    Object? distanceInKm = null,
  }) {
    return _then(_$BusRouteImpl(
      routeId: freezed == routeId
          ? _value.routeId
          : routeId // ignore: cast_nullable_to_non_nullable
              as int?,
      routeName: null == routeName
          ? _value.routeName
          : routeName // ignore: cast_nullable_to_non_nullable
              as String,
      cityFrom: null == cityFrom
          ? _value.cityFrom
          : cityFrom // ignore: cast_nullable_to_non_nullable
              as String,
      cityTo: null == cityTo
          ? _value.cityTo
          : cityTo // ignore: cast_nullable_to_non_nullable
              as String,
      distanceInKm: null == distanceInKm
          ? _value.distanceInKm
          : distanceInKm // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusRouteImpl implements _BusRoute {
  _$BusRouteImpl(
      {this.routeId,
      required this.routeName,
      required this.cityFrom,
      required this.cityTo,
      required this.distanceInKm});

  factory _$BusRouteImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusRouteImplFromJson(json);

  @override
  int? routeId;
  @override
  String routeName;
  @override
  String cityFrom;
  @override
  String cityTo;
  @override
  double distanceInKm;

  @override
  String toString() {
    return 'BusRoute(routeId: $routeId, routeName: $routeName, cityFrom: $cityFrom, cityTo: $cityTo, distanceInKm: $distanceInKm)';
  }

  /// Create a copy of BusRoute
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusRouteImplCopyWith<_$BusRouteImpl> get copyWith =>
      __$$BusRouteImplCopyWithImpl<_$BusRouteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusRouteImplToJson(
      this,
    );
  }
}

abstract class _BusRoute implements BusRoute {
  factory _BusRoute(
      {int? routeId,
      required String routeName,
      required String cityFrom,
      required String cityTo,
      required double distanceInKm}) = _$BusRouteImpl;

  factory _BusRoute.fromJson(Map<String, dynamic> json) =
      _$BusRouteImpl.fromJson;

  @override
  int? get routeId;
  set routeId(int? value);
  @override
  String get routeName;
  set routeName(String value);
  @override
  String get cityFrom;
  set cityFrom(String value);
  @override
  String get cityTo;
  set cityTo(String value);
  @override
  double get distanceInKm;
  set distanceInKm(double value);

  /// Create a copy of BusRoute
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusRouteImplCopyWith<_$BusRouteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

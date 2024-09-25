import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';
@unfreezed
class Customer with _$Customer{
  factory Customer({
    int? customerId,
    required String customerName,
    required String mobile,
    required String email,
  }) = _Customer;
  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}

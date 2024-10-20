import 'package:flutter/material.dart';

import '../models/reservation_expansion_item.dart';
import '../utils/constants.dart';

class ReservationItemBodyView extends StatelessWidget {
  final ReservationExpansionBody body;
  const ReservationItemBodyView({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Customer Name: ${body.userInfoModel.customerName}'),
          Text('Customer Mobile: ${body.userInfoModel.mobile}'),
          Text('Customer Email: ${body.userInfoModel.email}'),
          Text('Total Seat: ${body.totalSeatedBooked}'),
          Text('Seat Numbers: ${body.seatNumbers}'),
          Text('Total Price: $currency${body.totalPrice}'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/reservation_expansion_item.dart';
import '../utils/constants.dart';

class ReservationItemBodyView extends StatelessWidget {
  final ReservationExpansionBody body;
  const ReservationItemBodyView({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Customer Name', body.userInfoModel.customerName),
            _buildDetailRow('Mobile', body.userInfoModel.mobile),
            _buildDetailRow('Email', body.userInfoModel.email),
            _buildDetailRow('Total Seat', '${body.totalSeatedBooked}'),
            _buildDetailRow('Seat Numbers', body.seatNumbers),
            _buildDetailRow('Total Price', '$currency${body.totalPrice}'),
          ],
        ),
      ),
    );
  }

  // Helper to build a key-value style row
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),  // Add vertical space between rows
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}

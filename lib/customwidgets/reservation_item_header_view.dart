import 'package:flutter/material.dart';

import '../models/reservation_expansion_item.dart';
import '../utils/helper_functions.dart';

class ReservationItemHeaderView extends StatelessWidget {
  final ReservationExpansionHeader header;
  const ReservationItemHeaderView({Key? key, required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),  // Card margin
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          '${header.departureDate} ${header.schedule.departureTime}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),  // Adjust spacing
            Text(
              '${header.schedule.busRoute.routeName} - ${header.schedule.bus.busType}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Booking Time: ${getFormattedDate(DateTime.fromMillisecondsSinceEpoch(header.timestamp), pattern: 'EEE MMM dd yyyy HH:mm')}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

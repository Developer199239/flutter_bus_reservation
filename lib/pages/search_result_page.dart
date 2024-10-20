import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../customwidgets/login_alert_dialog.dart';
import '../models/bus_route.dart';
import '../models/bus_schedule.dart';
import '../providers/app_data_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argList = ModalRoute
        .of(context)!
        .settings
        .arguments as List;
    final BusRoute route = argList[0];
    final String departureDate = argList[1];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Text(
            'Showing results for ${route.cityFrom} to ${route
                .cityTo} on $departureDate',
            style: const TextStyle(fontSize: 18),
          ),
          Consumer<AppDataProvider>(
            builder: (context, provider, _) =>
                FutureBuilder<List<BusSchedule>>(
                  future: provider.getSchedulesByRouteName(route.routeName),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final scheduleList = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: scheduleList
                            .map((schedule) =>
                            ScheduleItemView(
                                schedule: schedule, date: departureDate))
                            .toList(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Text('Failed to fetch data');
                    }
                    return const Text('Please wait');
                  },
                ),
          )
        ],
      ),
    );
  }
}

class ScheduleItemView extends StatelessWidget {
  final String date;
  final BusSchedule schedule;

  const ScheduleItemView({Key? key, required this.schedule, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        String userName = await getLoggedInUserName();
        if (userName.isEmpty) {
          showLoginAlertDialog(
            context: context,
            message: "Login as user",
            callback: () {
              Navigator.pushNamed(context, routeNameLoginPage);
            },
          );
        } else {
          Navigator.pushNamed(
              context, routeNameSeatPlanPage, arguments: [schedule, date]);
        }
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(schedule.bus.busName),
              subtitle: Text(schedule.bus.busType),
              trailing: Text('$currency${schedule.ticketPrice}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'From: ${schedule.busRoute.cityFrom}',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    'To: ${schedule.busRoute.cityTo}',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Departure Time: ${schedule.departureTime}',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    'Total Seat: ${schedule.bus.totalSeat}',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bus_reservation/models/bus_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../customwidgets/login_alert_dialog.dart';
import '../models/bus_model.dart';
import '../models/bus_schedule.dart';
import '../models/city_model.dart';
import '../providers/app_data_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  bool _isLoading = false;
  List<BusSchedule> _scheduleList = [];

  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    final appDataProvider =
    Provider.of<AppDataProvider>(context, listen: false);
    setState(() => _isLoading = true);
    try {
      final schedules = await appDataProvider.allSchedule();
      setState(() {
        _scheduleList = schedules;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading _scheduleList: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Schedule'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _showRouteDialog(isAddRoute: true);
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (_scheduleList.isEmpty)
            const Center(
              child: Text('No schedule available.'),
            )
          else
            ListView.builder(
              itemCount: _scheduleList.length,
              itemBuilder: (context, index) {
                final schedule = _scheduleList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        schedule.bus.busName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Route: ${schedule.busRoute.routeName}'),
                          Text('Price: ${schedule.ticketPrice}'),
                          Text('Discount: ${schedule.discount}'),
                          Text('processingFee: ${schedule.processingFee}'),
                          Text('DepartureTime: ${schedule.departureTime}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert),
                        // onPressed: () => _showBottomSheet(route),
                        onPressed: () => null,
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }


}

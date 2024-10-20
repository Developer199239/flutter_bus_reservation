import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../drawers/main_drawer.dart';
import '../models/bus_schedule.dart';
import '../providers/app_data_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class ScheduleListPage extends StatefulWidget {
  const ScheduleListPage({super.key});

  @override
  State<ScheduleListPage> createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  bool _isLoading = false;
  List<BusSchedule> _scheduleList = [];


  @override
  void didChangeDependencies() {
    _loadSchedules();
    super.didChangeDependencies();
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
      drawer: const MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigator.pushNamed(context, routeNameAddSchedulePage);
          final result = await Navigator.pushNamed(context, routeNameAddSchedulePage);
          if (result == true) {
            _loadSchedules(); // Reload the list when coming back
          }
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
                        onPressed: () => _showBottomSheet(schedule),
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

  void _showBottomSheet(BusSchedule busSchedule) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Update'),
                onTap: () async {
                  Navigator.pop(context);
                  // Navigator.pushNamed(context, routeNameAddSchedulePage,
                  //     arguments: [busSchedule]);
                  final result = await Navigator.pushNamed(
                    context,
                    routeNameAddSchedulePage,
                    arguments: [busSchedule],
                  );
                  if (result == true) {
                    _loadSchedules(); // Reload the list when updated
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  // _deleteBus(context, bus);
                  showMsg(context, "Under development!");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

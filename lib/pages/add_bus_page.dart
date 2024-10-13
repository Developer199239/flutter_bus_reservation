import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../customwidgets/login_alert_dialog.dart';
import '../models/bus_model.dart';
import '../providers/app_data_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class AddBusPage extends StatefulWidget {
  const AddBusPage({super.key});

  @override
  State<AddBusPage> createState() => _AddBusPageState();
}

class _AddBusPageState extends State<AddBusPage> {
  bool _isLoading = false;
  List<Bus> _buses = [];

  @override
  void initState() {
    super.initState();
    _loadBuses();
  }

  Future<void> _loadBuses() async {
    final appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    setState(() => _isLoading = true);
    try {
      final busList = await appDataProvider.getAllBusWithList();
      setState(() {
        _buses = busList;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading buses: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Buses'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBusDialog(isAddBus: true);
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (_buses.isEmpty)
            const Center(
              child: Text('No bus available.'),
            )
          else
            ListView.builder(
              itemCount: _buses.length,
              itemBuilder: (context, index) {
                final bus = _buses[index];
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
                        bus.busName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Type: ${bus.busType}'),
                          Text('Seats: ${bus.totalSeat}'),
                          Text('Bus Number: ${bus.busNumber}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () => _showBottomSheet(bus),
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

  void _showBottomSheet(Bus bus) {
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
                onTap: () {
                  Navigator.pop(context);
                  _showBusDialog(isAddBus: false, bus: bus);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  _deleteBus(context, bus);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteBus(BuildContext context, Bus bus) async {
    final appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    setState(() => _isLoading = true);
    try {
      final response = await appDataProvider.deleteBus(bus.busId!);
      if (response.responseStatus == ResponseStatus.SAVED) {
        _loadBuses();
      } else {
        showMsg(context, response.message);
      }
    } catch (e) {
      showMsg(context, 'Error deleting bus: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showBusDialog({required bool isAddBus, Bus? bus}) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController numberController = TextEditingController();
    final TextEditingController seatController = TextEditingController();
    String? busType;
    final List<String> busTypes = ['AC-BUSINESS', 'NON-AC', 'SEMI-SLEEPER'];

    // If updating, populate controllers with existing data
    if (!isAddBus && bus != null) {
      nameController.text = bus.busName;
      numberController.text = bus.busNumber;
      seatController.text = bus.totalSeat.toString();
      busType = bus.busType;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  DropdownButtonFormField<String>(
                    value: busType,
                    hint: const Text('Select Bus Type'),
                    onChanged: (value) {
                      setState(() {
                        busType = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a Bus Type';
                      }
                      return null;
                    },
                    items: busTypes
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Bus Name',
                      prefixIcon: Icon(Icons.bus_alert),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a bus name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: numberController,
                    decoration: const InputDecoration(
                      hintText: 'Bus Number',
                      prefixIcon: Icon(Icons.confirmation_number),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a bus number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: seatController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Total Seats',
                      prefixIcon: Icon(Icons.event_seat),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the total number of seats';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final newBus = Bus(
                            busName: nameController.text,
                            busNumber: numberController.text,
                            busType: busType!,
                            totalSeat: int.parse(seatController.text),
                          );
                          if(!isAddBus) {
                            newBus.busId = bus?.busId;
                          }
                          Navigator.of(context).pop();
                          _addOrUpdateBus(newBus, isAddBus);
                        }
                      },
                      child: Text(isAddBus ? 'Add Bus' : 'Update Bus'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _addOrUpdateBus(Bus bus, bool isAddBus) async {
    final appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    try {
      final response = isAddBus
          ? await appDataProvider.addBus(bus)
          : await appDataProvider.updateBus(bus);

      if (response.responseStatus == ResponseStatus.SAVED) {
        showMsg(context, response.message);
        _loadBuses();
      } else if (response.responseStatus == ResponseStatus.EXPIRED ||
          response.responseStatus == ResponseStatus.UNAUTHORIZED) {
        showLoginAlertDialog(
          context: context,
          message: response.message,
          callback: () {
            Navigator.pushNamed(context, routeNameLoginPage);
          },
        );
      } else {
        showMsg(context, response.message);
      }
    } catch (e) {
      showMsg(context, 'Error ${isAddBus ? 'adding' : 'updating'} bus: $e');
    }
  }
}

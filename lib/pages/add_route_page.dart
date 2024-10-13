import 'package:bus_reservation/models/bus_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../customwidgets/login_alert_dialog.dart';
import '../models/bus_model.dart';
import '../models/city_model.dart';
import '../providers/app_data_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class AddRoutePage extends StatefulWidget {
  const AddRoutePage({super.key});

  @override
  State<AddRoutePage> createState() => _AddRoutePageState();
}

class _AddRoutePageState extends State<AddRoutePage> {
  bool _isLoading = false;
  List<BusRoute> _busRouteList = [];
  List<String> _cityNames = [];

  @override
  void initState() {
    super.initState();
    _loadRoutes();
    _loadCities();
  }

  Future<void> _loadRoutes() async {
    final appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    setState(() => _isLoading = true);
    try {
      final busRoutes = await appDataProvider.getAllBusRouteList();
      setState(() {
        _busRouteList = busRoutes;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading buses: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadCities() async {
    final appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    setState(() => _isLoading = true);
    try {
      final cities = await appDataProvider.getAllCity();
      setState(() {
        _cityNames = cities.map((city) => city.cityName).toList();
        _isLoading = false;
        print('===city size: ${_cityNames.length}');
      });
    } catch (e) {
      print('Error loading cities: $e');
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
          _showRouteDialog(isAddRoute: true);
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (_busRouteList.isEmpty)
            const Center(
              child: Text('No route available.'),
            )
          else
            ListView.builder(
              itemCount: _busRouteList.length,
              itemBuilder: (context, index) {
                final route = _busRouteList[index];
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
                        route.routeName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('From: ${route.cityFrom}'),
                          Text('To: ${route.cityTo}'),
                          Text('Distance(KM): ${route.distanceInKm}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () => _showBottomSheet(route),
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

  void _showBottomSheet(BusRoute busRoute) {
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
                  _showRouteDialog(isAddRoute: false, busRoute: busRoute);
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

  void _showRouteDialog({required bool isAddRoute, BusRoute? busRoute}) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController distanceController = TextEditingController();
    String? fromCity;
    String? toCity;

    if (!isAddRoute && busRoute != null) {
      nameController.text = busRoute.routeName;
      distanceController.text = busRoute.distanceInKm.toString();
      fromCity = busRoute.cityFrom;
      toCity = busRoute.cityTo;
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
                    value: fromCity,
                    hint: const Text('Select from city'),
                    onChanged: (value) {
                      setState(() {
                        fromCity = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select from city';
                      }
                      return null;
                    },
                    items: _cityNames
                        .map((cityName) => DropdownMenuItem(
                              value: cityName,
                              child: Text(cityName),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 8.0),
                  DropdownButtonFormField<String>(
                    value: toCity,
                    hint: const Text('Select to city'),
                    onChanged: (value) {
                      setState(() {
                        toCity = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select to city';
                      }
                      return null;
                    },
                    items: _cityNames
                        .map((cityName) => DropdownMenuItem(
                              value: cityName,
                              child: Text(cityName),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: distanceController,
                    decoration: const InputDecoration(
                      hintText: 'Distance in Kilometer',
                      prefixIcon: Icon(Icons.confirmation_number),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return emptyFieldErrMessage;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final route = BusRoute(
                            routeName: '$fromCity-$toCity',
                            cityFrom: fromCity!,
                            cityTo: toCity!,
                            distanceInKm: double.parse(distanceController.text),
                          );
                          if (!isAddRoute) {
                            route.routeId = busRoute?.routeId;
                          }
                          Navigator.of(context).pop();
                          _addOrUpdateRoute(route, isAddRoute);
                        }
                      },
                      child: Text(isAddRoute ? 'Add Route' : 'Update Route'),
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

  Future<void> _addOrUpdateRoute(BusRoute busRoute, bool isAddRoute) async {
    final appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    try {
      final response = isAddRoute
          ? await appDataProvider.addRoute(busRoute)
          : await appDataProvider.updateRoute(busRoute);

      if (response.responseStatus == ResponseStatus.SAVED) {
        showMsg(context, response.message);
        _loadRoutes();
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
      showMsg(context, 'Error ${isAddRoute ? 'adding' : 'updating'} bus: $e');
    }
  }
}

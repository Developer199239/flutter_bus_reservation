import 'package:bus_reservation/utils/constants.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../customwidgets/login_alert_dialog.dart';
import '../models/city_model.dart';
import '../providers/app_data_provider.dart';

class AddCity extends StatefulWidget {
  const AddCity({super.key});

  @override
  State<AddCity> createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
  bool _isLoading = false;
  List<City> _cities = [];

  @override
  void initState() {
    super.initState();
    _loadCities(); // Load the cities initially
  }

  Future<void> _loadCities() async {
    setState(() => _isLoading = true);
    try {
      _cities = await Provider.of<AppDataProvider>(context, listen: false)
          .getAllCity();
    } catch (e) {
      print('Error loading cities: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Cities'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addCity(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (_cities.isEmpty)
            const Center(
              child: Text('No cities available.'),
            )
          else
            ListView.builder(
              itemCount: _cities.length,
              itemBuilder: (context, index) {
                final city = _cities[index];
                return ListTile(
                  title: Text(city.cityName),
                  onTap: () => _showBottomSheet(city),
                );
              },
            ),
        ],
      ),
    );
  }

  Future<void> _addCity(BuildContext context) async {
    setState(() => _isLoading = true);
    if (await hasTokenExpired()) {
      setState(() => _isLoading = false);
      showLoginAlertDialog(
        context: context,
        message: 'Access denied. Please login as Admin',
        callback: () {
          Navigator.pushNamed(context, routeNameLoginPage);
        },
      );
      return;
    }

    try {
      final response =
          await Provider.of<AppDataProvider>(context, listen: false)
              .addCity(City(cityName: 'New City'));

      if (response.responseStatus == ResponseStatus.SAVED) {
        _loadCities(); // Refresh list on successful addition
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
      showMsg(context, 'Error adding city: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteCity(BuildContext context, City city) async {
    setState(() => _isLoading = true);
    if (await hasTokenExpired()) {
      setState(() => _isLoading = false);
      showLoginAlertDialog(
        context: context,
        message: 'Access denied. Please login as Admin',
        callback: () {
          Navigator.pushNamed(context, routeNameLoginPage);
        },
      );
      return;
    }

    try {
      final response =
          await Provider.of<AppDataProvider>(context, listen: false)
              .deleteCity(city.cityId!);

      if (response.responseStatus == ResponseStatus.SAVED) {
        _loadCities(); // Reload list after successful deletion
      } else {
        showMsg(context, response.message);
      }
    } catch (e) {
      print('Error deleting city: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showBottomSheet(City city) {
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
                  _showUpdateDialog(city);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  _deleteCity(context, city);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUpdateDialog(City oldCity) {
    TextEditingController _controller =
        TextEditingController(text: oldCity.cityName);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update City'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter new city name'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                String newCityName = _controller.text.trim();
                if (newCityName.isNotEmpty) {
                  City newCity = City(cityName: newCityName);
                  Navigator.of(context).pop();
                  await Provider.of<AppDataProvider>(context, listen: false)
                      .updateCity(oldCity, newCity);
                  setState(() {}); // Rebuild UI to reflect changes
                }
              },
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../drawers/main_drawer.dart';
import '../providers/app_data_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? fromCity, toCity;
  DateTime? departureDate;
  final _formKey = GlobalKey<FormState>();
  List<String> _cityNames = [];

  @override
  void initState() {
    // fromCity = 'Dhaka';
    // toCity = 'Sylhet';
    departureDate = DateTime.now();
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    final appDataProvider =
    Provider.of<AppDataProvider>(context, listen: false);
    EasyLoading.show(status: 'Searching...');
    try {
      final cities = await appDataProvider.getAllCity();
      setState(() {
        _cityNames = cities.map((city) => city.cityName).toList();
        print('===city size: ${_cityNames.length}');
      });
    } catch (e) {
      print('Error loading cities: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children: [
              DropdownButtonFormField<String>(
                value: fromCity,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  errorStyle: const TextStyle(color: Colors.white),
                ),
                hint: const Text('From City'),
                isExpanded: true,
                items: _cityNames
                    .map((city) => DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        ))
                    .toList(),
                onChanged: (value) {
                  fromCity = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: toCity,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  errorStyle: const TextStyle(color: Colors.white),
                ),
                hint: const Text('To City'),
                isExpanded: true,
                items: _cityNames
                    .map((city) => DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        ))
                    .toList(),
                onChanged: (value) {
                  toCity = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _selectDate,
                      child: const Text('Select Departure Date'),
                    ),
                    Text(departureDate == null
                        ? 'No date chosen'
                        : getFormattedDate(departureDate!,
                            pattern: 'EEE MMM dd, yyyy')),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _search,
                    child: const Text('SEARCH'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );
    if (selectedDate != null) {
      setState(() {
        departureDate = selectedDate;
      });
    }
  }

  void _search() {
    if (departureDate == null) {
      showMsg(context, emptyDateErrMessage);
      return;
    }
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Searching...');
      Provider.of<AppDataProvider>(context, listen: false)
          .getRouteByCityFromAndCityTo(fromCity!, toCity!)
          .then((route) {
        EasyLoading.dismiss();
        if (route != null) {
          print('route found');
          Navigator.pushNamed(context, routeNameSearchResultPage,
              arguments: [route, getFormattedDate(departureDate!)]);
        } else {
          print('route found');
          showMsg(context, 'Could not find any route');
        }
      });
    }
  }
}

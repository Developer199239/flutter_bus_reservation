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
    departureDate = DateTime.now();
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    final appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    EasyLoading.show(status: 'Searching...');
    try {
      final cities = await appDataProvider.getAllCity();
      setState(() {
        _cityNames = cities.map((city) => city.cityName).toList();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Minimize Column height to content
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: fromCity,
                  validator: (value) => value == null ? emptyFieldErrMessage : null,
                  decoration: InputDecoration(
                    labelText: 'From City',
                    labelStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.grey[900],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[800]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.purpleAccent),
                    ),
                  ),
                  isExpanded: true,
                  dropdownColor: Colors.grey[900],
                  items: _cityNames.map((city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => fromCity = value),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: toCity,
                  validator: (value) => value == null ? emptyFieldErrMessage : null,
                  decoration: InputDecoration(
                    labelText: 'To City',
                    labelStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.grey[900],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[800]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.purpleAccent),
                    ),
                  ),
                  isExpanded: true,
                  dropdownColor: Colors.grey[900],
                  items: _cityNames.map((city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => toCity = value),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[800]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Departure Date',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        Text(
                          departureDate != null
                              ? getFormattedDate(departureDate!, pattern: 'EEE MMM dd, yyyy')
                              : 'No date chosen',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32), // Increase space before the button
                ElevatedButton(
                  onPressed: _search,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('SEARCH', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
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
          Navigator.pushNamed(context, routeNameSearchResultPage,
              arguments: [route, getFormattedDate(departureDate!)]);
        } else {
          showMsg(context, 'Could not find any route');
        }
      });
    }
  }
}

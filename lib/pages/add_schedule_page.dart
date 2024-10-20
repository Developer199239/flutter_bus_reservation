import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../customwidgets/login_alert_dialog.dart';
import '../drawers/main_drawer.dart';
import '../models/bus_model.dart';
import '../models/bus_schedule.dart';
import '../models/bus_route.dart';
import '../providers/app_data_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({Key? key}) : super(key: key);

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final _formKey = GlobalKey<FormState>();
  BusRoute? busRoute;
  Bus? bus;
  TimeOfDay? timeOfDay;
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final feeController = TextEditingController();
  bool _isLoading = false;
  bool _isDataLoaded = false; // Flag to control data fetching
  BusSchedule? busSchedule;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeData();
  }

  void _initializeData() {
    // Load the data only once
    if (!_isDataLoaded) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        final argList = args as List;
        busSchedule = argList[0] as BusSchedule;
      }
      _getData();
    }
  }

  void _getData() {
    setState(() => _isLoading = true);
    final appDataProvider = Provider.of<AppDataProvider>(context, listen: false);

    Future.wait([
      appDataProvider.getAllBus(),
      appDataProvider.getAllBusRoutes(),
    ]).then((_) {
      if (busSchedule != null) {
        bus = appDataProvider.busList.cast<Bus?>().firstWhere(
              (bus) => bus?.busId == busSchedule!.bus.busId,
          orElse: () => null,
        );

        busRoute = appDataProvider.routeList.cast<BusRoute?>().firstWhere(
              (route) => route?.routeId == busSchedule!.busRoute.routeId,
          orElse: () => null,
        );

        timeOfDay = TimeOfDay(
          hour: int.parse(busSchedule!.departureTime.split(":")[0]),
          minute: int.parse(busSchedule!.departureTime.split(":")[1]),
        );
        priceController.text = busSchedule!.ticketPrice.toString();
        discountController.text = busSchedule!.discount.toString();
        feeController.text = busSchedule!.processingFee.toString();
      }
      setState(() {
        _isLoading = false;
        _isDataLoaded = true; // Mark data as loaded
      });
    }).catchError((error) {
      setState(() => _isLoading = false);
      showMsg(context, 'Error loading data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(busSchedule != null ? 'Update Schedule' : 'Add Schedule'),
      ),
      body: Stack(
        children: [
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (_dataIsEmpty())
            const Center(
              child: Text('No data available.'),
            )
          else
            _buildForm(),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          shrinkWrap: true,
          children: [
            _buildBusDropdown(),
            _buildRouteDropdown(),
            const SizedBox(height: 5),
            _buildTextField(
              controller: priceController,
              hint: 'Ticket Price',
              icon: Icons.price_change,
            ),
            const SizedBox(height: 5),
            _buildTextField(
              controller: discountController,
              hint: 'Discount(%)',
              icon: Icons.discount,
            ),
            const SizedBox(height: 5),
            _buildTextField(
              controller: feeController,
              hint: 'Processing Fee',
              icon: Icons.monetization_on_outlined,
            ),
            const SizedBox(height: 5),
            _buildTimePicker(),
            const SizedBox(height: 16),
            _buildAddScheduleButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBusDropdown() {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    return DropdownButtonFormField<Bus>(
      onChanged: (value) => setState(() => bus = value),
      isExpanded: true,
      value: bus,
      hint: const Text('Select Bus'),
      items: provider.busList
          .map((e) => DropdownMenuItem<Bus>(
        value: e,
        child: Text('${e.busName}-${e.busType}'),
      ))
          .toList(),
    );
  }

  Widget _buildRouteDropdown() {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    return DropdownButtonFormField<BusRoute>(
      onChanged: (value) => setState(() => busRoute = value),
      isExpanded: true,
      value: busRoute,
      hint: const Text('Select Route'),
      items: provider.routeList
          .map((e) => DropdownMenuItem<BusRoute>(
        value: e,
        child: Text(e.routeName),
      ))
          .toList(),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        prefixIcon: Icon(icon),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return emptyFieldErrMessage;
        }
        return null;
      },
    );
  }

  Widget _buildTimePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: _selectTime,
          child: const Text('Select Departure Time'),
        ),
        Text(timeOfDay == null
            ? 'No time chosen'
            : getFormattedTime(timeOfDay!)),
      ],
    );
  }

  Widget _buildAddScheduleButton() {
    return Center(
      child: SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: addSchedule,
          child: Text(busSchedule != null ? 'Update Schedule' : 'ADD Schedule'),
        ),
      ),
    );
  }

  bool _dataIsEmpty() {
    final appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    return appDataProvider.busList.isEmpty || appDataProvider.routeList.isEmpty;
  }

  void _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (time != null) {
      setState(() {
        timeOfDay = time;
      });
    }
  }

  void addSchedule() {
    if (timeOfDay == null) {
      showMsg(context, 'Please select a departure time');
      return;
    }
    if (_formKey.currentState!.validate()) {
      final schedule = BusSchedule(
        bus: bus!,
        busRoute: busRoute!,
        departureTime: getFormattedTime(timeOfDay!),
        ticketPrice: int.parse(priceController.text),
        discount: int.parse(discountController.text),
        processingFee: int.parse(feeController.text),
      );

      if (busSchedule != null) {
        schedule.scheduleId = busSchedule!.scheduleId;
        _saveOrUpdateSchedule(schedule, isUpdate: true);
      } else {
        _saveOrUpdateSchedule(schedule, isUpdate: false);
      }
    }
  }

  void _saveOrUpdateSchedule(BusSchedule schedule, {required bool isUpdate}) {
    final appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    final future = isUpdate
        ? appDataProvider.updateSchedule(schedule)
        : appDataProvider.addSchedule(schedule);

    future.then((response) {
      if (response.responseStatus == ResponseStatus.SAVED) {
        showMsg(context, response.message);
        resetFields();
        Navigator.pop(context, true);
      } else if (response.responseStatus == ResponseStatus.EXPIRED ||
          response.responseStatus == ResponseStatus.UNAUTHORIZED) {
        showLoginAlertDialog(
          context: context,
          message: response.message,
          callback: () {
            Navigator.pushNamed(context, routeNameLoginPage);
          },
        );
      }
    }).catchError((error) {
      showMsg(context, 'An error occurred: $error');
    });
  }

  void resetFields() {
    priceController.clear();
    discountController.clear();
    feeController.clear();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../models/bus_reservation.dart';
import '../models/bus_schedule.dart';
import '../models/user_info_model.dart';
import '../providers/app_data_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class BookingConfirmationPage extends StatefulWidget {
  const BookingConfirmationPage({Key? key}) : super(key: key);

  @override
  State<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  late BusSchedule schedule;
  late String departureDate;
  late int totalSeatsBooked;
  late String seatNumbers;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  bool isFirst = true;
  UserInfoModel? userInfoModel;

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  Future<void> _getInfo() async {
    final appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    EasyLoading.show(status: 'Loading user info...');
    try {
      String userName = await getLoggedInUserName();
      final response = await appDataProvider.getUserInfo(userName);
      if(response.responseStatus == ResponseStatus.SAVED) {
        setState(() {
          userInfoModel = UserInfoModel.fromJson(response.object);
          nameController.text = userInfoModel!.customerName;
          mobileController.text = userInfoModel!.mobile;
          emailController.text = userInfoModel!.email;
        });
      } else  {
        setState(() {
          userInfoModel = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      }
    } catch (e) {
      setState(() {
        userInfoModel = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading user info: $e')),
      );
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void didChangeDependencies() {
    if (isFirst) {
      final argList = ModalRoute.of(context)!.settings.arguments as List;
      departureDate = argList[0];
      schedule = argList[1];
      seatNumbers = argList[2];
      totalSeatsBooked = argList[3];
    }
    isFirst = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Booking'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Please provide your information',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 4.0),
              child: TextFormField(
                controller: nameController,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'Customer Name',
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 4.0),
              child: TextFormField(
                readOnly: true,
                keyboardType: TextInputType.phone,
                controller: mobileController,
                decoration: const InputDecoration(
                  hintText: 'Mobile Number',
                  filled: true,
                  prefixIcon: Icon(Icons.call),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 4.0),
              child: TextFormField(
                readOnly: true,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email Address',
                  filled: true,
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Booking Summery',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer Name: ${nameController.text}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Mobile Number: ${mobileController.text}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Email Address: ${emailController.text}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Route: ${schedule.busRoute.routeName}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Departure Date: $departureDate',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Departure Time: ${schedule.departureTime}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Ticket Price: $currency${schedule.ticketPrice}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Total Seat(s): $totalSeatsBooked',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Seat Number(s): $seatNumbers',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Discount: ${schedule.discount}%',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Processing Fee: $currency${schedule.processingFee}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Grand Total: $currency${getGrandTotal(schedule.discount, totalSeatsBooked, schedule.ticketPrice, schedule.processingFee)}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _confirmBooking,
              child: const Text('CONFIRM BOOKING'),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  void _confirmBooking() {
    if (_formKey.currentState!.validate()) {
      final reservation = BusReservation(
        appUser: userInfoModel!,
        busSchedule: schedule,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        departureDate: departureDate,
        totalSeatBooked: totalSeatsBooked,
        seatNumbers: seatNumbers,
        reservationStatus: reservationActive,
        totalPrice: getGrandTotal(schedule.discount, totalSeatsBooked, schedule.ticketPrice, schedule.processingFee),
      );
      Provider.of<AppDataProvider>(context, listen: false)
      .addReservation(reservation)
      .then((response) {
        if(response.responseStatus == ResponseStatus.SAVED) {
          showMsg(context, response.message);
          Navigator.popUntil(context, ModalRoute.withName(routeNameHome));
        } else {
          showMsg(context, response.message);
        }
      })
      .catchError((error) {
        showMsg(context, 'Could not save');
      });
    }
  }
}

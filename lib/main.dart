import 'package:bus_reservation/pages/add_schedule_page.dart';
import 'package:bus_reservation/pages/my_reservation_page.dart';
import 'package:bus_reservation/pages/sign_up_page.dart';
import 'package:bus_reservation/pages/user_details_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:bus_reservation/pages/add_bus_page.dart';
import 'package:bus_reservation/pages/add_route_page.dart';
import 'package:bus_reservation/pages/schedule_list_page.dart';
import 'package:bus_reservation/pages/booking_confirmation_page.dart';
import 'package:bus_reservation/pages/login_page.dart';
import 'package:bus_reservation/pages/reservation_page.dart';
import 'package:bus_reservation/pages/search_page.dart';
import 'package:bus_reservation/pages/search_result_page.dart';
import 'package:bus_reservation/pages/seat_plan_page.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/add_city.dart';
import 'providers/app_data_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppDataProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: EasyLoading.init(),
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        brightness: Brightness.dark,
      ),
      initialRoute: routeNameHome,
      // initialRoute: routeNameScheduleListPage,
      routes: {
        routeNameHome : (context) => const SearchPage(),
        routeNameSearchResultPage : (context) => const SearchResultPage(),
        routeNameSeatPlanPage : (context) => const SeatPlanPage(),
        routeNameBookingConfirmationPage : (context) => const BookingConfirmationPage(),
        routeNameAddBusPage : (context) => const AddBusPage(),
        routeNameAddRoutePage : (context) => const AddRoutePage(),
        routeNameScheduleListPage : (context) => const ScheduleListPage(),
        routeNameAddSchedulePage : (context) => const AddSchedulePage(),
        routeNameReservationPage : (context) => const ReservationPage(),
        routeNameLoginPage : (context) => const LoginPage(),
        routeNameAddCityPage : (context) => const AddCity(),
        routeNameSignUpPage : (context) => const SignUpPage(),
        routeNameUserDetailsPage : (context) => const UserDetailsPage(),
        routeNameMyReservation : (context) => const MyReservationPage(),
      },
    );
  }
}

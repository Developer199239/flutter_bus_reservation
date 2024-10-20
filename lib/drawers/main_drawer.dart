import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/HeaderView.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool isLoggedIn = false;
  String userRole = '';
  String userName = '';
  String userMobile = '';

  @override
  void initState() {
    super.initState();
    _loadLoginState();
  }

  Future<void> _loadLoginState() async {
    bool loginStatus = await isUserLoggedIn();
    String role = await getLoggedInUserRole();
    String name = await getLoggedInUserName();
    String mobile = await getLoggedInUserMobile();

    setState(() {
      isLoggedIn = loginStatus;
      userRole = role;
      userName = name;
      userMobile = mobile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: _buildDrawerMenu(context),
      ),
    );
  }

  List<Widget> _buildDrawerMenu(BuildContext context) {
    return [
      HeaderView(
        isLoggedIn: isLoggedIn,
        userName: userName,
        userMobile: userMobile,
      ),
      ..._buildMenuItems(context),
    ];
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    if (!isLoggedIn) {
      return [
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, routeNameLoginPage);
          },
          leading: const Icon(Icons.login_outlined),
          title: const Text('Login'),
        ),
      ];
    } else if (userRole == 'Admin') {
      return [
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, routeNameAddCityPage);
          },
          leading: const Icon(Icons.location_city),
          title: const Text('Add City'),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, routeNameAddBusPage);
          },
          leading: const Icon(Icons.bus_alert),
          title: const Text('Add Bus'),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, routeNameAddRoutePage);
          },
          leading: const Icon(Icons.route),
          title: const Text('Add Route'),
        ),
        // ListTile(
        //   onTap: () {
        //     Navigator.pop(context);
        //     Navigator.pushNamed(context, routeNameScheduleListPage);
        //   },
        //   leading: const Icon(Icons.schedule),
        //   title: const Text('Add Schedule'),
        // ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, routeNameReservationPage);
          },
          leading: const Icon(Icons.book_online),
          title: const Text('View Reservations'),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            _logout(context);
          },
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
        ),
      ];
    } else if (userRole == 'User') {
      return [
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, routeNameUserDetailsPage);
          },
          leading: const Icon(Icons.person),
          title: const Text('My Profile'),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, routeNameMyReservation);
          },
          leading: const Icon(Icons.bus_alert),
          title: const Text('My Reservation'),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            _logout(context);
          },
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
        ),
      ];
    } else {
      return [
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, routeNameLoginPage);
          },
          leading: const Icon(Icons.login_outlined),
          title: const Text('Login'),
        ),
      ];
    }
  }

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      isLoggedIn = false;
      userRole = '';
      userName = '';
      userMobile = '';
    });
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    print('========loading====');
    _loadLoginState();
    super.initState();
  }

  Future<void> _loadLoginState() async {
    // Fetch the values asynchronously first
    bool loginStatus = await isUserLoggedIn();
    String role = await getLoggedInUserRole();

    // Once fetched, update the state synchronously
    setState(() {
      isLoggedIn = loginStatus;
      userRole = role;
    });

    print('====isLoggedIn:$isLoggedIn');
    print('====userRole:$userRole');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: _buildDrawerMenu(context),
      ),
    );
  }

  // Build the menu based on the login state and role
  List<Widget> _buildDrawerMenu(BuildContext context) {
    if (!isLoggedIn) {
      return [
        const HeaderView(),
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
      // If logged in as admin, show admin-specific menus
      return [
        const HeaderView(),
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
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, routeNameAddSchedulePage);
          },
          leading: const Icon(Icons.schedule),
          title: const Text('Add Schedule'),
        ),
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
      // If logged in as a regular user, show user-specific menus
      return [
        const HeaderView(),
        ListTile(
          onTap: () {
            // Navigator.pop(context);
            // Navigator.pushNamed(context, routeNameMyProfilePage);
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
        const HeaderView(),
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

    return []; // Default: No menus if neither logged in nor role identified
  }

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

class HeaderView extends StatelessWidget {
  const HeaderView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.grey,
    );
  }
}

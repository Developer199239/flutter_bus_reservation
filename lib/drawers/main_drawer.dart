import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 200,
            color: Colors.grey,
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
              Navigator.pushNamed(context, routeNameLoginPage);
            },
            leading: const Icon(Icons.login_outlined),
            title: const Text('Admin Login'),
          ),
        ],
      ),
    );
  }
}

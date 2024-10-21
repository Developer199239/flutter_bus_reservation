import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../customwidgets/reservation_item_body_view.dart';
import '../customwidgets/reservation_item_header_view.dart';
import '../customwidgets/search_box.dart';
import '../models/reservation_expansion_item.dart';
import '../providers/app_data_provider.dart';
import '../utils/helper_functions.dart';

class MyReservationPage extends StatefulWidget {
  const MyReservationPage({super.key});

  @override
  State<MyReservationPage> createState() => _MyReservationPageState();
}

class _MyReservationPageState extends State<MyReservationPage> {
  bool isFirst = true;
  bool isLoading = true;  // Add loading state
  List<ReservationExpansionItem> items = [];

  @override
  void didChangeDependencies() {
    if (isFirst) {
      _getData();
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  _getData() async {
    String userName = await getLoggedInUserName();
    final reservations = await Provider.of<AppDataProvider>(context, listen: false)
        .getMyReservations(userName);
    items = Provider.of<AppDataProvider>(context, listen: false)
        .getExpansionItems(reservations);
    setState(() {
      isLoading = false;  // Disable loading when data is fetched
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Reservation'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())  // Show loading spinner
          : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),  // Add spacing
            ExpansionPanelList(
              expansionCallback: (index, isExpanded) {
                setState(() {
                  items[index].isExpanded = !items[index].isExpanded;
                });
              },
              children: items.map((item) {
                return ExpansionPanel(
                  isExpanded: item.isExpanded,
                  headerBuilder: (context, isExpanded) => ReservationItemHeaderView(header: item.header),
                  body: ReservationItemBodyView(body: item.body),
                  canTapOnHeader: true,  // Make header tappable to expand
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

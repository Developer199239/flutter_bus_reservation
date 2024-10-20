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
  List<ReservationExpansionItem> items = [];
  @override
  void didChangeDependencies() {
    if(isFirst) {
      _getData();
    }
    super.didChangeDependencies();
  }

  _getData() async {
    String userName = await getLoggedInUserName();
    final reservations = await Provider.of<AppDataProvider>(context, listen: false).getMyReservations(userName);
    items = Provider.of<AppDataProvider>(context, listen: false).getExpansionItems(reservations);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SearchBox(onSubmit: (value) {
            //   _search(value);
            // }),
            ExpansionPanelList(
              expansionCallback: (index, isExpanded) {
                setState(() {
                  items[index].isExpanded = !items[index].isExpanded;
                  print("Item at index $index is now ${items[index].isExpanded}");
                });
              },
              children: items.map((item) => ExpansionPanel(
                  isExpanded: item.isExpanded,
                  headerBuilder: (context, isExpanded) => ReservationItemHeaderView(header: item.header),
                  body: ReservationItemBodyView(body: item.body,)
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

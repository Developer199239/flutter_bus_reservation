
import 'bus_schedule.dart';
import 'user_info_model.dart';

class ReservationExpansionItem {
  ReservationExpansionHeader header;
  ReservationExpansionBody body;
  bool isExpanded;

  ReservationExpansionItem({
    required this.header,
    required this.body,
    this.isExpanded = false,
  });
}

class ReservationExpansionHeader {
  int? reservationId;
  String departureDate;
  BusSchedule schedule;
  int timestamp;
  String reservationStatus;

  ReservationExpansionHeader({
    required this.reservationId,
    required this.departureDate,
    required this.schedule,
    required this.timestamp,
    required this.reservationStatus,
  });
}

class ReservationExpansionBody {
  UserInfoModel userInfoModel;
  int totalSeatedBooked;
  String seatNumbers;
  int totalPrice;

  ReservationExpansionBody({
    required this.userInfoModel,
    required this.totalSeatedBooked,
    required this.seatNumbers,
    required this.totalPrice,
  });
}

import 'package:bus_reservation/datasource/app_data_source.dart';
import 'package:bus_reservation/models/app_user.dart';
import 'package:bus_reservation/models/auth_response_model.dart';
import 'package:bus_reservation/models/city_model.dart';
import 'package:bus_reservation/models/sign_up_model.dart';
import 'package:bus_reservation/models/user_info_model.dart';
import 'package:flutter/material.dart';

import '../datasource/data_source.dart';
import '../models/bus_model.dart';
import '../models/bus_reservation.dart';
import '../models/bus_route.dart';
import '../models/bus_schedule.dart';
import '../models/reservation_expansion_item.dart';
import '../models/response_model.dart';
import '../utils/helper_functions.dart';

class AppDataProvider extends ChangeNotifier {
  List<Bus> _busList = [];
  List<BusRoute> _routeList = [];
  List<BusReservation> _reservationList = [];
  List<BusSchedule> _scheduleList = [];

  List<BusSchedule> get scheduleList => _scheduleList;

  List<Bus> get busList => _busList;

  List<BusRoute> get routeList => _routeList;

  List<BusReservation> get reservationList => _reservationList;
  final DataSource _dataSource = AppDataSource();

  Future<AuthResponseModel?> login(AppUser user) async {
    final response = await _dataSource.login(user);
    if(response == null) return null;
    await saveToken(response.accessToken);
    await setLoggedInUserName(user.userName);
    await setLoggedInUserRole(response.role);
    await setLoggedInUserMobile(response.mobile);
    await setLoggedInUserId(response.userId);
    await saveLoginTime(response.loginTime);
    await saveExpirationDuration(response.expirationDuration);
    return response;
  }

  Future<ResponseModel?> signup(SignUpModel signUpModel) async {
    return await _dataSource.signUp(signUpModel);
  }

  Future<ResponseModel> getUserInfo(String userName) async {
    return _dataSource.getUserInfo(userName);
  }

  Future<ResponseModel> addBus(Bus bus) {
    return _dataSource.addBus(bus);
  }

  Future<ResponseModel> updateBus(Bus bus) {
    return _dataSource.updateBus(bus);
  }

  Future<ResponseModel> addRoute(BusRoute route) {
    return _dataSource.addRoute(route);
  }

  Future<ResponseModel> updateRoute(BusRoute route) {
    return _dataSource.updateRoute(route);
  }

  Future<ResponseModel> addSchedule(BusSchedule busSchedule) {
    return _dataSource.addSchedule(busSchedule);
  }

  Future<ResponseModel> updateSchedule(BusSchedule busSchedule) {
    return _dataSource.updateBusSchedule(busSchedule);
  }

  Future<List<BusSchedule>> allSchedule() {
    return _dataSource.getAllSchedules();
  }

  Future<ResponseModel> addReservation(BusReservation reservation) {
    return _dataSource.addReservation(reservation);
  }

  Future<void> getAllBus() async {
    _busList = await _dataSource.getAllBus();
    notifyListeners();
  }

  Future<List<Bus>> getAllBusList() async {
    _busList = await _dataSource.getAllBus();
    return _busList;
  }

  Future<ResponseModel> deleteBus(int busId) async {
    return await _dataSource.deleteBus(busId);
  }

  Future<List<Bus>> getAllBusWithList() async {
    _busList = await _dataSource.getAllBus();
    return _busList;
  }

  Future<void> getAllBusRoutes() async {
    _routeList = await _dataSource.getAllRoutes();
    notifyListeners();
  }


  Future<List<BusRoute>> getAllBusRouteList() async {
    _routeList = await _dataSource.getAllRoutes();
    return _routeList;
  }

  Future<List<BusReservation>> getAllReservations() async {
    _reservationList = await _dataSource.getAllReservation();
    notifyListeners();
    return _reservationList;
  }

  Future<List<BusReservation>> getMyReservations(String userName) async {
    _reservationList = await _dataSource.getMyReservation(userName);
    notifyListeners();
    return _reservationList;
  }

  Future<List<BusReservation>> getReservationsByMobile(String mobile) {
    return _dataSource.getReservationsByMobile(mobile);
  }

  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) {
    return _dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
  }

  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    return _dataSource.getSchedulesByRouteName(routeName);
  }

  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) {
    return _dataSource.getReservationsByScheduleAndDepartureDate(
        scheduleId, departureDate);
  }

  List<ReservationExpansionItem> getExpansionItems(List<BusReservation> reservationList) {
    return List.generate(reservationList.length, (index) {
      final reservation = reservationList[index];
      return ReservationExpansionItem(
        header: ReservationExpansionHeader(
          reservationId: reservation.reservationId,
          departureDate: reservation.departureDate,
          schedule: reservation.busSchedule,
          timestamp: reservation.timestamp,
          reservationStatus: reservation.reservationStatus,
        ),
        body: ReservationExpansionBody(
          userInfoModel: reservation.appUser,
          totalSeatedBooked: reservation.totalSeatBooked,
          seatNumbers: reservation.seatNumbers,
          totalPrice: reservation.totalPrice,
        ),
      );
    });
  }

  Future<List<City>> getAllCity() async {
    return await _dataSource.getAllCity();
  }

  Future<ResponseModel> addCity(City city) async {
    return await _dataSource.addCity(city);
  }

  Future<ResponseModel> deleteCity(int cityId) async {
    return await _dataSource.deleteCity(cityId);
  }

  Future<ResponseModel> updateCity(City city) async {
    return await _dataSource.updateCity(city);
  }
}

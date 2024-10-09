import 'package:bus_reservation/models/city_model.dart';

import '../models/app_user.dart';
import '../models/auth_response_model.dart';
import '../models/bus_model.dart';
import '../models/bus_reservation.dart';
import '../models/bus_route.dart';
import '../models/bus_schedule.dart';
import '../models/response_model.dart';
import '../utils/constants.dart';

abstract class DataSource {
  Future<AuthResponseModel?> login(AppUser user);
  Future<ResponseModel> addBus(Bus bus);
  Future<List<Bus>> getAllBus();
  Future<ResponseModel> addRoute(BusRoute busRoute);
  Future<List<BusRoute>> getAllRoutes();
  Future<BusRoute?> getRouteByRouteName(String routeName);
  Future<BusRoute?> getRouteByCityFromAndCityTo(String cityFrom, String cityTo);
  Future<ResponseModel> addSchedule(BusSchedule busSchedule);
  Future<List<BusSchedule>> getAllSchedules();
  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName);
  Future<ResponseModel> addReservation(BusReservation reservation);
  Future<List<BusReservation>> getAllReservation();
  Future<List<BusReservation>> getReservationsByMobile(String mobile);
  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(int scheduleId, String departureDate);

//   city
  Future<List<City>> getAllCity();
  Future<ResponseModel> addCity(City city);
  Future<ResponseModel> deleteCity(int cityId);
}
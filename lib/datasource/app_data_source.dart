import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/app_user.dart';
import '../models/auth_response_model.dart';
import '../models/bus_model.dart';
import '../models/bus_reservation.dart';
import '../models/bus_route.dart';
import '../models/bus_schedule.dart';
import '../models/error_details_model.dart';
import '../models/response_model.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';
import 'data_source.dart';

class AppDataSource extends DataSource {
  final String baseUrl = 'http://192.168.0.102:8080/api/';

  Map<String, String> get header =>
      {
        'Content-Type': 'application/json'
      };
  Future<Map<String, String>> get authHeader async =>
      {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ${await getToken()}',
      };

  @override
  Future<AuthResponseModel?> login(AppUser user) async {
    final url = '$baseUrl${'auth/login'}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: json.encode(user.toJson()),
      );
      final map = json.decode(response.body);
      print(map);
      final authResponseModel = AuthResponseModel.fromJson(map);
      return authResponseModel;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  @override
  Future<ResponseModel> addBus(Bus bus) async {
    final url = '$baseUrl${'bus/add'}';
    try {
      final response = await http.post(
          Uri.parse(url),
          headers: await authHeader,
          body: json.encode(bus.toJson()));
      return await _getResponseModel(response);
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  @override
  Future<ResponseModel> addReservation(BusReservation reservation) async {
    final url = '$baseUrl${'reservation/add'}';
    print(url);
    print(json.encode(reservation.toJson()));
    try {
      final response = await http.post(Uri.parse(url), headers: header, body: json.encode(reservation.toJson()));
      return await _getResponseModel(response);
    } catch(error) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> addRoute(BusRoute busRoute) async {
    final url = '$baseUrl${'route/add'}';
    try {
      final response = await http.post(
          Uri.parse(url),
          headers: await authHeader,
          body: json.encode(busRoute.toJson()));
      return await _getResponseModel(response);
    } catch (error) {
      print(error.toString());
      rethrow;
    }

    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> addSchedule(BusSchedule busSchedule) async {
    final url = '$baseUrl${'schedule/add'}';
    try {
      final response = await http.post(
          Uri.parse(url),
          headers: await authHeader,
          body: json.encode(busSchedule.toJson()));
      return await _getResponseModel(response);
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  @override
  Future<List<Bus>> getAllBus() async {
    final url = '$baseUrl${'bus/all'}';
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        final mapList = json.decode(response.body) as List;
        return List.generate(mapList.length, (index) => Bus.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<BusReservation>> getAllReservation() async  {
    final url = '$baseUrl${'reservation/all'}';
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        final mapList = json.decode(response.body) as List;
        return List.generate(mapList.length, (index) => BusReservation.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<BusRoute>> getAllRoutes() async {
    final url = '$baseUrl${'route/all'}';
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        final mapList = json.decode(response.body) as List;
        return List.generate(mapList.length, (index) => BusRoute.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<BusSchedule>> getAllSchedules() {
    // TODO: implement getAllSchedules
    throw UnimplementedError();
  }

  @override
  Future<List<BusReservation>> getReservationsByMobile(String mobile) async {
    final url = '$baseUrl${'reservation/all/$mobile'}';
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        final mapList = json.decode(response.body) as List;
        return List.generate(mapList.length, (index) => BusReservation.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  @override
  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) async {
    final url = '$baseUrl${'reservation/query?scheduleId=$scheduleId&departureDate=$departureDate'}';
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        final mapList = json.decode(response.body) as List;
        return List.generate(mapList.length, (index) => BusReservation.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  @override
  Future<BusRoute?> getRouteByCityFromAndCityTo(String cityFrom,
      String cityTo) async {
    final url = '$baseUrl${'route/query?cityFrom=$cityFrom&cityTo=$cityTo'}';
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        final map = json.decode(response.body);
        return BusRoute.fromJson(map);
      }
      print('null found');
      return null;
    }catch(error) {
      rethrow;
    }
  }

  @override
  Future<BusRoute?> getRouteByRouteName(String routeName) {
    // TODO: implement getRouteByRouteName
    throw UnimplementedError();
  }

  @override
  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    final url = '$baseUrl${'schedule/$routeName'}';
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        final mapList = json.decode(response.body) as List;
        return List.generate(mapList.length, (index) => BusSchedule.fromJson(mapList[index]));
      }
      return [];
    } catch(error) {
      return [];
    }
  }

  Future<ResponseModel>_getResponseModel(http.Response response) async {
    ResponseStatus status = ResponseStatus.NONE;
    ResponseModel responseModel = ResponseModel();
    if(response.statusCode == 200) {
      status = ResponseStatus.SAVED;
      responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      responseModel.responseStatus = status;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      if(await hasTokenExpired()) {
        status = ResponseStatus.EXPIRED;
      } else {
        status = ResponseStatus.UNAUTHORIZED;
      }
      responseModel = ResponseModel(
        responseStatus: status,
        statusCode: 401,
        message: 'Access denied. Please login as Admin',
      );
    } else if(response.statusCode == 500 || response.statusCode == 400) {
      final json = jsonDecode(response.body);
      final errorDetails = ErrorDetails.fromJson(json);
      status = ResponseStatus.FAILED;
      responseModel = ResponseModel(
        responseStatus: status,
        statusCode: 500,
        message: errorDetails.errorMessage,
      );
    }
    return responseModel;
  }

}
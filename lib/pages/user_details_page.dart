import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../models/user_info_model.dart';
import '../providers/app_data_provider.dart';
import '../utils/constants.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  UserInfoModel? userInfoModel;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  Future<void> _getInfo() async {
    final appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    EasyLoading.show(status: 'Loading user info...');
    try {
      String userName = await getLoggedInUserName();
      final response = await appDataProvider.getUserInfo(userName);
      if(response.responseStatus == ResponseStatus.SAVED) {
        setState(() {
          userInfoModel = UserInfoModel.fromJson(response.object);
          errorMessage = null;
        });
      } else  {
        setState(() {
          errorMessage = response.message;
          userInfoModel = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!)),
        );
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading user info: $e';
        userInfoModel = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage!)),
      );
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: errorMessage != null
          ? Center(child: Text(errorMessage!))
          : userInfoModel == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        child: ListView(
          children: [
            _buildUserDetailRow('Username', userInfoModel?.userName ?? 'N/A'),
            _buildUserDetailRow('Password', userInfoModel?.password ?? 'N/A'),
            _buildUserDetailRow('Role', userInfoModel?.role ?? 'N/A'),
            _buildUserDetailRow('Customer Name', userInfoModel?.customerName ?? 'N/A'),
            _buildUserDetailRow('Email', userInfoModel?.email ?? 'N/A'),
            _buildUserDetailRow('Mobile', userInfoModel?.mobile ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scratch_project/app/models/user_model.dart';

class PastInterectionsController extends GetxController {
  var users = <UserModel>[].obs;
  final searchController = TextEditingController().obs;
  var isLoading = false.obs;
  var filteredUsers = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchController.value.addListener(_filterUsers);
  }

  Future<void> fetchAndUpdatePastInteractions(int userId) async {
    final url =
        'https://meet-around-apis-production.up.railway.app/api/jamming/getInteractions?userId=$userId';

    try {
      isLoading.value = true;

      final response = await http.get(Uri.parse(url));
      print('This is the response of the user interactions: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['responseCode'] == '4000') {
          final List<dynamic> dataList = jsonResponse['data'];

          users.value = dataList.map((data) {
            final userJson = data['targetUser'];
            return UserModel.fromJson(userJson);
          }).toList();
          _filterUsers();
        } else {
          throw Exception(
              'Failed to load user interactions: ${jsonResponse['responseDesc']}');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _filterUsers() {
    final query = searchController.value.text.toLowerCase();
    if (query.isEmpty) {
      filteredUsers.value = users;
    } else {
      filteredUsers.value = users.where((user) {
        return user.name.toLowerCase().contains(query);
      }).toList();
    }
  }
}

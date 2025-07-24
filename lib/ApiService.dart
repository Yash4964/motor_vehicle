// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/request/request.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ApiService extends GetConnect {
//   @override
//   void onInit() {
//     httpClient.baseUrl = 'https://motordriving.sathwarainfotech.com/api/';
//     httpClient.addRequestModifier((Request request) async{
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       request.headers['Authorization'] =prefs.getString("token") ?? "";
//       return request;
//     });
//     httpClient.maxAuthRetries = 3;
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class ApiService extends GetConnect {
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    httpClient.baseUrl = 'https://motordriving.sathwarainfotech.com/api/';
    httpClient.timeout = const Duration(seconds: 30);
    super.onInit();
  }

  Future<Map<String, String>> getAuthHeaders() async {
    return {
      "Authorization": storage.read("token") ?? "",
      "Content-Type": "application/json",
      "Cookie": "humans_21909=1",
    };
  }

  Future<Response> signUp(Map<String, dynamic> data) async {
    try {
      final String fullUrl = "https://motordriving.sathwarainfotech.com/api/register";
      debugPrint("SignUp API Request: $fullUrl\nPayload: $data");

      final response = await post(
        fullUrl,
        jsonEncode(data),
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint(
        "SignUp API Response: ${response.statusCode}\nBody: ${response.bodyString}",
      );
      return response;
    } catch (e, stack) {
      debugPrint("SignUp API Error: $e\nStack: $stack");
      rethrow;
    }
  }

  Future<Response> login(Map<String, dynamic> data) async {
    try {
      final String fullUrl = "https://motordriving.sathwarainfotech.com/api/login";
      debugPrint("Login API Request: $fullUrl\nPayload: $data");

      final response = await post(
        fullUrl,
        jsonEncode(data),
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint(
        "Login API Response: ${response.statusCode}\nBody: ${response.bodyString}",
      );
      return response;
    } catch (e, stack) {
      debugPrint("Login API Error: $e\nStack: $stack");
      rethrow;
    }
  }

  Future<Response> customerget() async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/customers';
      debugPrint("Customer GET API Request: $fullUrl");

      final response = await get(
        fullUrl,
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("Customer GET API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("Customer GET API Error: $e\nStack: $stack");
      rethrow;
    }
  }

  Future<Response> customeradd(Map<String, dynamic> data) async {
    try {
      final String fullUrl = "https://motordriving.sathwarainfotech.com/api/customers";
      debugPrint("Login API Request: $fullUrl\nPayload: $data");

      final response = await post(
        fullUrl,
        jsonEncode(data),
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint(
        "Login API Response: ${response.statusCode}\nBody: ${response.bodyString}",
      );
      return response;
    } catch (e, stack) {
      debugPrint("Login API Error: $e\nStack: $stack");
      rethrow;
    }
  }
  // customer update
  Future<Response> customerupdate(String id,Map<String, dynamic> data) async {
    try {
      final String fullUrl = "https://motordriving.sathwarainfotech.com/api/customers/$id";
      debugPrint("Login API Request: $fullUrl\nPayload: $data");

      final response = await put(
        fullUrl,
        jsonEncode(data),
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint(
        "Login API Response: ${response.statusCode}\nBody: ${response.bodyString}",
      );
      return response;
    } catch (e, stack) {
      debugPrint("Login API Error: $e\nStack: $stack");
      rethrow;
    }
  }
  Future<Response> customerdelete(String id) async {
    try {
      final String fullUrl = "https://motordriving.sathwarainfotech.com/api/customers/$id";
      debugPrint("Customer DELETE API Request: $fullUrl");

      final response = await delete(
        fullUrl,
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("Customer DELETE API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("Customer DELETE API Error: $e\nStack: $stack");
      rethrow;
    }
  }


}


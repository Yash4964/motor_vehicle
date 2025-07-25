

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

  //driver

  Future<Response> driverget() async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/drivers';
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

  Future<Response> driveradd(Map<String, dynamic> data) async {
    try {
      final String fullUrl = "https://motordriving.sathwarainfotech.com/api/drivers";
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

  Future<Response> driverupdate(String id,Map<String, dynamic> data) async {
    try {
      final String fullUrl = "https://motordriving.sathwarainfotech.com/api/drivers/$id";
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


  Future<Response> driverdelete(String id) async {
    try {
      final String fullUrl = "https://motordriving.sathwarainfotech.com/api/drivers/$id";
      debugPrint("Driver DELETE API Request: $fullUrl");

      final response = await delete(
        fullUrl,
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("Driver DELETE API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("Driver DELETE API Error: $e\nStack: $stack");
      rethrow;
    }
  }

  //vehicle

  Future<Response> vehicleget() async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/vehicles';
      debugPrint("vehicle GET API Request: $fullUrl");

      final response = await get(
        fullUrl,
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("vehicle GET API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("vehicle GET API Error: $e\nStack: $stack");
      rethrow;
    }
  }

  Future<Response> vehicleadd(Map<String, dynamic> data) async {
    try {
      final String fullUrl = "https://motordriving.sathwarainfotech.com/api/vehicles";
      debugPrint("vehicle add API Request: $fullUrl\nPayload: $data");

      final response = await post(
        fullUrl,
        jsonEncode(data),
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint(
        "vahicle add API Response: ${response.statusCode}\nBody: ${response.bodyString}",
      );
      return response;
    } catch (e, stack) {
      debugPrint("vehicle add API Error: $e\nStack: $stack");
      rethrow;
    }
  }
  Future<Response> vehicleupdate(String id,Map<String, dynamic> data) async {
    try {
      final String fullUrl = "https://motordriving.sathwarainfotech.com/api/vehicles/$id";
      debugPrint("vehicle update API Request: $fullUrl\nPayload: $data");

      final response = await put(
        fullUrl,
        jsonEncode(data),
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint(
        "vehicle update API Response: ${response.statusCode}\nBody: ${response.bodyString}",
      );
      return response;
    } catch (e, stack) {
      debugPrint("vehicle update API Error: $e\nStack: $stack");
      rethrow;
    }
  }


  Future<Response> vehicledelete(String id) async {
    try {
      final String fullUrl = "https://motordriving.sathwarainfotech.com/api/vehicles/$id";
      debugPrint("Vehicle DELETE API Request: $fullUrl");

      final response = await delete(
        fullUrl,
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("vehicle DELETE API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("vehicle DELETE API Error: $e\nStack: $stack");
      rethrow;
    }
  }
//package

  Future<Response> packageget() async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/packages';
      debugPrint("package GET API Request: $fullUrl");

      final response = await get(
        fullUrl,
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("package GET API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("package GET API Error: $e\nStack: $stack");
      rethrow;
    }
  }
  //package delete
  Future<Response> packagedelete(String id) async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/packages/$id';
      debugPrint("package GET API Request: $fullUrl");

      final response = await delete(
        fullUrl,
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("package GET API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("package GET API Error: $e\nStack: $stack");
      rethrow;
    }
  }

  Future<Response> packageadd(Map<String, dynamic> data) async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/packages';
      debugPrint("package GET API Request: $fullUrl");

      final response = await post(
        fullUrl,
        jsonEncode(data),
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("package GET API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("package GET API Error: $e\nStack: $stack");
      rethrow;
    }
  }

  Future<Response> packageupdate(String id , Map<String, dynamic> data) async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/packages/$id';
      debugPrint("package GET API Request: $fullUrl");

      final response = await put(
        fullUrl,
        jsonEncode(data),
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("package GET API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("package GET API Error: $e\nStack: $stack");
      rethrow;
    }
  }

  //booking

  Future<Response> bookingget() async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/bookings';
      debugPrint("Booking GET API Request: $fullUrl");

      final response = await get(
        fullUrl,
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("Booking GET API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("Booking GET API Error: $e\nStack: $stack");
      rethrow;
    }
  }

  Future<Response> bookingupdate(String id , Map<String, dynamic> data) async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/bookings/$id';
      debugPrint("booking GET API Request: $fullUrl");

      final response = await put(
        fullUrl,
        jsonEncode(data),
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("booking GET API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("booking GET API Error: $e\nStack: $stack");
      rethrow;
    }
  }

  Future<Response> bookingadd(Map<String, dynamic> data) async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/bookings';
      debugPrint("booking GET API Request: $fullUrl");

      final response = await post(
        fullUrl,
        jsonEncode(data),
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("booking GET API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("booking GET API Error: $e\nStack: $stack");
      rethrow;
    }
  }

  Future<Response> bookingdelete(String id) async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/bookings/$id';
      debugPrint("booking GET API Request: $fullUrl");

      final response = await delete(
        fullUrl,
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("booking GET API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("booking GET API Error: $e\nStack: $stack");
      rethrow;
    }
  }
  // payment get
  Future<Response> paymentget() async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/transactions';
      debugPrint("Booking GET API Request: $fullUrl");

      final response = await get(
        fullUrl,
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("Booking GET API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("Booking GET API Error: $e\nStack: $stack");
      rethrow;
    }
  }
// Payment: Add
  Future<Response> paymentadd(Map<String, dynamic> data) async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/transactions';
      debugPrint("Payment ADD API Request: $fullUrl\nPayload: $data");

      final response = await post(
        fullUrl,
        jsonEncode(data),
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("Payment ADD API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("Payment ADD API Error: $e\nStack: $stack");
      rethrow;
    }
  }

// Payment: Update
  Future<Response> paymentupdate(String id, Map<String, dynamic> data) async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/transactions/$id';
      debugPrint("Payment UPDATE API Request: $fullUrl\nPayload: $data");

      final response = await put(
        fullUrl,
        jsonEncode(data),
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("Payment UPDATE API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("Payment UPDATE API Error: $e\nStack: $stack");
      rethrow;
    }
  }

// Payment: Delete
  Future<Response> paymentdelete(String id) async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/transactions/$id';
      debugPrint("Payment DELETE API Request: $fullUrl");

      final response = await delete(
        fullUrl,
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("Payment DELETE API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("Payment DELETE API Error: $e\nStack: $stack");
      rethrow;
    }
  }

  //attendance get
  Future<Response> attendanceget() async {
    try {
      final String fullUrl = 'https://motordriving.sathwarainfotech.com/api/attendances';
      debugPrint("Booking GET API Request: $fullUrl");

      final response = await get(
        fullUrl,
        headers: await getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      debugPrint("Booking GET API Response: ${response.statusCode}\nBody: ${response.bodyString}");
      return response;
    } catch (e, stack) {
      debugPrint("Booking GET API Error: $e\nStack: $stack");
      rethrow;
    }
  }
}


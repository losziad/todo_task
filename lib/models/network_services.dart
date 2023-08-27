
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:todo_task/core/exceptions/internal_server_error/internal_server_error.dart';

import '../core/exceptions/bad_request/bad_request.dart';
import '../core/exceptions/not_found/not_found.dart';
class NetworkServices{
  Future<http.Response> makeRequest(String url,
      { Map<String, String>? headers, dynamic body, String method = 'POST'}) async {
    try {
      final uri = Uri.parse(url);
      final request = http.Request(method, uri);
      if (body != null) {
        request.body = jsonEncode(body);
      }
      final defaultHeaders = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      if (headers != null) {
        request.headers.addAll(headers);
      }
      request.headers.addAll(defaultHeaders);
      final response = await http.Client().send(request);
      final responseString = await response.stream.bytesToString();
     if (response.statusCode==400){
        throw BadRequest();
      }else if (response.statusCode==404){
        throw NotFound();
      }else if (response.statusCode==500){
        throw InternalServerError();
      }
      return http.Response(responseString, response.statusCode);
    }catch(e){
      rethrow;
    }
  }
  //


  // Future verifyRegister(String processId, String otp) async {
  //   const url = EndPoints.BASE_URL + EndPoints.ECOMMERCE_EP_VALIDATE_SIGN_UP_OTP;
  //   final body = {
  //     "processId": processId,
  //     "otp": otp,
  //   };
  //   try {
  //     final response = await makeRequest(url, body: body, method: 'POST');
  //     final jsonResponse = jsonDecode(response.body);
  //     return jsonResponse;
  //   } on Exception catch (e) {
  //     print('Exception: $e');
  //     rethrow;
  //   }
  // }


}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weblectuer_attendancesystem_nodejs/services/SecureStorage.dart';

class Authenticate {
  Future<String> registerUser(
      String userName, String email, String password) async {
    const URL = 'http://localhost:8080/api/teacher/register';
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    var request = {'email': email, 'password': password, 'username': userName};
    var body = json.encode(request);
    final response =
        await http.post(Uri.parse(URL), headers: headers, body: body);
    if (response.statusCode == 200) {
      return '';
    } else {
      final Map<String, dynamic> responseData1 = jsonDecode(response.body);
      print('Failed to register. Error: ${response.body}');
      return responseData1['message'];
    }
  }

  Future<String> verifyOTP(String email, String otp) async {
    const URL = 'http://localhost:8080/api/teacher/verifyRegister';
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    var request = {'email': email, 'OTP': otp};
    var body = json.encode(request);
    final response =
        await http.post(Uri.parse(URL), headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Registration successful');
      return '';
    } else {
      print('Failed to register. Error: ${response.body}');
      String message = jsonDecode(response.body)['message'];
      return message;
    }
  }

  Future<String> login(String email, String password) async {
    const URL = 'http://localhost:8080/api/teacher/login';
    var request = {'email': email, 'password': password};
    var body = json.encode(request);
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    final response =
        await http.post(Uri.parse(URL), headers: headers, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      var accessToken = responseData['accessToken'];
      var refreshToken = responseData['refreshToken'];
      var teacherID = responseData['teacherID'];
      var teacherEmail = responseData['teacherEmail'];
      var teacherName = responseData['teacherName'];

      print('--Response Data: $responseData');

      await SecureStorage().writeSecureData('accessToken', accessToken);
      await SecureStorage().writeSecureData('refreshToken', refreshToken);
      await SecureStorage().writeSecureData('teacherID', teacherID);
      await SecureStorage().writeSecureData('teacherEmail', teacherEmail);
      await SecureStorage().writeSecureData('teacherName', teacherName);
      return '';
    } else {
      // ignore: avoid_print
      final Map<String, dynamic> responseData1 = jsonDecode(response.body);
      print('Message: ${responseData1['message']}');
      return responseData1['message'];
    }
  }

  Future<String> forgotPassword(String email) async {
    const URL = 'http://localhost:8080/api/teacher/forgotPassword';
    var request = {'email': email};
    var body = jsonEncode(request);
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    final response =
        await http.post(Uri.parse(URL), headers: headers, body: body);
    if (response.statusCode == 200) {
      print('Successfully...forgot');
      return '';
    } else {
      print('Failed. Error: ${response.body}');
      String message = jsonDecode(response.body)['message'];
      return message;
    }
  }

  Future<String> verifyForgotPassword(String email, String otp) async {
    final response = await http.post(
        Uri.parse('http://localhost:8080/api/teacher/verifyForgotPassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{'email': email, 'OTP': otp}));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      var resetToken = responseData['resetToken'];
      await SecureStorage().writeSecureData('resetToken', resetToken);
      return '';
    } else {
      print('Failed to register. Error: ${response.body}');
      String message = jsonDecode(response.body)['message'];
      return message;
    }
  }

  Future<bool> resetPassword(String email, String newPassword) async {
    final resetToken = await SecureStorage().readSecureData("resetToken");
    final response = await http.post(
        Uri.parse('http://localhost:8080/api/teacher/resetPassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'authorization': resetToken
        },
        body: jsonEncode(
            <String, String>{'email': email, 'newPassword': newPassword}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> resendOTP(String email) async {
    final URL = 'http://localhost:8080/api/teacher/resendOTPRegister';
    var request = {'email': email};
    var body = jsonEncode(request);
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    final response =
        await http.post(Uri.parse(URL), headers: headers, body: body);
    if (response.statusCode == 200) {
      print('Successfully...');
      return true;
    } else {
      print('Failed');
      final Map<String, dynamic> responseData1 = jsonDecode(response.body);
      print('Message: ${responseData1['message']}');
      return false;
    }
  }

  Future<bool> resendOTPForgotPassword(String email) async {
    final URL = 'http://localhost:8080/api/teacher/resendOTP';
    var request = {'email': email};
    var body = jsonEncode(request);
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    final response =
        await http.post(Uri.parse(URL), headers: headers, body: body);
    if (response.statusCode == 200) {
      print('Successfully...');
      return true;
    } else {
      print('Failed');
      final Map<String, dynamic> responseData1 = jsonDecode(response.body);
      print('Message: ${responseData1['message']}');
      return false;
    }
  }
}

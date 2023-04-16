import 'dart:convert';
import 'dart:io';

import 'package:chat_pot/models/auth_response.dart';
import 'package:chat_pot/models/post_response.dart';
import 'package:chat_pot/models/success_response.dart';
import 'package:chat_pot/utils/user_pref.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ApiProvider {
  String baseUrl = "http://192.168.1.71:8080/api/v1";
  Future<AuthResponse> performLogin(jsonBody) async {
    var url = Uri.parse(baseUrl + "/user/login");
    try {
      http.Response response = await http.post(url, body: jsonBody);
      return AuthResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid data");
    }
  }

  Future<AuthResponse> performRegister(
      {String? firstName,
      String? lastName,
      String? password,
      String? email,
      String? dob,
      String? gender,
      image}) async {
    var url = Uri.parse(baseUrl + "/user/register");
    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['firstName'] = firstName!;
      request.fields['lastName'] = lastName!;
      request.fields['email'] = email!;
      request.fields['password'] = password!;
      request.fields['dob'] = dob!;
      request.fields['gender'] = gender!;

      request.files
          .add(await http.MultipartFile.fromPath("profilePicture", image));
      var response = await request.send();
      var jsonResponse = await http.Response.fromStream(response);
      return AuthResponse.fromJson(jsonResponse.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<MyPostResponse> fetchPost() async {
    var headers = {
      "authorization": "Bearer ${UserPreferences.getToken().toString()}"
    };
    var url = Uri.parse(baseUrl + "/status/get");
    try {
      http.Response response = await http.get(url, headers: headers);
      return MyPostResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid data");
    }
  }

  Future<MyPostResponse> userPost() async {
    var headers = {
      "authorization": "Bearer ${UserPreferences.getToken().toString()}"
    };
    var url = Uri.parse(baseUrl + "/status/myPost");
    try {
      http.Response response = await http.get(url, headers: headers);
      return MyPostResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid data");
    }
  }

  Future<AuthResponse> loginUser() async {
    var headers = {
      "authorization": "Bearer ${UserPreferences.getToken().toString()}"
    };
    var url = Uri.parse(baseUrl + "/user/loginUser");
    try {
      http.Response response = await http.get(url, headers: headers);

      return AuthResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid data");
    }
  }

  Future<SuccessResponse> editPost({String? id, jsonBody}) async {
    var url = Uri.parse(baseUrl + "/status/edit/$id");

    try {
      http.Response response = await http.put(url, body: jsonBody);
      print(response.body);
      return SuccessResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid data");
    }
  }

  Future<SuccessResponse> deletePost({String? id}) async {
    var url = Uri.parse(baseUrl + "/status/delete/$id");
    try {
      http.Response response = await http.delete(url);

      return SuccessResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid data");
    }
  }

  Future<SuccessResponse> changePassword(jsonBody) async {
    var headers = {
      "authorization": "Bearer ${UserPreferences.getToken().toString()}"
    };
    var url = Uri.parse(baseUrl + "/user/changePassword");
    try {
      http.Response response =
          await http.patch(url, body: jsonBody, headers: headers);

      return SuccessResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid data");
    }
  }

  Future<SuccessResponse> updateProfile(jsonBody) async {
    var headers = {
      "authorization": "Bearer ${UserPreferences.getToken().toString()}"
    };
    var url = Uri.parse(baseUrl + "/user/update");
    try {
      http.Response response =
          await http.put(url, body: jsonBody, headers: headers);

      return SuccessResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid data");
    }
  }

  Future<PostResponse> createPost(
      {String? message, List<XFile>? images}) async {
    var url = Uri.parse(baseUrl + "/status/create");
    var headers = {
      "authorization": "Bearer ${UserPreferences.getToken().toString()}"
    };
    List<http.MultipartFile> newList = [];
    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['message'] = message!;
      for (int i = 0; i < images!.length; i++) {
        var multiPartFile = await http.MultipartFile.fromPath(
            "photos", File(images[i].path).path);
        newList.add(multiPartFile);
      }
      request.headers.addAll(headers);
      request.files.addAll(newList);

      var response = await request.send();
      var jsonResponse = await http.Response.fromStream(response);
      return PostResponse.fromJson(jsonResponse.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }
}

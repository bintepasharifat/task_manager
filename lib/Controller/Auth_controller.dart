import 'package:task_manager/Model/User_Model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static UserModel? userModel;
  static String? accessToken;

  static const String _userDataKey = 'user_data';
  static const String _tokenKey = 'token';

  /// Save user data and token in local storage
  static Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    await sharedPreferences.setString(_tokenKey, token);

    userModel = model;
    accessToken = token;
  }

  /// Update user data only
  static Future<void> updateUserData(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    userModel = model;
  }

  /// Load user data from local storage (null-safe)
  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    String? userDataJson = sharedPreferences.getString(_userDataKey);
    accessToken = sharedPreferences.getString(_tokenKey);

    if (userDataJson != null && accessToken != null) {
      try {
        userModel = UserModel.fromJson(jsonDecode(userDataJson));
      } catch (e) {
        userModel = null;
        accessToken = null;
      }
    } else {
      userModel = null;
      accessToken = null;
    }
  }

  /// Check if user is logged in
  static Future<bool> isUserLoggedIn() async {
    await getUserData();
    return userModel != null && accessToken != null;
  }

  /// Clear user data and token
  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    userModel = null;
    accessToken = null;
  }
}

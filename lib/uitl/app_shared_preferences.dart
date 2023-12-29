import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// Save String [key] the key for save value [value] the value we need to save it
  setString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(key, value);
  }

  /// Save List of String [key] the key for save value [value] the value we need to save it
  setStringList(String key, List<String> value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setStringList(key, value);
  }

  /// Save Double [key] the key for save value [value] the value we need to save it
  setDouble(String key, double value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setDouble(key, value);
  }

  /// Save Bool [key] the key for save value [value] the value we need to save it
  setBool(String key, bool value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setBool(key, value);
  }

  /// Save int [key] the key for save value [value] the value we need to save it
  setInt(String key, int value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setInt(key, value);
  }

  /// save Object [key] the key for save value [value] the value we need to save it
  setObject(String key, value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(key, json.encode(value));
  }

  /// Get String [key] the key was saved
  getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  /// Get List of String [key] the key was saved
  getStringList(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getStringList(key);
  }

  /// Get Double [key] the key was saved
  getDouble(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getDouble(key);
  }

  /// Get Bool [key] the key was saved
  getBool(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(key);
  }

  /// Get Int [key] the key was saved
  getInt(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(key);
  }

  /// Get Object [key] the key was saved
  getObject(String key) async {
    final SharedPreferences prefs = await _prefs;
    var string = prefs.getString(key);
    if (string == null) {
      return null;
    }
    return json.decode(string);
  }

  /// clear all saved values in shared preferences
  clear() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }

  /// remove value based on [key] the key was saved
  remove(String key) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(key);
  }
}

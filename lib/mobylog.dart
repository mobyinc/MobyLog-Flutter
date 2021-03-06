library mobylog;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MobyLog {
  MobyLog._privateConstructor();

  String? _endpointUrl;
  http.Client? _httpClient;
  String _userId = 'anonymous';
  bool _switchedOff = false;

  static final MobyLog _instance = MobyLog._privateConstructor();

  factory MobyLog() {
    return _instance;
  }

  void init(String endpointUrl, http.Client httpClient) {
    _endpointUrl = endpointUrl;
    _httpClient = httpClient;
  }

  void setUser(String userId) {
    _userId = userId;
  }

  void clearUser() {
    _userId = 'anonymous';
  }

  void switchOff() {
    _switchedOff = true;
  }

  Future<bool> screen(String name, {String? info, Map? data}) async {
    return _log(_userId, 'screen', name, info: info, data: data);
  }

  Future<bool> event(String name, {String? info, Map? data}) async {
    return _log(_userId, 'event', name, info: info, data: data);
  }

  Future<bool> _log(String userId, String eventType, String name,
      {String? info, Map? data}) async {
    if (_endpointUrl == null) throw ErrorDescription('must initialize logger');
    if (_httpClient == null)
      throw ErrorDescription('must initialize http client');
    if (_switchedOff) return true;

    var uri = Uri.parse('$_endpointUrl/events');
    Map bodyData = {'userId': userId, 'eventType': eventType, 'name': name};

    if (info != null) bodyData['info'] = info;
    if (data != null) bodyData['data'] = data;

    var body = json.encode(bodyData);
    var response = await _httpClient!
        .post(uri, headers: {'Content-Type': 'application/json'}, body: body);

    return response.statusCode == 201;
  }
}

library moby_log;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MobyLog {
  MobyLog._privateConstructor();

  String? endpointUrl;

  static final MobyLog _instance = MobyLog._privateConstructor();

  factory MobyLog() {
    return _instance;
  }

  void init(String endpointUrl) {
    this.endpointUrl = endpointUrl;
  }

  Future<bool> logEvent(String userId, String eventType, String name,
      {String? info, Map? data}) async {
    if (this.endpointUrl == null)
      throw ErrorDescription('must initialize logger');

    var uri = Uri.parse('$endpointUrl/events');
    Map bodyData = {'userId': userId, 'eventType': eventType, 'name': name};

    if (info != null) bodyData['info'] = info;
    if (data != null) bodyData['data'] = data;

    var body = json.encode(bodyData);
    var response = await http.post(uri,
        headers: {'Content-Type': 'application/json'}, body: body);

    return response.statusCode == 201;
  }
}

import 'dart:convert';

import 'package:covid19app/Services/Utilites/app_url.dart';
import 'package:http/http.dart' as http;

import '../../Model/WorldStateModel.dart';

class StateServices {
  Future<WorldStateModel> faceWorldStateRecord() async {
    final response = await http.get(Uri.parse(AppUrl.baseUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('error');
    }
  }

  Future<List> countrylist() async {
    final response = await http.get(Uri.parse(AppUrl.countryList));
    var data;

    if (response.statusCode == 200) {
       data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('error');
    }
  }
}

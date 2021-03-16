import 'package:http/http.dart' as http;
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/utils/apis/constant.dart';
import 'dart:convert';

class Api {
  Future<List<User>> getUser() async {
    try {
      final response =
          await http.get(URL, headers: {"Content-type": "application/json"});
      if (response.statusCode == 200) {
        return jsonDecode(response.body).map<User>((data)=> User.fromJson(data)).toList();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

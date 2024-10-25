import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<Either<String, Map<String, dynamic>>> loginUser(
      {required String email, required String password}) async {
    try {
      final response = await http.post(Uri.parse('https://login'),
          headers: {'contentType': 'Application/json'},
          body: jsonEncode({'email': email, 'password': password}));
      if (response.statusCode != 200) {
        return Left('Failure');
      }
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(responseBody);
    } catch (e) {
      return Left('Failure');
    }
  }
}

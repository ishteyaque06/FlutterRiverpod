import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpodtest/core/failure/failure.dart';

//Using dummy api
class AuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> loginUser(
      {required String email, required String password}) async {
    try {
      final response = await http.post(Uri.parse('https://login'),
          headers: {'contentType': 'Application/json'},
          body: jsonEncode({'email': email, 'password': password}));
      if (response.statusCode != 200) {
        //Left keyword used from fpdart and considering left is error
        return Left(Failure(message: 'Failed'));
      }
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      //Right used from fpdart considering right is success
      return Right(responseBody);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}

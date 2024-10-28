import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpodtest/core/failure/failure.dart';
import 'package:riverpodtest/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

//Need to create ref for it bcz to initiate it ViewModel instead of directely
//Another Way of Doing it is without extending it
part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository();
}

//Using dummy api
class AuthRepository {
  Future<Either<AppFailure, UserModel>> loginUser(
      {required String email, required String password}) async {
    try {
      final response = await http.post(Uri.parse('https://login'),
          headers: {'contentType': 'Application/json'},
          body: jsonEncode({'email': email, 'password': password}));
      final jsonValue = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        //Left keyword used from fpdart and considering left is error
        return Left(AppFailure(jsonValue['detail']));
      }
      //Right used from fpdart considering right is success
      return Right(UserModel.fromMap(jsonValue));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}

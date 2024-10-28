import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtest/core/repository/auth_repository.dart';
import 'package:riverpodtest/model/user_model.dart';
//Using riverpod annotation, it will not generate code automatically
//Need to run a commnad in project path with -d to delete conflicting
//dart run build_runner watch -d
part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  final AuthRepository _authRepository = AuthRepository();
  //Async value means three value which is loading,error and data
  //Initially we set to null
  @override
  AsyncValue<UserModel>? build() {
    return null;
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    //Changing state to loading
    state = const AsyncLoading();
    final response =
        await _authRepository.loginUser(email: email, password: password);
    final _ = switch (response) {
      //Changing state to error
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      //Changing state to Success
      Right(value: final r) => state = AsyncValue.data(r),
    };
  }
}

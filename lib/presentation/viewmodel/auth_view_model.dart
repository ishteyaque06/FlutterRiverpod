import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtest/core/repository/auth_repository.dart';
import 'package:riverpodtest/core/user_preferences/user_preferences.dart';
import 'package:riverpodtest/model/user_model.dart';
//Using riverpod annotation, it will not generate code automatically
//Need to run a commnad in project path with -d to delete conflicting
//dart run build_runner watch -d
part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRepository _authRepository; //= AuthRepository();
  late UserPreferences _preferences;
  //Async value means three value which is loading,error and data
  //Initially we set to null
  @override
  AsyncValue<UserModel>? build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _preferences = ref.watch(userPreferencesProvider);
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
      Right(value: final r) => _success(r),
    };
  }

//Other way to check success data
  AsyncValue<UserModel>? _success(UserModel data) {
    return state = AsyncValue.data(data);
  }

  Future<UserModel?> getInitialData() async {
    final token = _preferences.getToken();
    if (token != null) {
      //Call the API,
      // Get data and return
      return UserModel(name: "Test", email: "Email", id: "absdfg");
    }
    return null;
  }
}

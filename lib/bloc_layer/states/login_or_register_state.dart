abstract class LoginOrRegisterState {
  const LoginOrRegisterState();
}

class UninitializedState extends LoginOrRegisterState {}

class LoginLoadingState extends LoginOrRegisterState {}

class SuccessLoginState extends LoginOrRegisterState {}

class ErrorHappenedState extends LoginOrRegisterState {
  final String errorMessage;

  ErrorHappenedState(this.errorMessage);
}

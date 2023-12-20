

abstract class LoginState{}
class LoginInitState extends LoginState{}
class LoginLoadingState extends LoginState{}

class LoginSuccessState extends LoginState{}

class LoginErrorState extends LoginState{
   String ? error;
  LoginErrorState(String this.error);
  String getError()
  {
    return error!;
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/logincubit/loginstate.dart';
import 'package:social/shared/cashe.dart';
import 'package:social/shared/reusable.dart';

class LoginCubit extends Cubit<LoginState>
{
  LoginCubit():super(LoginInitState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  void userLogin({
  String ? email,
    String ? password,
})
  {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!).then((value) {
      print(value.user!.uid);
      CacheHelper.setData(value: value.user!.uid,key: 'uId');
      uId=value.user!.uid;
      emit(LoginSuccessState());
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });



  }


}
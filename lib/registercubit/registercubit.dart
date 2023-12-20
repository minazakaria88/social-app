

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/socialmodel.dart';
import 'package:social/registercubit/registerstate.dart';

class RegisterCubit extends Cubit<RegisterState>
{
  RegisterCubit():super(RegisterInitState());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  void userRegister({
  String ? email,
    String ? password,
    String ? phone,
    String ? name,
})
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!).then((value) {
      createUser(
        name: name,
        phone: phone,
        email: email,
        uId: value.user?.uid,
      );
      emit(RegisterSuccessState());
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });


  }

  void createUser({
    String ? email,
    String ? uId,
    String ? phone,
    String ? name,
    String  image='lol',
    String cover='l',
    String bio='bio',
})
  {
    print(uId);
    print('lhlihlihl''lololol');
    SocialModel model=SocialModel(uId, email, phone, name,image,cover,bio);
      FirebaseFirestore.instance.collection('users').doc(uId).set(
        model.toMap()
      ).then((value) {
        print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
        emit(RegisterSuccessState());
      });

  }

}
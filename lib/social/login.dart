import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/logincubit/logincubit.dart';
import 'package:social/logincubit/loginstate.dart';
import 'package:social/shared/reusable.dart';
import 'package:social/social/home.dart';
import 'package:social/social/register.dart';
import 'package:social/social/socialLayout.dart';

class Login extends StatelessWidget {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
      listener: (context, state) {
        if(state is LoginSuccessState)
          {
                makeToast(
                  status: Status.success,
                  msg: 'Login Successfully',
                );
                Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => Home(),) , (route) => false);
          }
        else if(state is LoginErrorState)
          {
                 makeToast(
                   msg: state.error,
                   status: Status.error,
                 );
          }
      },
        builder: (context, state) {
        var cubit=LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Login to talk with your friends',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      newTextFormField(
                        iconData: Icons.email,
                        controller: email,
                        label: 'Email',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      newTextFormField(
                        iconData: Icons.password,
                        controller: password,
                        label: 'Password',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      newButton(
                        function: (){
                          if(formKey.currentState!.validate())
                          {
                            cubit.userLogin(
                              email: email.text,
                              password: password.text,
                            );
                          }
                          return null;
                        },
                        widget: state is LoginLoadingState ?const CircularProgressIndicator(color:  Colors.white,):const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        context: context,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an Account',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          TextButton(onPressed: (){
                            goTo(context, Register());

                          }, child: const Text(
                            'register now',
                            style: TextStyle(
                              color: Colors.pink,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/registercubit/registerstate.dart';
import '../registercubit/registercubit.dart';
import '../shared/reusable.dart';

class Register extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if(state is RegisterSuccessState)
          {

          }
          else if(state is RegisterErrorState)
          {
            makeToast(
              msg: state.error,
              status: Status.error,
            );
          }
        },
        builder: (context, state) {
          var cubit=RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Register'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Register',
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
                        'Register to talk with your friends',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      newTextFormField(
                        iconData: Icons.person,
                        controller: name,
                        label: 'User name',
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
                        label: 'password',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      newTextFormField(
                        iconData: Icons.phone,
                        controller: phone,
                        label: 'Phone',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      newButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.userRegister(
                              email: email.text,
                              password: password.text,
                              phone: phone.text,
                              name: name.text,
                            );
                          }
                          return null;
                        },
                        widget: state is RegisterLoadingState
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                        context: context,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/appcubit/appcubit.dart';
import 'package:social/appcubit/appstate.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),

          );
        },
      ),
    );
  }
}

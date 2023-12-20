import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/appcubit/appcubit.dart';
import 'package:social/shared/cashe.dart';
import 'package:social/shared/reusable.dart';
import 'package:social/social/home.dart';
import 'package:social/social/login.dart';
import 'package:social/social/socialLayout.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget ? startWidget;
  if (CacheHelper.getData(key: 'uId')==null)
    {
      startWidget=Login();
    }
  else
    {
      startWidget=const Home();
      uId=CacheHelper.getData(key: 'uId')!;
    }
  runApp(
      BlocProvider(
        create: (context) => AppCubit()..getUserData()..getPosts(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
        home: startWidget,
          theme: ThemeData(
            iconTheme: const IconThemeData(
              color: Colors.black,
              size: 25,
            ),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.black,
                size: 25,
              ),
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark
              ),
              titleTextStyle: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            textTheme: const TextTheme(
              headline1: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              elevation: 10,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.pink,
              unselectedItemColor: Colors.black,

            ),
          ),
    ),
      ),
  );
}


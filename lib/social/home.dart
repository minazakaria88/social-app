import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/appcubit/appcubit.dart';
import 'package:social/appcubit/appstate.dart';
import 'package:social/bottom_nav_screens/post.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
     listener: (context, state) {
               if(state is AppSearch)
                 {
                   Navigator.of(context).push(
                       MaterialPageRoute(builder: (context) =>  Post(),)
                   );
                 }
     },
      builder: (context, state) {
       var cubit=AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.title[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.notification_important_sharp)
              ),
              IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.search_rounded)
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat),label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(Icons.add_box_rounded),label: 'Add post'),
              BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle_outlined),label: 'Users'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}

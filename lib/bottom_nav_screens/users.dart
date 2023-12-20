import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/appcubit/appcubit.dart';
import 'package:social/appcubit/appstate.dart';
import 'package:social/social/chatsdetailscreen.dart';

class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
     listener: (context, state) {

     },
      builder: (context, state) {
       var list =AppCubit.get(context).allUsers;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              itemBuilder: (context, index) => InkWell(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsDetails(model: list[index],),));
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(list[index].image!),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      list[index].name!,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (context, index) => Container(
                height: 30,
              ),
              itemCount: list.length,
          ),
        );
      },
    );
  }
}

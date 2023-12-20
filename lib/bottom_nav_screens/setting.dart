import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/appcubit/appcubit.dart';
import 'package:social/appcubit/appstate.dart';
import 'package:social/social/editprofile.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var model=AppCubit.get(context).model;
        return Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.red,
                        height: 180,
                        width: double.infinity,
                        child: Image.network(
                          model!.cover!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ],
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green),
                  child:  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(model.image!),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
             Text(
              model.name!,
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
             Text(
              model.bio!,
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      Text(
                        'posts',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      Text(
                        '100',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        'posts',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      Text(
                        '100',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        'posts',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      Text(
                        '100',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        'posts',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      Text(
                        '100',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                   Expanded(
                     child: OutlinedButton(
                          child: const Text(
                            'Add photos',
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                          onPressed: () {}),
                   ),
                  const SizedBox(
                    width: 5,
                  ),
                  OutlinedButton(
                      child: const Icon(
                        Icons.edit
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => EditProfile(),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

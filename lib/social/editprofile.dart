import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/appcubit/appcubit.dart';
import 'package:social/appcubit/appstate.dart';
import 'package:social/shared/reusable.dart';

class EditProfile extends StatelessWidget {
   EditProfile({Key? key}) : super(key: key);
  TextEditingController bio=TextEditingController();
   TextEditingController name=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
     listener: (context, state) {

     },
      builder: (context, state) {
       var model=AppCubit.get(context).model;
       var profile=AppCubit.get(context).profileImage;
       var image=AppCubit.get(context).image;
       name.text=model!.name!;
       bio.text=model.bio!;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Edit',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25
              ),
            ),
            actions: [
              SizedBox(
                width: 100,
                child: IconButton(
                  onPressed: (){
                    AppCubit.get(context).checkUpdate(
                      bio: bio.text,
                      name: name.text,
                    );
                  },
                  icon: const Text(
                    'Update',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20
                    ),
                  ),
                ),
              ),

            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.red,
                                height: 180,
                                width: double.infinity,
                                child: image==null? Image.network(
                                   model.cover!,
                                  fit: BoxFit.cover,
                                ):Image.file(File(image.path)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                  onPressed: (){
                                    AppCubit.get(context).getImage();
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,

                                  )
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child:  CircleAvatar(
                            radius: 100,
                            backgroundImage: profile!=null? FileImage(File(profile.path)):NetworkImage(model.image!) as ImageProvider,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: IconButton(
                              onPressed: (){
                                AppCubit.get(context).getProfileImage();
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              )
                          ),
                        )
                      ],
                    ),
                  ],
                ),
               const  SizedBox(
                  height: 20,
                ),
                newTextFormField(
                  controller: name,
                  iconData: Icons.person,
                ),
                const  SizedBox(
                  height: 20,
                ),
                newTextFormField(
                  controller: bio,
                  iconData: Icons.info,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

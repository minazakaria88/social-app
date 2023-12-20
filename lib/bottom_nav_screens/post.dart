import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:social/appcubit/appcubit.dart';
import 'package:social/appcubit/appstate.dart';

class Post extends StatelessWidget {
   Post({Key? key}) : super(key: key);
  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context, state) {

      },
     builder: (context, state) {
        var cubit= AppCubit.get(context);
       return Scaffold(
         appBar: AppBar(
           title: const Text('Create Post',
             style: TextStyle(
               color: Colors.black,
               fontSize: 25,
             ),
           ),
           actions: [
             TextButton(
               onPressed: (){
                 if(cubit.postImage==null)
                   {
                     print(controller.text);
                     cubit.addPostWithoutImageSuccess(
                       text: controller.text,
                       datetime: DateTime.now().toString()
                     );
                   }
                 else
                   {
                     print(controller.text.toString());
                     cubit.addPostWithImageSuccess(
                         text: controller.text,
                         datetime: DateTime.now().toString()
                     );
                   }
               },
               child: const Text(' Post',),
             ),
           ],
         ),
         body: Padding(
           padding: const EdgeInsets.all(15.0),
           child: KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children:  [
                        CircleAvatar(
                          backgroundImage: NetworkImage('${cubit.model!.image}'),
                          radius: 45,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text('${cubit.model!.name}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: TextFormField(
                        onTap: ()
                        {
                          print(isKeyboardVisible);
                        },
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'what is in your mind... ',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  if(cubit.postImage!=null&&isKeyboardVisible)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: Image.file(File(cubit.postImage!.path))),
                          FloatingActionButton(
                            mini: true,
                            onPressed: ()
                            {
                              cubit.clearPostImage();
                            },
                            child: const Icon(
                              Icons.clear,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            TextButton(
                              onPressed: (){
                                cubit.getPostImage();
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.image,
                                  ),
                                  Text(' Add photos',)
                                ],
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: (){

                          },
                          child: const Text(' #tags',),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
           ),
         ),
       );
     },
    );
  }
}

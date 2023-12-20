import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/appcubit/appcubit.dart';
import 'package:social/appcubit/appstate.dart';
import 'package:social/models/socialmodel.dart';

class ChatsDetails extends StatelessWidget {
  SocialModel ? model;
  ChatsDetails({this.model});
  @override
  Widget build(BuildContext context) {
    return Builder(
     builder: (context) {
       AppCubit.get(context).getMessages(
         receiverId: model!.uId,
       );
       return BlocConsumer<AppCubit,AppState>(
         listener: (context, state) {

         },
         builder: (context, state) {
           return Scaffold(
             appBar: AppBar(
               title:  Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                   children: [
                     CircleAvatar(
                       radius: 20,
                       backgroundImage: NetworkImage(model!.image!),
                     ),
                     const SizedBox(
                       width: 20,
                     ),
                     Text(
                       model!.name!,
                       style: const TextStyle(
                         fontSize: 25,
                       ),
                     ),
                   ],
                 ),
               ),
             ),
             body: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 children:  [
                 AppCubit.get(context).messages.isNotEmpty? Expanded(
                   child: ListView.separated(
                        itemBuilder: (context, index) {
                          if(AppCubit.get(context).messages[index].receiverId==model!.uId) {
                            return myListItem(text: AppCubit.get(context).messages[index].text);
                          }
                          else
                            {
                              return hisListItem(text: AppCubit.get(context).messages[index].text);
                            }
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                        itemCount: AppCubit.get(context).messages.length,
                    ),
                 ): const Expanded(child: Center(child: CircularProgressIndicator())),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       clipBehavior: Clip.antiAliasWithSaveLayer,
                       decoration: BoxDecoration(
                         border: Border.all(
                             width: 2,
                             color: Colors.black
                         ),
                         borderRadius: BorderRadius.circular(10),
                       ),
                       child: Row(
                         children: [
                           Expanded(
                             child: TextFormField(
                               decoration: const InputDecoration(
                                   hintText: 'Write your message here...'
                               ),
                               controller:  AppCubit.get(context).controller,
                             ),
                           ),
                           Container(
                             color: Colors.pink,
                             child: MaterialButton(
                               onPressed: (){
                                 AppCubit.get(context).sendMessage(
                                   receiverId: model!.uId,
                                   text:  AppCubit.get(context).controller.text,
                                   dateTime: DateTime.now().toString(),
                                 );

                               },
                               minWidth: 20,
                               child: const Icon(
                                 Icons.send,
                                 color: Colors.white,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           );
         },
       );
     },
    );
  }
  Widget myListItem({
  String ? text,
})=>Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          ),
        ),
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text!,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    ),
  );
  Widget hisListItem({
    String ? text,
})=> Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          ),
        ),
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text!,
            style:const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    ),
  );
}

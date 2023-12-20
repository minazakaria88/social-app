import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/appcubit/appcubit.dart';
import 'package:social/appcubit/appstate.dart';
import 'package:social/models/postmodel.dart';
class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var list=AppCubit.get(context).posts;
        return SingleChildScrollView(
          child: Column(
            children:  [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    child: Image(
                      image: AssetImage('images/lol.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              list.isNotEmpty? ListView.separated
                (
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => item(list[index],context,index),
                  separatorBuilder: (context, index) => const SizedBox(height: 10,),
                  itemCount: list.length,
              ):const Center(child:  CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }
  Widget item(PostModel model,context,index)=>Card(
    elevation:
    5,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('${model.image}'),
                  radius: 25,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children:  [
                      Text('${model.name}',),
                      const SizedBox(
                        width: 3,
                      ),
                      const Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  Text('${model.datetime}'),
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: (){

                  },
                  icon: const Icon(Icons.more_horiz)
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ),
           Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text('${model.text}'),
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: MaterialButton(
                    child:  const Text('#flutter',
                      style: TextStyle(
                          color: Colors.blue
                      ),
                    ),
                    onPressed: ()
                    {

                    }
                ),
              ),
            ],
          ),
             SizedBox(
            width: double.infinity,
            height: 200,
            child: Card(
              elevation: 5,
              child: Image(
                image: NetworkImage('${model.postImage}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: ()
                  {

                  },
                  child: Row(
                    children:   [
                      const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                      Text(
                        '${AppCubit.get(context).numberOfLikes[index]}',
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: ()
                  {

                  },
                  child: Row(
                    children:  const [
                      Icon(
                        Icons.comment,
                        color: Colors.amber,
                      ),
                      Text(
                        'chats',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 2,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children:  [
                 CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage('${AppCubit.get(context).model!.image}'),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  'write a comment...',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: ()
                  {
                    AppCubit.get(context).likes(AppCubit.get(context).postsIds[index]);
                  },
                  child: Row(
                    children:  const [
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      Text(
                        'Like',
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    ),
  );
}

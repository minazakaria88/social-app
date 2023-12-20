


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/appcubit/appstate.dart';
import 'package:social/bottom_nav_screens/chats.dart';
import 'package:social/bottom_nav_screens/feeds.dart';
import 'package:social/bottom_nav_screens/post.dart';
import 'package:social/bottom_nav_screens/setting.dart';
import 'package:social/bottom_nav_screens/users.dart';
import 'package:social/models/messagemodel.dart';
import 'package:social/models/postmodel.dart';
import 'package:social/shared/reusable.dart';

import '../models/socialmodel.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeIndex(index) {
    if(index==3)
      {
        getAllUsers();
      }
     if (index == 2) {
      emit(AppSearch());
    } else {
      currentIndex = index;
      emit(AppChangeBottom());
    }
  }

  List<Widget> screens = [
    const Feeds(),
    const Chats(),
     Post(),
    const Users(),
    const Setting(),
  ];
  List<String> title = [
    'New Feeds',
    'Chats',
    'post',
    'Users',
    'Settings',
  ];

  SocialModel? model;
  void getUserData() {
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = SocialModel.fromJson(value.data()!);
      emit(GetUserSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetUseError());
    });
  }


  final ImagePicker picker = ImagePicker();
  XFile  ? profileImage;
  void getProfileImage()async
  {
    profileImage =await picker.pickImage(source: ImageSource.gallery);
    if(profileImage !=null)
      {
        print(profileImage);
        print('sjhfoidshgoidhgojeropjgeolllllllllllllllllllll');
        emit(GetProfileImage());

      }
    else
      {
        print('no image');
      }


  }

  XFile  ? image;
  void getImage()async
  {
   image =await picker.pickImage(source: ImageSource.gallery);
   if(image !=null)
   {
     print('${image}lololololo');
     emit(GetProfileImage());

   }
   else
   {
     print('no image');
   }

  }



  void uploadProfileImage({
  String ?name,
    String ? bio,
})
  {
    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(File(profileImage!.path))
        .then((value) {
          value.ref.getDownloadURL().then((value) {
            updateUser(
              image: value,
              uId: model!.uId,
              email: model!.email,
              phone: model!.phone,
              name: name,
              bio: bio,
              cover: model!.cover,
            );
          });
    });
  }

  void uploadCoverImage({
  String ? name,
    String?bio,
})
  {
    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(image!.path).pathSegments.last}')
        .putFile(File(image!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          image: model!.image,
          uId: model!.uId,
          email: model!.email,
          phone: model!.phone,
          name: name,
          bio: bio,
          cover: value,
        );

      });
    });
  }

  void updateUser({
    String ? email,
    String ? uId,
    String ? phone,
    String ? name,
    String  ? image,
    String ?cover,
    String ? bio,
})
  {
    FirebaseFirestore.instance.collection('users').
    doc(model!.uId).update(
      {
        'bio':bio,
        'email':email,
        'uId':uId,
        'phone':phone,
        'name':name,
        'image':image,
        'cover':cover,
      }
    ).then((value) {
      getUserData();
    });
  }

  void checkUpdate({
  String ?name,
    String ?bio,
})
  {

    if(image !=null&&profileImage !=null)
      {
        uploadCoverImage(
          bio: bio,
          name: name,
        );
        uploadProfileImage(
          bio: bio,
          name: name,
        );
      }
    else if(image !=null)
      {
        uploadCoverImage(
          bio: bio,
          name: name,
        );
      }
    else if(profileImage!=null)
      {
        uploadProfileImage(
          bio: bio,
          name: name,
        );
      }
  }

  PostModel ? postModel;
  void addPostWithoutImageSuccess({
    String ? text,
    String ? datetime,
  })
  {
    postModel=PostModel(
      image: model!.image,
      name: model!.name,
      uId: model!.uId,
      text: text,
      datetime: datetime,
    );
    FirebaseFirestore.instance.collection('posts')
        .add(postModel!.toMap()).then((value) {
          emit(AddPostWithoutImageSuccess());
    });

  }

   XFile ? postImage;
  void getPostImage()async
  {
    postImage =await picker.pickImage(source: ImageSource.gallery);
    if(postImage !=null)
    {
      print('${postImage}lololololo');
      emit(GetProfileImage());

    }
    else
    {
      print('no image');
    }

  }
  void addPostWithImageSuccess({
    String ? text,
    String ? datetime,
  })
  {

    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(File(postImage!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        postModel=PostModel(
          image: model!.image,
          name: model!.name,
          uId: model!.uId,
          text: text,
          postImage: value,
          datetime: datetime,
        );
        FirebaseFirestore.instance.collection('posts')
            .add(postModel!.toMap()).then((value) {
          emit(AddPostWithImageSuccess());
        });

      });
    });
  }

  void clearPostImage()
  {
    postImage=null;
    emit(ClearImage());
  }

  List<PostModel> posts=[];
  List<String> postsIds=[];
  List<int> numberOfLikes=[];
  void getPosts()
  {
    posts.clear();
    FirebaseFirestore.instance.collection('posts').get().then((value) {
              value.docs.forEach((element) {
                element.reference
                .collection('likes').get()
                .then((value) {
                  numberOfLikes.add(value.docs.length);
                  postsIds.add(element.id);
                  posts.add(PostModel.fromJson(element.data()));
                  print(posts.length);
                  emit(GetPostsSuccess());
                });
              });

    });
  }
  void likes(postId)
  {
    FirebaseFirestore.instance.collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({
      'like':true,
    })
        .then((value) {
         // getPosts();
          emit(SetLikeSuccess());
    });
  }
   List<SocialModel> allUsers=[];
  void getAllUsers()
  {
    if(allUsers.isEmpty) {
      FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            if(element.data()['uId']!=model!.uId!) {
              allUsers.add(SocialModel.fromJson(element.data()));
            }

            emit(GetAllUsers());
          });
    });
    }

  }
  void sendMessage({
  String ? receiverId,
    String?text,
    String ? dateTime,
})
  {
    MessageModel model1=MessageModel(
      text: text,
      dateTIme: dateTime,
      receiverId: receiverId,
      senderId: model!.uId,
    );
    FirebaseFirestore.instance.collection('users')
        .doc(model!.uId!)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model1.toMap())
        .then((value) {
          emit(SendMessageSuccess());
    });

    FirebaseFirestore.instance.collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(model1.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    });
  }


  TextEditingController controller=TextEditingController();

  void clearController()
  {
    controller.clear();
    emit(ClearController());
  }


  List<MessageModel> messages=[];
  void getMessages({
  String ? receiverId,ProductsModel
})
  {

    FirebaseFirestore.instance.collection('users')
        .doc(model!.uId!)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .snapshots()
        .listen((event) {
           messages=[];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
            emit(GetMessageSuccess());
          });
    });
  }








}

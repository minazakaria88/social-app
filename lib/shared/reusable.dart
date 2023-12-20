import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social/shared/reusable.dart';

Widget newTextFormField({
  TextEditingController? controller,
  IconData? iconData,
  String? label,
}) =>
    Card(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextFormField(
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'required';
              }

              return null;
            },
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(
                iconData,
                color: Colors.black,
              ),
              labelText: label,
              labelStyle: const TextStyle(
                color: Colors.pink,
              ),
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.pink,
              )),
            ),
          ),
        ),
      ),
    );

Widget newButton({
  context,
  String? text,
  Widget ? widget,
  Function? Function()? function,
}) =>
    Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.pink,
        ),
        width: MediaQuery.of(context).size.width / 1.32,
        child: MaterialButton(
          onPressed: function,
          child: widget,
        ),
      ),
    );

void goTo(context, screen) => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => screen,
    ));

void makeToast({
  String ? msg,
  Status ? status,
})
{
  Fluttertoast.showToast(
      msg: msg!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: getColor(status!),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
 enum Status{
  error,
   success,
 }
 Color getColor(Status status)
 {
   Color ? color;
   if(status.index==0)
     {
       color=Colors.red;
     }
   else
     {
      color =Colors.green;
     }
   return color;
 }
 String uId='';
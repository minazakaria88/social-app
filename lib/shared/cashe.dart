import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
   static SharedPreferences ? x;
   static Future<SharedPreferences> init()async
   {
     x=await SharedPreferences.getInstance();
     return x!;
   }

   static void setData({
  String ?key,
     String ?value,
})
   {
     x!.setString(key!, value!);
   }

  static String? getData({
  String ?key,
})
   {
    return x!.getString(key!);
   }

}

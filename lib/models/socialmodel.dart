class SocialModel{
  String ? name;
  String ? email;
  String ? uId;
  String ?phone;
  String ? image;
  String ? bio;
  String ? cover;
  SocialModel(
      this.uId,
      this.email,
      this.phone,
      this.name,
      this.image,
      this.bio,
      this.cover,
      );
  Map <String,dynamic> toMap()
  {
    return
        {
          'name':name,
          'phone':phone,
          'uId':uId,
          'email':email,
          'image':image,
          'bio':bio,
          'cover':cover,
        };
  }
  SocialModel.fromJson(Map<String,dynamic> json)
  {
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    bio=json['bio'];
    cover=json['cover'];
  }
}
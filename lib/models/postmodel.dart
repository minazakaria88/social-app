class PostModel{
  String ? name;
  String ? uId;
  String ? datetime;
  String ? text;
  String ? postImage;
  String ? image;
  PostModel(
  {
    this.uId,
    this.text,
    this.datetime,
    this.postImage,
    this.name,
    this.image,
}
      );
  Map <String,dynamic> toMap()
  {
    return
      {
        'name':name,
        'text':text,
        'datetime':datetime,
        'postImage':postImage,
        'uId':uId,
        'image':image,
      };
  }
  PostModel.fromJson(Map<String,dynamic> json)
  {
    name=json['name'];
    uId=json['uId'];
    image=json['image'];
    text=json['text'];
    datetime=json['datetime'];
    postImage=json['postImage'];
  }
}
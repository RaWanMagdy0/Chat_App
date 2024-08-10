class Room {
  static const String collectionName='rooms';
  String room_Id;
  String title;
  String description;
  String category_Id;
  Room(
      {required this.title,
      required this.category_Id,
      required this.description,
      required this.room_Id});
  Room.fromJson(Map<String,dynamic>json):this
      (
      room_Id: json['room_id'] as String,
      title:json['title'] as String ,
      description: json['description'] as String,
      category_Id: json['category_id'] as String,

    );
  Map<String,dynamic>tojson(){
    return{
      'room_id':room_Id,
      'title':title,
      'description':description,
      'category_id':category_Id,

    };

  }
}

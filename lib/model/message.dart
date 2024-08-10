class Message {
  static const String collectionName='message';
  String id;
  String room_Id;
  String content;
  String sender_Id;
  String sender_Name;
  int date_Time;

  Message({
    this.id = '',
    required this.room_Id,
    required this.content,
    required this.date_Time,
    required this.sender_Id,
    required this.sender_Name,
  });

  Message.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          room_Id: json['room_Id'] as String,
          content: json['content'] as String,
          date_Time: json['date_Time'] as int,
          sender_Name: json['sender_Name'] as String,
          sender_Id: json['sender_Id'] as String,
        );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'room_Id': room_Id,
      'content': content,
      'date_Time': date_Time,
      'sender_Name': sender_Name,
      'sender_Id': sender_Id,
    };
  } 
}

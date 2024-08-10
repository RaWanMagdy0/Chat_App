import 'package:chattapp/database/database_utils.dart';
import 'package:chattapp/model/message.dart';
import 'package:chattapp/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../model/room.dart';
import 'chat_screen_navigator.dart';

class ChatScreenViewModel extends ChangeNotifier {
  late ChatNavigator navigator;
  late MyUser currentUser;
  late Room room;
  late Stream<QuerySnapshot<Message>>streamMessage;
  void sendMessage(String content)async {
    Message message = Message(
        room_Id: room.room_Id,
        content: content,
        date_Time: DateTime.now().millisecondsSinceEpoch,
        sender_Id: currentUser.id,
        sender_Name: currentUser.userName);
    try{
      var res=await DatabaseUtils.insertMessage(message);
      //clear message
      navigator.clearMessage();

    }catch(error){
      navigator.showMessage(error.toString());

    }
  }
  void listenForUpdateMessages( ){
    streamMessage = DatabaseUtils.getMessagesFromFireStore(room.room_Id);
  }
}

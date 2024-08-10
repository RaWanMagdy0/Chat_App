import 'package:chattapp/database/database_utils.dart';
import 'package:chattapp/model/room.dart';
import 'package:chattapp/ui/add_room/add_room_navigator.dart';
import 'package:flutter/cupertino.dart';

class AddRoomViewModel extends ChangeNotifier {
  late AddRoomNavigator navigator;

  Future<void> addRoom(String roomTitle, String roomDescription, String categoryId) async {
    Room room=Room(title: roomTitle, category_Id: categoryId, description: roomDescription, room_Id:'');
try{
  navigator.showLoading();
  var createdRoom=await DatabaseUtils.addRoomToFireStore(room);
  navigator.hideLoading();
  navigator.showMessage('Rooms Was added successfully');
  navigator.navigatorToHome();
}catch(e){
navigator.hideLoading();
navigator.showMessage(e.toString());

}
  }
}

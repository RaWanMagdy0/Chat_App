import 'package:chattapp/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import '../../model/room.dart';

class RoomWidget extends StatelessWidget {
Room room ;
RoomWidget({required this.room});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(ChatScreen.routeName,arguments: room);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),

          ],
        ),
        child: Column(
          children: [
            Image.asset('assets/images/${room.category_Id}.png'
                ,height: 80,
            fit: BoxFit.fill,),
           SizedBox(height: 10,),
            Text(room.title),
          ],
        ),
      ),
    );
  }
}

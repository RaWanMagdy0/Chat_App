import 'package:chattapp/model/message.dart';
import 'package:chattapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return provider.user?.id == message.sender_Id
        ? SendMessage(message: message)
        : RecieveMessage(message: message);
  }
}

class SendMessage extends StatefulWidget {
  Message message;
  SendMessage({required this.message});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 24),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              )),
          child: Text(
            widget.message.content,
            style: TextStyle(color: Colors.white),
          ),
        ),
        Text(
          widget.message.date_Time.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}

class RecieveMessage extends StatefulWidget {
  Message message;
  RecieveMessage({required this.message});

  @override
  State<RecieveMessage> createState() => _RecieveMessageState();
}

class _RecieveMessageState extends State<RecieveMessage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 24),
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade700,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              )),
        ),
        Text(
          widget.message.date_Time.toString(),
          style: TextStyle(color: Colors.black),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )),
          child: Text(
            widget.message.content,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

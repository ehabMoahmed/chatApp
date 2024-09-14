import 'package:chat_app/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

import '../../../../data-layer/model/messages_model/message.dart';

class ChatWidgetOfFriend extends StatelessWidget {
  MessageModel message;
  ChatWidgetOfFriend(this.message);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only( top: 15,bottom: 15),
        decoration: BoxDecoration(

          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)
          ),
        ),
        child: Padding(
          padding:   EdgeInsets.all(8.0),
          child: Text(message.text,style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}

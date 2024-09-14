import 'package:chat_app/presentation/ui/Chat/widgets/ChatWidgetOfFriend.dart';
import 'package:chat_app/presentation/ui/Chat/widgets/ChatWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/colors_manager.dart';
import '../../../core/utils/strings_manager.dart';
import '../../../data-layer/model/messages_model/message.dart';

class ChatPage extends StatelessWidget {

 //kda 3mlt refrence
  final _scrollController = ScrollController();  //listView
  CollectionReference messages = FirebaseFirestore.instance.collection(KMessage);
  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email=ModalRoute.of(context)!.settings.arguments;

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt',descending: true) .snapshots(),
      builder:(context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData ) {
          List<MessageModel> messagesList=[];
            for(int i=0;i<snapshot.data!.docs.length;i++)
              {
                messagesList.add(MessageModel.fromjson(snapshot.data!.docs[i]));
              }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorManager.primaryColor,
              automaticallyImplyLeading: true,
              centerTitle: true,
              title: Text("Chat",style: TextStyle(color: Colors.white,fontSize: 20),),

            ),

            body: Padding(
              padding:   EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      reverse: true,
                      controller:_scrollController ,
                      itemBuilder:  (context, index) => messagesList[index].id==email? ChatWidget(messagesList[index]):ChatWidgetOfFriend(messagesList[index]),
                      itemCount:messagesList.length ,
                      separatorBuilder: (context, index) => SizedBox(height: 10,),

                    ),
                  ),
                  TextField(
                    onSubmitted: (value) {
                      messages.add({
                        'message':value,
                        'createdAt': DateTime.now(),
                        'id':email,
                      });
                      controller.clear();
                      _scrollController.animateTo(
                          0,
                          duration: Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn);
                    },
                    controller: controller,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.send),
                        hintText: "write...",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.primaryColor),
                          borderRadius: BorderRadius.circular(12),
                        )
                    ),
                  ),

                ],

              ),
            ),
          );
        }


        return Center(child: CircularProgressIndicator());
      },
    );



  }
}
/*Scaffold(
      appBar: AppBar(
                  backgroundColor: ColorManager.primaryColor,
                  automaticallyImplyLeading: true,
                  centerTitle: true,
                  title: Text("Chat",style: TextStyle(color: Colors.white,fontSize: 20),),

                ),

      body: Padding(
        padding:   EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder:  (context, index) => Align(
                    alignment: Alignment.centerLeft,
                    child: ChatWidget()),
                itemCount: 18,
                separatorBuilder: (context, index) => SizedBox(height: 10,),

              ),
            ),
            TextField(
              onSubmitted: (value) {
                    messages.add({
                      'message':value,
                    });
                    controller.clear();
              },
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.send),
hintText: "write...",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.primaryColor),
                  borderRadius: BorderRadius.circular(12),
                )
              ),
            ),

          ],

        ),
      ),
    )*/
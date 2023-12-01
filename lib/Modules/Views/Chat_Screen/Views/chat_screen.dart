import 'dart:developer';
import 'package:chat_app_3/Modules/Utils/Helpers/Authentication_Helper/auth_helper.dart';
import 'package:chat_app_3/Modules/Utils/Helpers/Cloud_FireStore_Helper/cloud_firestore_helper.dart';
import 'package:chat_app_3/Modules/Utils/Stream/stream.dart';
import 'package:chat_app_3/Modules/Views/Chat_Screen/Model/Chat_Model/chat_model.dart';
import 'package:chat_app_3/Modules/Views/Chat_Screen/Model/Receiver_Details_Model/receiver_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chat_Screen extends StatelessWidget {
  Chat_Screen({super.key});
  TextEditingController messageController = TextEditingController();
  String? message;
  @override
  Widget build(BuildContext context) {
    Receiver receiver = ModalRoute.of(context)!.settings.arguments as Receiver;

    return Scaffold(
      appBar: AppBar(
        title: Text("${receiver.name}"),
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 30,
            foregroundImage: NetworkImage("${receiver.photo}"),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: messageData,
                builder: (ctx, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    QuerySnapshot? querysnapshot = snapshot.data;
                    List<QueryDocumentSnapshot>? chats = querysnapshot?.docs;
                    return ListView.builder(
                        reverse: true,
                        itemCount: chats?.length,
                        itemBuilder: (ctx, i) {
                          return Chip(label: Text("${chats?[i]['message']}"));
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            TextFormField(
              controller: messageController,
              onChanged: (val) {
                message = val;
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    ChatDetails chatdetails = ChatDetails(
                        receiverUid: receiver.uid,
                        senderUid:
                            Auth_Helper.auth_helper.auth.currentUser!.uid,
                        message: message!);

                    Firestore_Helper.firestore_helper
                        .sendMessage(chatDetails: chatdetails);
                    log("${message}");
                    messageController.clear();
                  },
                  icon: Icon(Icons.send),
                ),
                hintText: "send message.....",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

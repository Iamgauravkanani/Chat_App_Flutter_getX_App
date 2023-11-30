import 'dart:developer';

import 'package:chat_app_3/Modules/Views/Chat_Screen/Model/Receiver_Details_Model/receiver_details_model.dart';
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
              child: Container(),
            ),
            TextFormField(
              controller: messageController,
              onChanged: (val) {
                message = val;
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
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

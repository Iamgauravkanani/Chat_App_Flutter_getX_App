import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Utils/Helpers/Authentication_Helper/auth_helper.dart';
import '../../../../../../Utils/Helpers/Cloud_FireStore_Helper/cloud_firestore_helper.dart';
import '../../../../../../Utils/Stream/stream.dart';
import '../../../../../Chat_Screen/Model/Chat_Model/chat_model.dart';
import '../../../../../Chat_Screen/Model/Receiver_Details_Model/receiver_details_model.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore_Helper.firestore_helper.fetchUser(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? userData =
                querySnapshot?.docs;

            return ListView.builder(
                itemCount: userData?.length,
                itemBuilder: (ctx, i) {
                  return Card(
                      elevation: 3,
                      child: ListTile(
                        onTap: () async {
                          Receiver receiver = Receiver(
                              name: userData?[i]['name'],
                              uid: userData?[i]['uid'],
                              photo: userData?[i]['photo']);

                          ChatDetails chatdata = ChatDetails(
                              receiverUid: receiver.uid,
                              senderUid:
                                  Auth_Helper.auth_helper.auth.currentUser!.uid,
                              message: "");
                          messageData = await Firestore_Helper.firestore_helper
                              .displayMessage(chatDetails: chatdata);
                          Get.toNamed("/chat", arguments: receiver);
                        },
                        title: Text("${userData?[i]['name']}"),
                        subtitle: Text("${userData?[i]['email']}"),
                        leading: CircleAvatar(
                          radius: 30,
                          foregroundImage:
                              NetworkImage("${userData?[i]['photo']}"),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Firestore_Helper.firestore_helper.deleteUser(
                                deleteData: "${userData?[i]['uid']}");
                          },
                          icon: Icon(Icons.delete_outline),
                        ),
                      ));
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

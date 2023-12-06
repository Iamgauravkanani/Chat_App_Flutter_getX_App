import 'dart:io';

import 'package:chat_app_3/Modules/Utils/Helpers/Authentication_Helper/auth_helper.dart';
import 'package:chat_app_3/Modules/Views/Chat_Screen/Model/Chat_Model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class Firestore_Helper {
  Firestore_Helper._();

  static final Firestore_Helper firestore_helper = Firestore_Helper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  //TODO:Add Image to Firebase Storage and Retrive from There.

  Future<String> uploadImage({required File image}) async {
    var storageRef = firebaseStorage.ref().child("Image/${image.path}");
    var uploadImage = storageRef.putFile(image);

    await uploadImage;

    String downloadedUrl = await uploadImage.snapshot.ref.getDownloadURL();
    return downloadedUrl;
  }

  //todo:Add User

  Future<void> addUser({required Map<String, dynamic> user_data}) async {
    await firestore
        .collection("user")
        .doc("${Auth_Helper.auth_helper.auth.currentUser?.uid}")
        .set(user_data);
  }

  //todo:Fetch User
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUser() {
    return firestore
        .collection("user")
        .where("uid",
            isNotEqualTo: Auth_Helper.auth_helper.auth.currentUser?.uid)
        .snapshots();
  }

  //todo:Delete User
  Future<void> deleteUser({required var deleteData}) async {
    await firestore.collection("user").doc("$deleteData").delete();
  }

  Future<void> sendMessage({required ChatDetails chatDetails}) async {
    //todo:given value to u1 and u2 for check if chatroom is available or not
    String u1 = chatDetails.senderUid;
    String u2 = chatDetails.receiverUid;

    //todo:fetched all chaRooms
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection("chats").get();

    List<QueryDocumentSnapshot> allDocs = querySnapshot.docs;

    bool chatRoomAvailable = false;
    String fetchedUser1 = "";
    String fetchedUser2 = "";

    for (QueryDocumentSnapshot element in allDocs) {
      String user1 = element.id.split("_")[0];
      String user2 = element.id.split("_")[1];

      if ((user1 == u1 || user1 == u2) && (user2 == u1 || user2 == u2)) {
        chatRoomAvailable = true;
        fetchedUser1 = element.id.split("_")[0];
        fetchedUser2 = element.id.split("_")[1];
      }
    }

    if (chatRoomAvailable == true) {
      await firestore
          .collection("chats")
          .doc("${fetchedUser1}_${fetchedUser2}")
          .collection("messages")
          .add({
        "sentby": chatDetails.senderUid,
        "receivedby": chatDetails.receiverUid,
        "message": chatDetails.message,
        "timestamp": FieldValue.serverTimestamp(),
      });
    } else {
      await firestore
          .collection("chats")
          .doc("${chatDetails.receiverUid}_${chatDetails.senderUid}")
          .set({
        "sender": chatDetails.senderUid,
        "receiver": chatDetails.receiverUid,
      });

      await firestore
          .collection("chats")
          .doc("${chatDetails.receiverUid}_${chatDetails.senderUid}")
          .collection("messages")
          .add({
        "sentby": chatDetails.senderUid,
        "receivedby": chatDetails.receiverUid,
        "message": chatDetails.message,
        "timestamp": FieldValue.serverTimestamp(),
      });
    }
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> displayMessage(
      {required ChatDetails chatDetails}) async {
    //todo:given value to u1 and u2 for check if chatroom is available or not
    String u1 = chatDetails.senderUid;
    String u2 = chatDetails.receiverUid;

    //todo:fetched all chaRooms
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection("chats").get();

    List<QueryDocumentSnapshot> allDocs = querySnapshot.docs;

    bool chatRoomAvailable = false;
    String fetchedUser1 = "";
    String fetchedUser2 = "";

    for (QueryDocumentSnapshot element in allDocs) {
      String user1 = element.id.split("_")[0];
      String user2 = element.id.split("_")[1];

      if ((user1 == u1 || user1 == u2) && (user2 == u1 || user2 == u2)) {
        chatRoomAvailable = true;
        fetchedUser1 = element.id.split("_")[0];
        fetchedUser2 = element.id.split("_")[1];
      }
    }

    if (chatRoomAvailable == true) {
      return firestore
          .collection("chats")
          .doc("${fetchedUser1}_${fetchedUser2}")
          .collection("messages")
          .orderBy("timestamp", descending: true)
          .snapshots();
    } else {
      return firestore
          .collection("chats")
          .doc("${chatDetails.receiverUid}_${chatDetails.senderUid}")
          .collection("messages")
          .orderBy("timestamp", descending: true)
          .snapshots();
    }
  }
}

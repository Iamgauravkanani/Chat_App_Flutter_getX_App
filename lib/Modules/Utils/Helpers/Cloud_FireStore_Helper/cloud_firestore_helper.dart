import 'package:chat_app_3/Modules/Utils/Helpers/Authentication_Helper/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore_Helper {
  Firestore_Helper._();

  static final Firestore_Helper firestore_helper = Firestore_Helper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser({required Map<String, dynamic> user_data}) async {
    await firestore
        .collection("user")
        .doc("${Auth_Helper.auth_helper.auth.currentUser?.uid}")
        .set(user_data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUser() {
    return firestore
        .collection("user")
        .where("uid",
            isNotEqualTo: Auth_Helper.auth_helper.auth.currentUser?.uid)
        .snapshots();
  }

  Future<void> deleteUser({required var deleteData}) async {
    await firestore.collection("user").doc("$deleteData").delete();
  }
}

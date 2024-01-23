import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zoom_clone1/resources/auth_methods.dart';

class FireStoreMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthMethos _authMethos = AuthMethos();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream get getUsers => _firestore.collection("users").snapshots();
  void addUser(String userName) async {
    try {
      await _firestore.collection("users").add({
        "username": _authMethos.user.displayName,
        "uid": _authMethos.user.uid,
        "profilePhoto": _authMethos.user.photoURL
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingHistory => _firestore
      .collection("users")
      .doc(_auth.currentUser!.uid)
      .collection("meetings")
      .snapshots();
  void addToMeetingHistory(String MeetingName) async {
    try {
      await _firestore
          .collection("users")
          .doc()
          .collection("meetings")
          .add({'meetingName': MeetingName, 'createdAt': DateTime.now()});
    } catch (e) {
      print(e);
    }
  }
}

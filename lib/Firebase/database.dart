import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Database {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(name, classStudent, email, uid, token) {
    return _firestore.collection('students')
        .doc(uid).set({
      'name': name,
      'email': email,
      'uid': uid,
      'class': classStudent,
      'interestedEvents': [],
      'schedule': [],
      'token': token,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future checkForUserRegister(String email) async {
    bool returnValue = false;
    await _firestore.collection('students')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc['email'] == email) {
          returnValue = true;
        }
      }
    });
    return returnValue;
  }
}

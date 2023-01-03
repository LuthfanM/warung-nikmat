import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DocumentReference get userCollection {
  return FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);
}

class UserService {
  static createUserIfNotExists() async {
    var snapshot = await userCollection.get();
    if (!snapshot.exists) {
      await userCollection.set({
        "id": FirebaseAuth.instance.currentUser!.uid,
        "name": FirebaseAuth.instance.currentUser!.displayName,
        "email": FirebaseAuth.instance.currentUser!.email,
        "phone_number": FirebaseAuth.instance.currentUser!.phoneNumber,
        "photo": FirebaseAuth.instance.currentUser!.photoURL,
        "point": 0,
        "is_admin": false,
      });
    }
  }

  // static updatePoint({
  //   required double point,
  // }) async {
  //   await userCollection.update({
  //     "point": FieldValue.increment(point),
  //   });
  // }

  // static getUserData() {
  //   return {
  //     "id": FirebaseAuth.instance.currentUser!.uid,
  //     "email": FirebaseAuth.instance.currentUser!.email,
  //     "name": FirebaseAuth.instance.currentUser!.displayName,
  //   };
  // }
}

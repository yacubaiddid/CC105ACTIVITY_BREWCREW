import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future<void> updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Brew(
          name: doc.data()['name'] ?? '',
          strength: doc.data()['strength'] ?? 0,
          sugars: doc.data()['sugars'] ?? '0');
    }).toList();
  }

  // user data from snapshots
  PersonData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return PersonData(
        uid: uid,
        name: snapshot.data()['name'],
        sugars: snapshot.data()['sugars'],
        strength: snapshot.data()['strength']);
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<PersonData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}

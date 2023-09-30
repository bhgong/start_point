import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/widget/models/mood_model.dart';

class MoodRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createMoodPost(MoodModel userMood) async {
    await _db
        .collection("moods")
        .doc(userMood.creatorUid)
        .set(userMood.toJson());
  }

  Future<Map<String, dynamic>?> findUserMood(String uid) async {
    final doc = await _db.collection("moods").doc(uid).get();
    return doc.data();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMoods() async {
    final query = _db.collection("moods").orderBy("date", descending: true);

    return query.get();
  }

  Future<void> deleteMood(String uid) async {
    await _db.collection("moods").doc(uid).delete();
  }
}

final moodRepo = Provider(
  (ref) => MoodRepository(),
);

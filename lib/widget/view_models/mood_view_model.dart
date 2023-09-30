import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/widget/feature/authentication/repos/authentication_repo.dart';
import 'package:flutter_start_point_application/widget/models/mood_model.dart';
import 'package:flutter_start_point_application/widget/repos/mood_repo.dart';

class MoodViewModel extends AsyncNotifier<void> {
  late final MoodRepository _moodRepository;

  @override
  FutureOr<void> build() {
    _moodRepository = ref.read(moodRepo);
  }

  Future<void> postMood(
      String comments, String mood, BuildContext context) async {
    final user = ref.read(authRepo).user;
    int postCount = 0;
    postCount++;

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await _moodRepository.createMoodPost(MoodModel(
        mood: mood,
        comments: comments,
        creatorUid: user!.uid + postCount.toString(),
        date: DateTime.now().millisecondsSinceEpoch.toString(),
      ));
    });
  }

  Future<void> removeMood(String userId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _moodRepository.deleteMood(userId);
    });
  }
}

final moodProvider = AsyncNotifierProvider<MoodViewModel, void>(
  () => MoodViewModel(),
);

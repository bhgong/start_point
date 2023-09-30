import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/widget/models/mood_model.dart';
import 'package:flutter_start_point_application/widget/repos/mood_repo.dart';

class HomeViewModel extends AsyncNotifier<List<MoodModel>> {
  late final MoodRepository _repository;
  List<MoodModel> _list = [];

  @override
  FutureOr<List<MoodModel>> build() async {
    _repository = ref.read(moodRepo);
    _list = await _fetchMoodList();
    return _list;
  }

  Future<List<MoodModel>> _fetchMoodList() async {
    final result = await _repository.fetchMoods();
    final moods = result.docs.map(
      (doc) => MoodModel.fromJson(
        doc.data(),
      ),
    );
    // print(moods);

    return moods.toList();
  }

  Future<void> refresh() async {
    final moods = await _fetchMoodList();
    _list = moods;
    state = AsyncValue.data(moods);
  }
}

final homeMoodProvider = AsyncNotifierProvider<HomeViewModel, List<MoodModel>>(
  () => HomeViewModel(),
);

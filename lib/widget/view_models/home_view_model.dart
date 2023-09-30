import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/widget/models/mood_model.dart';
import 'package:flutter_start_point_application/widget/repos/mood_repo.dart';

class HomeViewModel extends AsyncNotifier<List<MoodModel>> {
  late final MoodRepository _repository;
  final List<MoodModel> _list = [];

  Future<List<MoodModel>> _fetchMoods() async {
    final result = await _repository.fetchVideos(
      lastItemCreatedAt: lastItemCreatedAt,
    );
    final videos = result.docs.map(
      (doc) => MoodModel.fromJson(
        doc.data(),
      ),
    );
    return videos.toList();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/dark_mode/models/dark_mode_model.dart';
import 'package:flutter_start_point_application/dark_mode/repos/dark_mode_repo.dart';

class DarkModeViewModel extends Notifier<DarkModeModel> {
  final AppDarkModeRepository _repository;

  DarkModeViewModel(this._repository);

  void setDarkMode(bool value) async {
    _repository.setDarkMode(value);
    state = DarkModeModel(isDark: value);
  }

  @override
  DarkModeModel build() {
    return DarkModeModel(
      isDark: _repository.isDarkMode(),
    );
  }
}

final darkModeProvider = NotifierProvider<DarkModeViewModel, DarkModeModel>(
  () => throw (),
);

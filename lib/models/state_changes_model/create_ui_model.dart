import 'package:blusalt_mini_app/models/base_ui_model.dart';

class CreateUIModel extends BaseUIModel {
  String _answerText = '';

  String get getText => _answerText;

  void setText(String text) {
    _answerText = text;
  }
}

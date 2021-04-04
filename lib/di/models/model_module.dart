import 'package:blusalt_mini_app/models/state_changes_model/authentication_ui_model.dart';
import 'package:get_it/get_it.dart';

Future<void> init(GetIt injector) async {
  injector.registerFactory(() => AuthenticationUIModel());
}

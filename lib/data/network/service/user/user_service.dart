import 'package:blusalt_mini_app/data/network/model/state.dart';

abstract class UserService {
  Future<RequestState> getUser(String email);
}

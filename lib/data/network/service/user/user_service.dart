import 'package:blusalt_mini_app/data/network/model/state.dart';

abstract class AbstractUserService {
  Future<RequestState> getUser(String id);
}

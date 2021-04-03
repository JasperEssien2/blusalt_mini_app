import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/service/user/user_service.dart';
import 'package:blusalt_mini_app/data/network/service/user/user_service_impl.dart';

class UserRepositoryImpl extends UserService {
  final UserServiceImpl userService;

  UserRepositoryImpl({required this.userService});

  @override
  Future<RequestState> getUser(String email) {
    return userService.getUser(email);
  }
}

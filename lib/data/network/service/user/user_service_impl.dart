import 'package:blusalt_mini_app/data/network/base/endpoints.dart';
import 'package:blusalt_mini_app/data/network/base/simplify_api_consuming.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/model/user_response.dart';
import 'package:blusalt_mini_app/data/network/service/user/user_service.dart';
import 'package:blusalt_mini_app/helpers/http/http.helper.dart';

class UserServiceImpl extends AbstractUserService {
  final HttpHelper helper;

  UserServiceImpl({required this.helper});

  @override
  Future<RequestState> getUser(String email) async {
    return SimplifyApiConsuming.simplifyEndpointConsumingReturn(
      () => helper.get(authenticationEndpoint.searchUser + '?keywords=$email'),
      successResponse: (data) {
        List<UserResponse> userList = List<UserResponse>.from(
            data.map((json) => UserResponse.fromJson(json)).toList());
        if (userList.isNotEmpty) return RequestState.success(userList[0]);
        return RequestState.success(
          getDummyUser()
              .copyWith(id: 'anonymous', firstname: 'Anonymous', lastname: ''),
        );
      },
    );
  }
}

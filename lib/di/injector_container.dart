import 'package:get_it/get_it.dart';

import 'bloc/bloc_module.dart' as blocModule;
import 'network/network_module.dart' as networkModule;
import 'repositories/repository_module.dart' as repositoryModule;
import 'service/service_module.dart' as serviceModule;

final GetIt injector = GetIt.instance;
final String registeredUserScope = 'RegisteredUser';

Future<void> init() async {
  serviceModule.init(injector);
  blocModule.init(injector);
  repositoryModule.init(injector);
  networkModule.init(injector);
}

//This pushes a new scope when a user has successfully sign in
// passing in the [scopeName]
void pushNewScope(String scopeName) {
  injector.pushNewScope(scopeName: registeredUserScope);
}

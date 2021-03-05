import 'package:get_it/get_it.dart';
import 'package:ira_app/provider/chat_provider.dart';
import 'package:ira_app/provider/home_provider.dart';
import 'package:ira_app/provider/profile_provider.dart';
import 'package:ira_app/viewModel/chat_view_model_list.dart';

GetIt getIt = GetIt.instance;

class XuGetIt {
  static void setup() {
    getIt.registerSingleton<ChatListState>(ChatListState(), signalsReady: true);
    getIt.registerLazySingleton(() => HomeProvider());
    getIt.registerLazySingleton(() => ProfileProvider());
    getIt.registerLazySingleton(() => ChatProvider());
  }
}

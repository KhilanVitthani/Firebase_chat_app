import 'package:get/get.dart';

import '../../constants/api_constants.dart';
import '../../constants/sizeConstant.dart';
import '../../main.dart';
import '../modules/add_user_screen/bindings/add_user_screen_binding.dart';
import '../modules/add_user_screen/views/add_user_screen_view.dart';
import '../modules/chat_screen/bindings/chat_screen_binding.dart';
import '../modules/chat_screen/views/chat_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';
import '../modules/singup_page/bindings/singup_page_binding.dart';
import '../modules/singup_page/views/singup_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String INITIAL =
      (!isNullEmptyOrFalse(box.read(ArgumentConstant.isLogin)))
          ? Routes.HOME
          : Routes.LOGIN_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SINGUP_PAGE,
      page: () => const SingupPageView(),
      binding: SingupPageBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => const LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_USER_SCREEN,
      page: () => const AddUserScreenView(),
      binding: AddUserScreenBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_SCREEN,
      page: () => const ChatScreenView(),
      binding: ChatScreenBinding(),
    ),
  ];
}

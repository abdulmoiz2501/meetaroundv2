import 'package:get/get.dart';

import '../modules/ChatDetailScreen/bindings/chat_detail_screen_binding.dart';
import '../modules/ChatDetailScreen/views/chat_detail_screen_view.dart';
import '../modules/ChatScreen/bindings/chat_screen_binding.dart';
import '../modules/ChatScreen/views/chat_screen_view.dart';
import '../modules/JammingScreen/bindings/jamming_screen_binding.dart';
import '../modules/JammingScreen/controllers/jamming_screen_controller.dart';
import '../modules/JammingScreen/views/jamming_screen_view.dart';
import '../modules/NotificationScreen/bindings/notification_screen_binding.dart';
import '../modules/NotificationScreen/views/notification_screen_view.dart';
import '../modules/PastInterections/bindings/past_interections_binding.dart';
import '../modules/PastInterections/views/past_interections_view.dart';
import '../modules/ProfileScreen/bindings/profile_screen_binding.dart';
import '../modules/ProfileScreen/views/profile_screen_view.dart';
import '../modules/ResetPassword/bindings/reset_password_binding.dart';
import '../modules/ResetPassword/views/reset_password_view.dart';
import '../modules/SearchScreen/bindings/search_screen_binding.dart';
import '../modules/SearchScreen/views/search_screen_view.dart';
import '../modules/Services/bindings/services_binding.dart';
import '../modules/Services/views/services_view.dart';
import '../modules/SettingsScreen/bindings/settings_screen_binding.dart';
import '../modules/SettingsScreen/views/settings_screen_view.dart';
import '../modules/bottomNavBar/bindings/bottom_nav_bar_binding.dart';
import '../modules/bottomNavBar/views/bottom_nav_bar_view.dart';
import '../modules/bottomNavBar/views/home_screen_view.dart';
import '../modules/bottomNavBar/views/suggested_people_view.dart';
import '../modules/onBoarding/bindings/onvboarding_binding.dart';
import '../modules/onBoarding/views/onboarding_view.dart';
import '../modules/signIn/bindings/sign_in_binding.dart';
import '../modules/signIn/views/sign_in_view.dart';
import '../modules/signUp/bindings/sign_up_binding.dart';
import '../modules/signUp/views/add_picture_view.dart';
import '../modules/signUp/views/birth_date_view.dart';
import '../modules/signUp/views/get_user_location_view.dart';
import '../modules/signUp/views/music_genres_view.dart';
import '../modules/signUp/views/select_gender_view.dart';
import '../modules/signUp/views/sign_up_view.dart';
import '../modules/signUp/views/signup_form_screen_view.dart';
import '../modules/signUp/views/welcome_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/second_splash_view.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const SPLASH_SCREEN = Routes.SPLASH_SCREEN;
  static const SECOND_SPLASH = Routes.SECOND_SPLASH;
  static const ONBOARDING = Routes.ONBOARDING;
  static const SIGN_UP = Routes.SIGN_UP;
  static const SIGNUP_FORMS = Routes.SIGNUP_FORMS;
  static const DATE_OF_BIRTH = Routes.DATE_OF_BIRTH;
  static const SELECT_GENDER_VIEW = Routes.SELECT_GENDER_VIEW;
  static const MUSIC_GENRE = Routes.MUSIC_GENRE;
  static const ADD_PICTURE = Routes.ADD_PICTURE;
  static const USER_LOCATION = Routes.USER_LOCATION;
  static const WELCOME = Routes.WELCOME;
  static const SIGN_IN = Routes.SIGN_IN;
  static const BOTTOM_NAV_BAR = Routes.BOTTOM_NAV_BAR;
  static const HOME_SCREEN = Routes.HOME_SCREEN;
  static const SUGGESTED_PEOPLE = Routes.SUGGESTED_PEOPLE;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnBoardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_FORMS,
      page: () => SignupFormScreenView(),
    ),
    GetPage(
      name: _Paths.DATE_OF_BIRTH,
      page: () => BirthDateView(),
    ),
    GetPage(
      name: _Paths.SELECT_GENDER_VIEW,
      page: () => SelectGenderView(),
    ),
    GetPage(
      name: _Paths.MUSIC_GENRE,
      page: () => MusicGenresView(),
    ),
    GetPage(
      name: _Paths.ADD_PICTURE,
      page: () => AddPictureView(),
    ),
    GetPage(
      name: _Paths.USER_LOCATION,
      page: () => GetUserLocationView(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SECOND_SPLASH,
      page: () => const SecondSplashView(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAV_BAR,
      page: () => BottomNavBarView(),
      binding: BottomNavBarBinding(),
    ),
    GetPage(
      name: _Paths.HOME_SCREEN,
      page: () => HomeScreenView(),
      binding: BottomNavBarBinding(),
    ),
    GetPage(
      name: _Paths.SUGGESTED_PEOPLE,
      page: () => SuggestedPeopleView(),
      binding: BottomNavBarBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_SCREEN,
      page: () => ChatScreenView(),
      binding: ChatScreenBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_DETAIL_SCREEN,
      page: () => ChatDetailScreenView(),
      binding: ChatDetailScreenBinding(),
    ),
    GetPage(
      name: _Paths.JAMMING_SCREEN,
      page: () => JammingScreenView(userId: Get.arguments['userId'], targetUserId: Get.arguments['targetUserId'],),
      binding: BindingsBuilder(() {
        Get.lazyPut<JammingScreenController>(() {
          return JammingScreenController(userId: Get.arguments['userId'], targetUserId: Get.arguments['targetUserId']);
        });
      }),
    ),
    GetPage(
      name: _Paths.PAST_INTERECTIONS,
      page: () => const PastInterectionsView(),
      binding: PastInterectionsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SCREEN,
      page: () => const ProfileScreenView(),
      binding: ProfileScreenBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS_SCREEN,
      page: () => const SettingsScreenView(),
      binding: SettingsScreenBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_SCREEN,
      page: () => const NotificationScreenView(),
      binding: NotificationScreenBinding(),
    ),
    GetPage(
      name: _Paths.SERVICES,
      page: () => const ServicesView(),
      binding: ServicesBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_SCREEN,
      page: () => SearchScreen(),
      binding: SearchScreenBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
  ];
}

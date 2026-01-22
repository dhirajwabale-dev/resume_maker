import 'package:get/get.dart';

import '../UI/about_us_screen.dart';
import '../UI/contact_us_screen.dart';
import '../UI/create_resume_screen.dart';
import '../UI/faq_screen.dart';
import '../UI/home_screen.dart';
import '../UI/privacy_policy_screen.dart';
import '../UI/splash_screen.dart';
import '../UI/term_and_consition_screen.dart';
import '../Utility/arguments.dart';
import 'routes_name.dart';

class RouteGenerator {
  static List<GetPage> getPage = [
    //-----------------Splash Screen-----------------//
    GetPage(
      name: RoutesName.splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.leftToRightWithFade,
    ),

    //-----------------Home Screen-----------------//
    GetPage(
      name: RoutesName.homeScreen,
      page: () => const HomeScreen(),
      transition: Transition.leftToRightWithFade,
    ),

    //-----------------privacy Policy Screen-----------------//
    GetPage(
      name: RoutesName.privacyScreen,
      page: () => const PrivacyPolicyScreen(),
      transition: Transition.leftToRightWithFade,
    ),

    //-----------------Term & Condition Screen-----------------//
    GetPage(
      name: RoutesName.termAndConditionScreen,
      page: () => const TermAndConsitionScreen(),
      transition: Transition.leftToRightWithFade,
    ),

    //-----------------About US Screen-----------------//
    GetPage(
      name: RoutesName.aboutScreen,
      page: () => const AboutUsScreen(),
      transition: Transition.leftToRightWithFade,
    ),

    //-----------------Contact Us Screen-----------------//
    GetPage(
      name: RoutesName.contactUsScreen,
      page: () => ContactScreen(),
      transition: Transition.leftToRightWithFade,
    ),

    //-----------------FAQS Screen-----------------//
    GetPage(
      name: RoutesName.faqScreen,
      page: () => FaqScreen(),
      transition: Transition.leftToRightWithFade,
    ),

    //-----------------Create Resume Screen-----------------//
    GetPage(
      name: RoutesName.createResumeScreen,

      page: () {
        final args = Get.arguments as CreateResumeArgument?;
        return CreateResumeScreen(flag: args?.flag ?? 0);
      },
      transition: Transition.leftToRightWithFade,
    ),
  ];
}

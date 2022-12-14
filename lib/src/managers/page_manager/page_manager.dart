import 'package:flutter/material.dart';
import 'package:playground_app/src/enums/page_names.dart';
import 'package:playground_app/src/ui/pages/examples/shapes_and_animations_example_page.dart';
import 'package:playground_app/src/ui/pages/examples/horizontal_options_transition/horizontal_options_transition_page.dart';
import 'package:playground_app/src/ui/pages/home_page.dart';
import 'package:playground_app/src/ui/pages/scroll_and_menu_page.dart';
import 'package:playground_app/utils/page_args.dart';


class PageManager {
  static final PageManager _instance = PageManager._constructor();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  PageNames? currentPage;

  factory PageManager() {
    return _instance;
  }

  PageNames? getPageNameEnum(String? pageName) {
    try {
      return PageNames.values.where((x) => x.toString() == pageName).single;
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return null;
  }

  PageManager._constructor();

  MaterialPageRoute? getRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    PageArgs? arguments;

    if (settings.arguments != null) {
      arguments = settings.arguments as PageArgs;
    }

    PageNames? page = getPageNameEnum(settings.name);
    currentPage = page;

    switch (page) {
      // --------- COMMONS ---------
      case PageNames.home:
        return MaterialPageRoute(builder: (context) => HomePage(arguments));
      case PageNames.example1:
        return MaterialPageRoute(
            builder: (context) => HorizontalOptionsTransitionPage(arguments));
      case PageNames.scrollAndMenu:
        return MaterialPageRoute(
            builder: (context) => ScrollAndMenuPage(arguments));
      case PageNames.example2:
        return MaterialPageRoute(
            builder: (context) => ShapesAndAnimationsPage(arguments));

      default:
    }
    return null;
  }

  // ignore: unused_element
  _goPage(String pageName,
      {PageArgs? args,
      Function(PageArgs? args)? actionBack,
      bool makeRootPage = false}) {
    if (!makeRootPage) {
      return navigatorKey.currentState
          ?.pushNamed(pageName, arguments: args)
          .then((value) {
        if (actionBack != null) actionBack(value as PageArgs?);
      });
    } else {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
          pageName, (route) => false,
          arguments: args);
    }
  }

  goBack({PageArgs? args, PageNames? specificPage}) {
    if (specificPage != null) {
      navigatorKey.currentState!
          .popAndPushNamed(specificPage.toString(), arguments: args);
    } else {
      Navigator.pop(navigatorKey.currentState!.overlay!.context, args);
    }
  }

  goHomePage({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(PageNames.home.toString(),
        actionBack: actionBack, makeRootPage: true);
  }

  goExample1Page({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(PageNames.example1.toString(), actionBack: actionBack);
  }

  goScrollAndMenuPage({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(PageNames.scrollAndMenu.toString(), actionBack: actionBack);
  }

  void goExample2Page({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(PageNames.example2.toString(), actionBack: actionBack);
  }
}

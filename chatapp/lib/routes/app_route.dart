
import 'package:chatapp/pages/Chat_page.dart';
import 'package:chatapp/pages/splash_view.dart';
import 'package:chatapp/pages/resgister_page.dart';
import 'package:chatapp/pages/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  static const signInView = 'SignInView';
  static const splashView = 'SplashView';
  static const signUpView = 'SignUpView';
    static const chatPage = 'ChatPage';



  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignInView:
        return    MaterialPageRoute(
            builder: (_) => SignInView());
      case splashView:
        return SizeTransition3( SplashView());
      case signUpView:
        return SizeTransition3( SignUpView());
         case chatPage:
        return SizeTransition3( ChatPage());

     
    }
    return undefinedRoute();
  }

  static Route undefinedRoute() {
    return MaterialPageRoute(
      builder: ((context) => const Scaffold(
            body: Center(
              child: Text('noRouteFound'),
            ),
          )),
    );
  }
}

class SizeTransition3 extends PageRouteBuilder {
  final Widget page;

  SizeTransition3(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(seconds: 4),
          reverseTransitionDuration: const Duration(seconds: 2),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.center,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

class SizeTransition5 extends PageRouteBuilder {
  final Widget page;

  SizeTransition5(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(seconds: 2),
          // reverseTransitionDuration:const  Duration(seconds: 2),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.centerRight,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

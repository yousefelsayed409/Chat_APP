import 'package:chatapp/bloc/login_cubit/login_cubit.dart';
import 'package:chatapp/pages/splash_view.dart';
import 'package:chatapp/routes/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/bloc/Chat_cubit/chat_cubit.dart';
import 'package:chatapp/bloc/Register_cubit/register_cubit.dart';
import 'package:chatapp/pages/Chat_page.dart';

import 'package:chatapp/pages/signin_view.dart';
import 'package:chatapp/pages/resgister_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("backkkkkkkkkkkkkkkkkkkkkkkkkk");
  print(" background message: ${message.notification!.title}");
    print(" background message: ${message.data['name']}");

  print(" background message: ${message.notification!.body}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseAuth.instance.authStateChanges().listen(
    (User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    },
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoute.generateRoute,
         home: 
        FirebaseAuth.instance.currentUser == null
            ? SignInView()
            : ChatPage(),
      ),
    );
  }
}

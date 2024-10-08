import 'package:chatapp/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chatapp/bloc/login_cubit/login_cubit.dart';


import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignInView extends StatelessWidget {
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  String? email, password;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is Loginloading) {
          isLoading = true;
        } else if (state is LoginIsuccess) {
          // BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.of(context).pushReplacementNamed('HomeTowView');
          // Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        } else if (state is Loginfailure) {
          isLoading = false;
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      'assets/images/Illustration.png',
                      height: 150,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          ' Chat App',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Text(
                          '  LOGIN',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormFeild(
                      label: 'Email',
                      onChanged: (data) {
                        email = data;
                      },
                      hittext: 'Email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomFormFeild(
                      label: 'Password',
                      obscureText: true,
                      onChanged: (data) {
                        password = data;
                      },
                      hittext: 'Password',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Custombutton(
                      colorbutton: Colors.yellow,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context)
                              .loginuser(Email: email!, Password: password!);
                        } else {}
                      },
                      text: 'LOGIN',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'don\'t have an account ?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoute.signUpView);
                          },
                          child: const Text(
                            '  Register ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

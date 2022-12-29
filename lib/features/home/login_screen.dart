import 'package:flutter/material.dart';
import 'package:instagram_clone/features/users/widgets/text_field_input.dart';

import '../../constant/app_constant/app_constant.dart';

class LoginScreen extends StatelessWidget {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
        ),
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),

              //svg image
              // Image.asset(
              //   AppCommon.imageInstagram,
              //   color: AppConstant.primaryColor,
              //   height: 64,
              // ),
              // text field

              TextFieldInput(
                textEditingController: mailController,
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldInput(
                textEditingController: passwordController,
                hintText: 'Password',
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),
              SizedBox(
                height: 10,
              ),
              //button
              InkWell(
                child: Container(
                  child: Text("Log In"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: AppConstant.blueColor,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have an account?"),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              )
            ],
          ),
        )));
  }
}

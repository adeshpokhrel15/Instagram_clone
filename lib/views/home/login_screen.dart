import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Provider/authentication/auth_provider.dart';

import '../../Provider/image provider/image_provider.dart';
import '../../Provider/login provider/login_provider.dart';

class LoginScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(builder: (context, ref, child) {
      final isLogin = ref.watch(loginProvider);
      final dbimage = ref.watch(imageProvider);

      return SingleChildScrollView(
        child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  height: isLogin ? 390 : 560,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        isLogin ? 'Login Form' : 'SignUp Form',
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 2,
                            color: Colors.blueGrey),
                      ),
                      if (!isLogin)
                        TextFormField(
                          controller: usernameController,
                          textCapitalization: TextCapitalization.words,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'username is required';
                            }
                            if (val.length > 30) {
                              return 'maximum user length is 30';
                            }
                            return null;
                          },
                          decoration: InputDecoration(hintText: 'username'),
                        ),
                      if (!isLogin)
                        InkWell(
                          onTap: () {
                            ref.read(imageProvider.notifier).getImage();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                                height: 140,
                                child: dbimage.image == null
                                    ? Center(
                                        child: Text("please select an image"),
                                      )
                                    : Image.file(
                                        File(dbimage.image!.path),
                                        fit: BoxFit.cover,
                                      )),
                          ),
                        ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'email is required';
                          }
                          if (!val.contains('@')) {
                            return 'please provide valid email address';
                          }
                          return null;
                        },
                        controller: mailController,
                        decoration: InputDecoration(hintText: 'email'),
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'password is required';
                          }
                          if (val.length > 20) {
                            return 'maximum password length is 20';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'password'),
                      ),
                      Container(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            _form.currentState!.save();

                            FocusScope.of(context).unfocus();
                            if (_form.currentState!.validate()) {
                              if (isLogin) {
                                ref.read(logSignProvider).logIn(
                                      email: mailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                              } else {
                                if (dbimage.image == null) {
                                  print('please select an image');
                                }
                                ref.read(logSignProvider).signUp(
                                      userName: usernameController.text.trim(),
                                      email: mailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      image: dbimage.image!,
                                    );
                              }

                              // if (response != 'success') {
                              //   ref.read(loginProvider.notifier).toggle();
                              //   Get.showSnackbar(GetSnackBar(
                              //     duration: Duration(seconds: 1),
                              //     title: 'some error occurred',
                              //     message: response,
                              //   ));
                              // }
                              // } else {

                              //   if (response != 'success') {
                              //     ref.read(loginProvider.notifier).toggle();
                              //     Get.showSnackbar(GetSnackBar(
                              //       duration: Duration(seconds: 1),
                              //       title: 'some error occurred',
                              //       message: response,
                              //     ));
                              //   }
                              // }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Submit',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(isLogin
                              ? 'Don\'t have account ?'
                              : 'Already have an account ?'),
                          TextButton(
                              onPressed: () {
                                ref.read(loginProvider.notifier).toggle();
                              },
                              child: Text(isLogin ? 'SignUp' : 'Login'))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
      );
    }));
  }
}

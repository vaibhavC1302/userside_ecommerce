import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/consts/lists.dart';
import 'package:userside_ecommerce/controller/auth_controller.dart';
import 'package:userside_ecommerce/views/auth_screen/signup_screen.dart';
import 'package:userside_ecommerce/views/home_screen/home.dart';
import 'package:userside_ecommerce/widgets_common/applogo_widget.dart';
import 'package:userside_ecommerce/widgets_common/bg_widget.dart';
import 'package:userside_ecommerce/widgets_common/custom_textfield.dart';
import 'package:userside_ecommerce/widgets_common/height_width.dart';
import 'package:userside_ecommerce/widgets_common/out_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(context, 0.05),
                ),

                //app logo
                applogoWidget(),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Log in to $appname",
                  style: TextStyle(
                      fontSize: 18, color: Colors.white, fontFamily: bold),
                ),
                const SizedBox(
                  height: 10,
                ),

                //content container
                Obx(
                  () => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        //email textfield
                        customTextField(
                          title: email,
                          hintText: emialHint,
                          obscureText: false,
                          controller: controller.emailController,
                        ),

                        //password textfield
                        customTextField(
                            title: password,
                            hintText: passwordHint,
                            obscureText: true,
                            controller: controller.passwordController),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              forgetPass,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),

                        //login button
                        controller.isLoading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              )
                            : ourButton(
                                title: "Login",
                                buttonColor: redColor,
                                textColor: whiteColor,
                                onPress: () async {
                                  controller.isLoading(true);
                                  await controller
                                      .loginMethod(context: context)
                                      .then(
                                    (value) {
                                      if (value != null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(loggedinsuccess),
                                          ),
                                        );
                                        Get.offAll(() => const Home());
                                      } else {
                                        controller.isLoading(false);
                                      }
                                    },
                                  );
                                },
                              ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          createNewAccount,
                          style: TextStyle(fontSize: 16, color: fontGrey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ourButton(
                            title: "Signup",
                            buttonColor: lightGolden,
                            textColor: redColor,
                            onPress: () {
                              Get.to(() => SignUpScreen());
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          loginWith,
                          style: TextStyle(fontSize: 16, color: fontGrey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  socialIconsList[index],
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/controller/auth_controller.dart';
import 'package:userside_ecommerce/views/home_screen/home.dart';
import 'package:userside_ecommerce/widgets_common/applogo_widget.dart';
import 'package:userside_ecommerce/widgets_common/bg_widget.dart';
import 'package:userside_ecommerce/widgets_common/custom_textfield.dart';
import 'package:userside_ecommerce/widgets_common/height_width.dart';
import 'package:userside_ecommerce/widgets_common/out_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // auth controller initialization
  AuthController controller = Get.put(AuthController());

  //text controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRetypeController = TextEditingController();

  //checkbox value
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
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
              applogoWidget(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Join $appname",
                style: TextStyle(
                    fontSize: 18, color: Colors.white, fontFamily: bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      //name textfield
                      customTextField(
                          title: name,
                          hintText: name,
                          obscureText: false,
                          controller: nameController),

                      // email textfield
                      customTextField(
                          title: email,
                          hintText: emialHint,
                          obscureText: false,
                          controller: emailController),

                      //passowrd textfield
                      customTextField(
                          title: password,
                          hintText: passwordHint,
                          obscureText: true,
                          controller: passwordController),

                      // retype password textfield
                      customTextField(
                          title: retypePass,
                          hintText: passwordHint,
                          obscureText: true,
                          controller: passwordRetypeController),

                      //checkbox for terms and conditions
                      Row(
                        children: [
                          Checkbox(
                              activeColor: redColor,
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value;
                                });
                              }),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                      text: "I agree to the ",
                                      style: TextStyle(
                                          fontFamily: bold, color: fontGrey)),
                                  TextSpan(
                                      text: "Terms and Conditions ",
                                      style: TextStyle(
                                          fontFamily: bold, color: redColor)),
                                  TextSpan(
                                      text: "& ",
                                      style: TextStyle(
                                          fontFamily: bold, color: fontGrey)),
                                  TextSpan(
                                      text: "Privacy policy ",
                                      style: TextStyle(
                                          fontFamily: bold, color: redColor))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // signup button
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButton(
                              title: signUp,
                              buttonColor: isChecked! ? redColor : lightGolden,
                              textColor: isChecked! ? whiteColor : darkFontGrey,
                              onPress: () async {
                                if (isChecked == true &&
                                    passwordController.text ==
                                        passwordRetypeController.text) {
                                  controller.isLoading(true);
                                  try {
                                    await controller
                                        .signupMethod(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            context: context)
                                        .then((value) {
                                      return controller.storeUserData(
                                          name: nameController.text,
                                          password: passwordController.text,
                                          email: emailController.text);
                                    }).then(
                                      (value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text(loggedinsuccess)));
                                        Get.offAll(() => const Home());
                                      },
                                    );
                                  } catch (e) {
                                    auth.signOut();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          e.toString(),
                                        ),
                                      ),
                                    );
                                    controller.isLoading(false);
                                  }
                                }
                              },
                            ),

                      //already have an account section to go to login page
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account ? "),
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              login,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

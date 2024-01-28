import 'dart:io';

import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/controller/profile_controller.dart';
import 'package:userside_ecommerce/widgets_common/bg_widget.dart';
import 'package:userside_ecommerce/widgets_common/custom_textfield.dart';
import 'package:userside_ecommerce/widgets_common/out_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    //getx controller
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 50, left: 12, right: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: whiteColor),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                data['imageUrl'] == "" && controller.profileImgPath.isEmpty
                    ? CircleAvatar(
                        child: Image(image: AssetImage(imgProfile2)),
                      )
                    : data['imageUrl'] != "" &&
                            controller.profileImgPath.isEmpty
                        ? CircleAvatar(
                            child: Image(image: NetworkImage(data['imageUrl'])),
                          )
                        : CircleAvatar(
                            child: Image(
                                image: FileImage(
                                    File(controller.profileImgPath.value)))),
                SizedBox(
                  height: 10,
                ),
                ourButton(
                  buttonColor: redColor,
                  textColor: whiteColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  title: "Change",
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                customTextField(
                  controller: controller.nameController,
                  hintText: nameHint,
                  title: name,
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                customTextField(
                  controller: controller.oldpassController,
                  hintText: passwordHint,
                  title: oldpass,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                customTextField(
                  controller: controller.newpassController,
                  hintText: passwordHint,
                  title: newpass,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                controller.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : ourButton(
                        title: "Save",
                        buttonColor: redColor,
                        textColor: whiteColor,
                        onPress: () async {
                          controller.isloading(true);
                          //if image is not selected
                          if (controller.profileImgPath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageLink = data['imageUrl'];
                          }

                          //if old password matches the new password
                          if (data['password'] ==
                              controller.oldpassController.text) {
                            await controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpassController.text,
                                newpassword: controller.newpassController.text);

                            await controller.updateProfile(
                                name: controller.nameController.text,
                                password: controller.newpassController.text,
                                imgUrl: controller.profileImageLink);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Updated"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("wrong old password")));
                            controller.isloading(false);
                          }
                        },
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

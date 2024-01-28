import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  //text controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

//login method
  Future<UserCredential?> loginMethod({required BuildContext context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
    return userCredential;
  }

  Future<UserCredential?> signupMethod(
      {required String email,
      required String password,
      required BuildContext context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("uid is ::::  ${currentUser!.uid}");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
    return userCredential;
  }

  storeUserData({name, password, email}) async {
    DocumentReference store =
        firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': "",
      'id': currentUser!.uid,
      'cart_count': "00",
      "order_count": "00",
      'wishlist_count': "00"
    });
  }

  signoutMethod({required BuildContext context}) async {
    try {
      await auth.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }
}

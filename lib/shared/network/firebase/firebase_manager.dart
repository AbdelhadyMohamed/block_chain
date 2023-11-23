import 'package:block_chain/shared/local/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../sign_sup/data/models/user_model.dart';

class FirebaseManager {
  static bool existEmail = false;
  static bool weakPassword = false;

  static Future<void> createAccount(
    String name,
    int age,
    String emailAddress,
    String password,
    Function onSuccess,
    Function onError,
  ) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      UserModel userModel = UserModel(
        id: credential.user!.uid,
        name: name,
        email: emailAddress,
        age: age,
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        weakPassword = true;
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        existEmail = true;
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
        onError(e.message);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> login(String emailAddress, String password,
      Function onSuccess, Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      CacheData.saveData("token", credential.user?.uid ?? "");
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    }
  }
}

import 'dart:async';
import 'dart:io';

import 'package:certifyapp/core/model/auth/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'base_view_model.dart';
enum APP_STATUS { LOADING, UNAUTHENTICATED, AUTHENTICATED, VERIFIED_AUTHENTICATED }

class AuthViewModel extends BaseViewModel {
  FirebaseUser user;
  UserData userData;
  StreamSubscription userAuthentication;

  bool loading = true;
  FirebaseMessaging _fcm = FirebaseMessaging();

  bool sendingCode = false;
  bool codeSent = false;
  bool verifying = false;
  bool verified = false;
  String verificationId;
  String error;

  AuthViewModel() {
  }

  loadAuthInfo(){
    userAuthentication = FirebaseAuth.instance.onAuthStateChanged
        .listen((newUser) async {
      String fcmToken = await _fcm.getToken();
      user = newUser;
      if (user!=null) {
        final DocumentSnapshot doc = await Firestore.instance.collection('users').document(user.uid).get();
        if (doc.exists) {
          UserData res = UserData.fromJson(doc.data);
          userData = res;
          if(fcmToken != null)
            await  Firestore.instance.collection('fcmTokens').document(user.uid).setData({'currentToken':fcmToken},merge: true);
        } else {
          UserData res = new UserData(
            uid: user.uid,
            displayName: user.displayName!=null && user.displayName.isNotEmpty ? user.displayName.split(" ")[0] : "",
            email: user.email,
            photoURL:  user.photoUrl ?? "",

          );
          await Firestore.instance.collection('users').document(user.uid).setData(res.toJson(), merge: true);
          userData = res;
          if(fcmToken != null)
            await  Firestore.instance.collection('fcmTokens').document(user.uid).setData({'currentToken':fcmToken},merge: true);
        }
      } else {
        userData=null;
        user=null;
      }
      loading=false;
      notifyListeners();
    },
        onError: (e) {
          print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
        });
  }
  @override
  void dispose() {
    if (userAuthentication != null) {
      userAuthentication.cancel();
      userAuthentication = null;
    }
    super.dispose();
  }

  bool get isLoading {
    return loading;
  }
  bool get isExpert {
    if (userData!=null &&userData.roles!=null)
      return userData.roles.expert;
    else
      return false;
  }

  String get name {
    if (userData!=null)
      return userData.displayName;
    else
      return "";
  }

  String get email {
    if (userData!=null)
      return userData.email;
    else
      return "";
  }

  String get profilePicture {
    if (userData!=null)
      return userData.photoURL;
    else
      return null;
  }

  bool get isAuthenticated {
    return user!=null && userData!=null;
  }


  bool get isVerified {
    bool isVerified = false;
    if (user==null)
      return isVerified;
    else {
      for (UserInfo info in user.providerData) {
        if (info.providerId == "facebook.com" ||
            info.providerId == "google.com") {
          isVerified = true;
          break;
        } else if (info.providerId == "password") {
          isVerified = user.isEmailVerified;
          break;
        }
      }
      return isVerified;
    }
  }

  APP_STATUS get status {
    if (loading) {
      return APP_STATUS.LOADING;
    } else{
        if (this.isAuthenticated) {
        return APP_STATUS.AUTHENTICATED;
      } else {
        return APP_STATUS.UNAUTHENTICATED;
      }
    }
  }


  signOut() async{
    user=null;userData=null;
    await FirebaseAuth.instance.signOut();
  }

  Future emailSignIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future createAccount(
      String email,
      String password,
      String firstName,
      String lastName,
      DateTime dateOfBirth,
      String gender,
      String country
      ) async {
    try {
      AuthResult res = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      UserData newUser = new UserData(
          uid: res.user.uid,
          id:res.user.uid,
          isAnonymous: false,
          exists: false,
          roles: Roles(expert: false,admin: false, online: true),
          displayName: '$firstName $lastName',
          firstName:firstName ,
          lastName: lastName,
          country: country,
          dateOfBirth: dateOfBirth,
          gender: gender,
          email: res.user.email);
      await Firestore.instance
          .collection('users')
          .document(res.user.uid)
          .setData(newUser.toJson(), merge: true);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser result = await FirebaseAuth.instance.currentUser();
      // await result.sendEmailVerification();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future uploadPic(File _image) async {
    // startLoading();
    String fileName = _image.path;
    fileName = fileName.split("/")[fileName.split("/").length - 1];
    StorageReference fireBaseStorageRef =
    FirebaseStorage.instance.ref().child("profileImages/${userData.uid}");
    StorageUploadTask uploadTask = fireBaseStorageRef.putFile(_image);
    await uploadTask.onComplete;
    if (uploadTask.isSuccessful) {
      String imageUrl = await fireBaseStorageRef.getDownloadURL();
      await updateUserData({"profilePicture":imageUrl});
    }

  }

  Future updateUserData(Map<String, dynamic> newUserData) async {
    await Firestore.instance.collection('users').document(user.uid).setData(newUserData, merge: true);
    final DocumentSnapshot doc = await Firestore.instance.collection('users').document(user.uid).get();
    if (doc.exists) {
      UserData res = UserData.fromJson(doc.data);
      userData = res;
    }
    notifyListeners();
  }


  Future sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    notifyListeners();
  }

}


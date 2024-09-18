// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class GoogleLoginProvider with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   bool _isSigningIn = false;
//
//   bool get isSigningIn => _isSigningIn;
//
//   set isSigningIn(bool value) {
//     _isSigningIn = value;
//     notifyListeners();
//   }
//
//   Future<User?> signInWithGoogle() async {
//     isSigningIn = true;
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         isSigningIn = false;
//         return null; // The user canceled the sign-in.
//       }
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       final UserCredential userCredential = await _auth.signInWithCredential(credential);
//       final User? user = userCredential.user;
//
//       isSigningIn = false;
//       return user;
//     } catch (error) {
//       isSigningIn = false;
//       throw error; // Handle error as needed
//     }
//   }
//
//   Future<void> signOut() async {
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//   }
// }

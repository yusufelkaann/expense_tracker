import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService{
  final FirebaseAuth _firebaseAuth =  FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //Method to sign in with google
  Future<User?> signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if(googleUser == null) return null;

      //obtain the authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = await GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );
      //sign in to firebase
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;

    }catch(e){
      print("Eroor with the sign in: $e");
      return null;
    }
  }
  

  //method to sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  } 
  
  //get current user
  User? getCurrentUser(){
    return _firebaseAuth.currentUser;
  }
 
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:findme/app/services/auth/firebase_authenticator.dart';

class GoogleAuth extends FirebaseAuthenticator {
  GoogleSignIn _googleSignIn;

  GoogleAuth({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        super(firebaseAuth: firebaseAuth);

  @override
  Future<FirebaseUser> providerSignIn() async {
    // if (await _googleSignIn.isSignedIn()) {
    //   return await super.firebaseAuth.currentUser();
    // }
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult =
        await super.firebaseAuth.signInWithCredential(credential);

    return authResult.user;
  }
}
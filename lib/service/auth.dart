import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<User?> signIn(String email,String password) async{
    var user=await _auth.signInWithEmailAndPassword(email: email, password: password);
    return user.user;
  }
  signOut() async{
    return await _auth.signOut();
  }
  Future<User?> register(String username,String email,String password) async{
    var user= await _auth.createUserWithEmailAndPassword(email: email, password: password);

    await _firestore
        .collection("Users")
    .doc(user.user!.uid)
    .set({
      'username':username,
      'email':email,
      'todo_list':[]
    });
    return user.user;
  }
  resetPassword(String email) async{
    await _auth.sendPasswordResetEmail(email: email);
  }
}

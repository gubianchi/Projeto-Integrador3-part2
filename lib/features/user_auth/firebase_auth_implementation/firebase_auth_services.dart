import 'package:firebase_auth/firebase_auth.dart';

//Classe com todos os métodos que é preciso para a autenticação de usuário
class FirebaseAuthServices{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //função de cadastro do usuário
  Future<User?> cadastroEmailESenha(String email, String senha) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: senha);//cria a conta do usuário
      return credential.user; //retorna o usuário

    }catch(e){
      print("Ocorreu um erro");
    }
    return null;
  }

  //função de login do usuário
  Future<User?> loginEmailESenha(String email, String senha) async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: senha);//cria a conta do usuário
      return credential.user; //retorna o usuário

    }catch(e){
      print("Ocorreu um erro");
    }
    return null;
  }
}

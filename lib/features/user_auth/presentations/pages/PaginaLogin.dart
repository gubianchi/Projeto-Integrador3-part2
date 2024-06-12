import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pi2/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'PaginaCadastro.dart';


class PaginaLogin extends StatefulWidget {
  const PaginaLogin({super.key});

  @override
  State<PaginaLogin> createState() => _PaginaLogin();
}

class _PaginaLogin extends State<PaginaLogin>{

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8F598F),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    'PontoSimples',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                TextField(
                  controller: _emailController, //adiciona o controler ao campo de Email
                  decoration: const InputDecoration(
                    hintText: 'Email:',
                    contentPadding: EdgeInsets.all(12),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _senhaController, //adiciona o controler ao campo Senha
                  decoration: const InputDecoration(
                    hintText: 'Senha:',
                    contentPadding: EdgeInsets.all(12),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    _logar();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.all(12),
                  ),
                  child: const Text(
                    'Enviar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PaginaCadastro()),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    child: Text(
                      'Criar conta',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8F598F),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/puc.png', // Caminho para a imagem
                  width: 310,
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _logar() async{
    String email = _emailController.text;
    String senha = _senhaController.text;

    User? user = await _auth.loginEmailESenha(email, senha);

    if( user != null){ //valida o usuário
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PaginaCadastro()), // mudar PaginaCadastro() para a futura home
      );

    }else{
      print("Ocorreu um erro");
    }
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pi2/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:pi2/features/user_auth/presentations/pages/PaginaProfessores.dart';
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
  //Coleta de dados do usuário
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

                //Ao clicar em 'Criar conta' muda para a tela PaginaCadastro
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Faz a validação dos dados para efetuar o login
  void _logar() async{
    String email = _emailController.text;
    String senha = _senhaController.text;

    //Método da classe "firebase_auth_services" que loga o usuário
    User? user = await _auth.loginEmailESenha(email, senha);

    if( user != null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaginaProfessores()),
      );

    }else{
      //Avisa usuário de login inválido
      showAlertDialog(context);
    }
  }

  //Alerta que mostra caso login seja inválido
  void showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("Voltar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Corpo do alerta
    AlertDialog alert = AlertDialog(
      title: Text("Usuário não encontrado.", style: TextStyle(color: Colors.red)),
      content: Text(""),
      actions: [
        okButton,
      ],
    );

    // Exibe o diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
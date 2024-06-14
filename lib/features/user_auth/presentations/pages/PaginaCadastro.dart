//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pi2/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';


import 'PaginaLogin.dart';

class PaginaCadastro extends StatefulWidget {
  const PaginaCadastro({super.key});

  @override
  State<PaginaCadastro> createState() => _PaginaCadastro();
}


class _PaginaCadastro extends State<PaginaCadastro>{

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  //Coleta os dados do usuário
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8F598F), // Cor de fundo
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100), // padding superior
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32), // margens laterais
          child: Container(
            padding: const EdgeInsets.all(16), // padding do container branco
            color: Colors.white, // cor de fundo do container
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Cadastro:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Nome:',
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailController, //adiciona o controlador ao compo Email
                  decoration: const InputDecoration(
                    hintText: 'Email:',
                    contentPadding: EdgeInsets.all(12),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 8),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'CPF:',
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),

                const SizedBox(height: 16),
                TextField(
                  controller: _senhaController, //adiciona o controlador ao compo Senha
                  decoration: const InputDecoration(
                    hintText: 'Senha:',
                    contentPadding: EdgeInsets.all(12),
                  ),
                  obscureText: true,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PaginaLogin()),
                    );                                                        //volta a tela de login
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    child: Text(
                      'Já tenho uma conta',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8F598F),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _cadastrar();//volta a tela de login dps de fazer cadastro
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // cor de fundo do botão
                    padding: const EdgeInsets.all(12),
                  ),
                  child: const Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Valída os dados do cadastro
  void _cadastrar() async{
    String email = _emailController.text;
    String senha = _senhaController.text;

    //Função que faz o cadastro da classe "firebase_auth_services"
    User? user = await _auth.cadastroEmailESenha(email, senha);

    if( user != null){ //valida o usuário
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PaginaLogin()),
      );

    }else{
      //Caso cadastro inválido, notifíca o usuário
      showAlertDialog(context);
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("Voltar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Corpo do alerta
    AlertDialog alert = AlertDialog(
      title: Text("Dados inválidos.", style: TextStyle(color: Colors.red)),
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

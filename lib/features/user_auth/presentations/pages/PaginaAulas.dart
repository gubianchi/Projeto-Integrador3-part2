import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class PaginaAulas extends StatefulWidget {

  //Variável id que guarda o userId de cada usuário (precisa dela pra fazer as buscas das aulas)
  final String id;
  //construtor da Classe
  const PaginaAulas({Key? key, required this.id}) : super(key: key);

  @override
  State<PaginaAulas> createState() => _PaginaAulas();
}

class _PaginaAulas extends State<PaginaAulas> {

  //Onde vai mostrar todas as aulas do usuário
  Widget listItem({required Map aulas}) {
    //Definição de variáveis para usar no container
    String hrInicio = aulas['horaInicio'];
    String hrFim = aulas["horaFim"];
    String nomeDisciplina = aulas['nomeDisciplina'];
    String local = aulas['local'];
    String ponto = aulas["pontoBatido"] ? "Ponto batido!" : 'Bater Ponto!';


    //Corpo de como os dados serão mostrados
    return Container(
      margin: const EdgeInsets.all(10),
      //padding: const EdgeInsets.all(2),
      height: 170,

      color: Color(0xFF8F598F),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nome da disciplina: $nomeDisciplina",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Hora de início: $hrInicio",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Hora de término: $hrFim",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
            Text(
              "Local: $local",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
            onPressed: () {

              if(aulas['pontoBatido']){
                //Se o ponto ja estiver batido, avisa o usuário
                showAlertDialog2(context);
              }else{
                //Se ainda não foi batido, pergunta se quer bater
                showAlertDialog(context, nomeDisciplina);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.all(4),
            ),
            child: Text(
              "$ponto",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 3),
        ],
      ),
    );
  }

  //Realiza a consulta e mostra os dados
  @override
  Widget build(BuildContext context) {

    //Query = usada apenas para fazer uma consulta no bd
    Query dbRef = FirebaseDatabase.instance.ref().child(widget.id);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Aulas: '),
        ),
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              //Pega os dados achados e insere em um Map
              Map aulas = snapshot.value as Map;
              aulas['key'] = snapshot.key;

              return listItem(aulas: aulas);
            },
          ),
        )
    );
  }


  //alerta que mostra quando o ponto ainda NÃO FOI BATIDO
  void showAlertDialog(BuildContext context, String nomeDisciplina) {
    // Configura o botão OK
    Widget okButton = TextButton(
      child: Text("Aceitar"),

      //Quando clica em "aceitar" faz a atualização do de false para true em "pontoBatido" no bd
      onPressed: () {

        //"Reference" é a localização dos registros das aulas de cada usuário
        //DatabaseReference = usado para fazer modificações no bd
        DatabaseReference reference = FirebaseDatabase.instance.ref().child(widget.id);

        //Map pra falar pro bd qual campo vai atualizar
        Map<String, bool> aulas = {
          'pontoBatido': true
        };

        //pega cada aula do professor e atualiza para true
        reference.child(nomeDisciplina).update(aulas).then((value) => {Navigator.pop(context)});
      }
    );

    Widget negarButton = TextButton(
      //Clicar em voltar volta para a tela anterior
      child: Text("Voltar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    //Corpo do alerta (titulo q ele vai mostrar e os botões q o usuário pode clicar)
    AlertDialog alert = AlertDialog(
      title: Text("Registrar ponto"),
      content: Text(""),
      actions: [
        okButton,
        negarButton,
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

  //alerta que mostra quando o ponto JÁ FOI BATIDO
  void showAlertDialog2(BuildContext context) {

    //O ponto já foi batido, então o usuário é alertado disso e anda acontece
    Widget okButton = TextButton(
      child: Text("Voltar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Corpo do alerta
    AlertDialog alert = AlertDialog(
      title: Text("Ponto já registrado!", style: TextStyle(color: Colors.red)),
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
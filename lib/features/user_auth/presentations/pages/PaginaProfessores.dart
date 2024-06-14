import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'PaginaAulas.dart';

class PaginaProfessores extends StatefulWidget {

  @override
  State<PaginaProfessores> createState() => _PaginaProfessores();
}

class _PaginaProfessores extends State<PaginaProfessores> {

  //Path dos dados do banco (query é usada apenas para consulta)
  Query dbRef = FirebaseDatabase.instance.ref();

  //Corpo de como os dados do bd serão mostrado
  Widget listItem({required Map professores}) {
    //Estrutura onde vai ser mostrado os dados do usuário
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 110,
      color: Color(0xFF8F598F),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            professores["key"],
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaginaAulas(id: professores["key"])),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.all(9),
            ),
            child: const Text(
              'Aulas',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 5),

      ],
    ),
    );
  }
  //Realiza a consulta e mostra os dados
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Professores: '),
        ),
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              //Pega os dados achados e armazena em um Map
              Map professores = snapshot.value as Map;
              professores['key'] = snapshot.key;

              return listItem(professores: professores);
            },
          ),
        )
    );
  }
}
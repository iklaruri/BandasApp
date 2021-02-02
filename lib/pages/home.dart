import 'dart:io';

import 'package:bands_name_app/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  List<Band> bandas = [
    Band(id: '1',name: 'Metallica',votes: 10),
    Band(id: '2',name: 'Queen',votes: 8),
    Band(id: '3',name: 'Scorpions',votes: 7),
    Band(id: '4',name: 'Beatles',votes: 5)
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandas',style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bandas.length,
        itemBuilder: (BuildContext context, int index) => _tituloBanda(bandas[index])
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNuevoBanda
      ),
    );
  }

  Widget _tituloBanda(Band banda) {
    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction){
        print('id: ${banda.id}');
        //TODO: Borrado en el server
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Eliminar',style: TextStyle(color: Colors.white)),
        )
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(banda.name.substring(0,2)),
          backgroundColor: Colors.blue[100]
        ),
        title: Text(banda.name),
        trailing: Text('${banda.votes}',style: TextStyle(fontSize: 20)),
        onTap: (){
          print(banda.name);
        },
      ),
    );
  }

  addNuevoBanda(){

    final textController = new TextEditingController();

    if(Platform.isAndroid){
      // Dialogo en Android
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text('Nueva banda'),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                    child: Text('Aceptar'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addBandaToList(textController.text)
                )
              ],
            );
          }
      );
    }else{
      // Dialogo en IOS
      showCupertinoDialog(
          context: context,
          builder: (_){
            return CupertinoAlertDialog(
              title: Text('Nueva banda'),
              content: CupertinoTextField(
                controller: textController,
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text('Aceptar'),
                  isDefaultAction: true,
                  onPressed: () => addBandaToList(textController.text)
                ),
                CupertinoDialogAction(
                    child: Text('Cancelar'),
                    isDefaultAction: true,
                    onPressed: () => Navigator.pop(context)
                )
              ],
            );
          }
      );
    }

  }

  void addBandaToList(String name){
    if(name.length > 1){
      this.bandas.add(new Band(id:DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);

  }
}




import 'package:flutter/material.dart';
import '../model/language.dart';
class TempPage extends StatelessWidget {
  const TempPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("For IMSH"),
      ),
        body: Container(
          child: Column(
            children: [
              ElevatedButton(child: Text('press'),onPressed: ()async{
                print(await LanguageML.convertLanguage('telugu', "My name is"));
                LanguageML.speechOutput(await LanguageML.convertLanguage('hindi', "did u eat"), 'hindi');
              },),
            ],
          ),
        )
    );
  }
}

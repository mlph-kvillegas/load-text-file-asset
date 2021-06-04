import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Text File Asset'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: FutureBuilder(
        future: loadAsset(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text('Has Error'),
                ),
              );
            }
            return Container(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(snapshot.data.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/message.txt');
}
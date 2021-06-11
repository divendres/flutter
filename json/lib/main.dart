import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/client.dart';

Future<List> agafaClients() async {
  var url = 'https://jsonplaceholder.typicode.com/users';

  var response = await http.get(Uri.parse(url));

  try {
    if (response.statusCode == 200) {
      List<Client> llistaClients = [];
      String data = response.body;
      for (var client in convert.jsonDecode(data)) {
        llistaClients.add(Client.fromJson(client));
      }
      return llistaClients;
    } else {
      throw Exception('S\'ha produit un error al carregar les dades');
    }
  } catch (e) {
    throw Exception('S\'ha produit un error al tractar les dades');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _max = 0;
  late Future<List> futureClients;

  @override
  void initState() {
    super.initState();
    futureClients = agafaClients();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clients',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Clients'),
        ),
        body: Center(
          child: FutureBuilder<List>(
            future: futureClients,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var list = snapshot.data as List;

                scheduleMicrotask(() => setState(() {
                      _max = list.length;
                    }));
                if (_max == 0) {
                  return ListTile(title: const Text("Llista buida"));
                }
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];

                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text(item.email),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class ClientItem {
  final String name;
  final String email;

  ClientItem(this.name, this.email);

  Widget buildTitle(BuildContext context) => Text(name);
  Widget buildSubtitle(BuildContext context) => Text(email);
}

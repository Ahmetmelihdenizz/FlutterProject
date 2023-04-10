import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'To-Do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> items = [
    {'task': 'coursera', 'time': '12:00'},
    {'task': 'girişimcilik', 'time': '15:00'},
    {'task': 'flutter', 'time': '18:00'},
  ];

  TextEditingController itemController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _promptDeleteItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Görevi sil'),
          content: Text('"' + items[index]['task'] + '" görevini silmek istediğinize emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sil'),
              onPressed: () {
                _deleteItem(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Items listesini saat sırasına göre sıralıyoruz
    items.sort((a, b) => a['time'].compareTo(b['time']));

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]['task']),
              subtitle: Text('Saat: ' + items[index]['time']),
              onTap: () {
                _promptDeleteItem(index);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Yeni görev ekle'),
    content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    TextField(
    controller: itemController,
      decoration: InputDecoration(
        labelText: 'Görev',
      ),
    ),
      TextField(
        controller: timeController,
        decoration: InputDecoration(
          labelText: 'Saat (HH:mm)',
        ),
      ),
    ],
    ),
          actions: <Widget>[
            TextButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ekle'),
              onPressed: () {
                setState(() {
                  items.add({
                    'task': itemController.text,
                    'time': timeController.text,
                  });
                });
                itemController.clear();
                timeController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
          },
      );
        },
          tooltip: 'Yeni görev ekle',
          child: Icon(Icons.add),
        ),
    );
  }
}


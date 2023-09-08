import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Key Press Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Key Press Demo'),
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

  late FocusNode focusNode;

  bool _onKey(KeyEvent event) {
    if (event is KeyUpEvent) {
      print('Key up: ${event.logicalKey.keyLabel}');
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    ServicesBinding.instance!.keyboard.addHandler(_onKey);
  }

  @override
  void dispose() {
    ServicesBinding.instance!.keyboard.removeHandler(_onKey);
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('Press a key to print its keyId'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => focusNode.requestFocus(),
        tooltip: 'Focus',
        child: Icon(Icons.edit),
      ),
    );
  }
}

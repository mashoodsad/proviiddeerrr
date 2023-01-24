import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AppState extends ChangeNotifier{
  String someValue = '';

  updateSomeValue(String newValue){
    someValue = newValue;
    notifyListeners();
  }
}

void main() {
  runApp(ChangeNotifierProvider(create: (_) => AppState(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppState>(context);

    _controller.text = provider.someValue;

    return Scaffold(
      appBar: AppBar(
        title:Text('hello'),
      ),
      body: Column(
        children: [
          Center(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    controller: _controller,
                    onChanged: (value) {
                      provider.updateSomeValue(value);
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        provider.updateSomeValue(context.watch<AppState>().someValue);
                      },
                      child: const Text('Add some Text'))
                ])),
          ),Text(context.watch<AppState>().someValue),
        ],
      ),
    );
  }
}
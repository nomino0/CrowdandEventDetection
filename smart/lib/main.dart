import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _value = 0;

  @override
  void initState() {
    super.initState();

    final databaseReference =
        FirebaseDatabase.instance.ref('Nombre de personnes');
    databaseReference.onValue.listen((event) {
      setState(() {
        _value = event.snapshot.value as int;
        print(_value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return _buildBody();
                }),
            Positioned(
              bottom: 0,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Center(
                    child: Text(
                  'Number of Person In Current Space',
                  style: TextStyle(
                      color: _value >= 5
                          ? Colors.red
                          : _value >= 3
                              ? Colors.yellow
                              : _value == 2
                                  ? Colors.blue
                                  : Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_value <= 1) {
      return Container(
        color: Colors.green,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            _value.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 300),
          ),
        ),
      );
    } else if (_value == 2) {
      return Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            _value.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 300),
          ),
        ),
      );
    } else if (_value >= 3 && _value < 5) {
      return Container(
        color: const Color.fromARGB(255, 235, 214, 96),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            _value.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 300),
          ),
        ),
      );
    } else if (_value >= 5) {
      return Container(
        color: const Color.fromARGB(255, 190, 68, 68),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            _value.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 300),
          ),
        ),
      );
    } else {
      return const CircularProgressIndicator(
        color: Colors.grey,
        strokeWidth: 1,
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_pom/pinselect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pin on Mobile Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pin on Mobile Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String testURL = "https://pom-test.interswitch-ke.com/f5be0d7e-cb54-4c05-b9a2-79197265b5d5?callbackUrl=www.google.com";
  final String uuid = "f5be0d7e-cb54-4c05-b9a2-79197265b5d5";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.inversePrimary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ))),
                child: const Text(
                  "Change PIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Averta',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  changePin(testURL, uuid);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> changePin(String url, String uuid) async {
    PinSelect pinSelect = PinSelect(live: false);

    pinSelect.changePin(context: context,
        pomUrl: url,
        uuid: uuid,
        transactionSuccessfulCallback: transactionSuccesfullCallback,
        transactionFailureCallback: transactionFailureCallback);
  }

  void transactionSuccesfullCallback(payload) {
    final snackBar = SnackBar(
      content: Text("transaction success $payload"),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void transactionFailureCallback(payload) {
    {
      final snackBar = SnackBar(
        content: Text("transaction failure $payload"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

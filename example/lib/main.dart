import 'dart:core';

import 'package:example/models/AccountData.dart';
import 'package:example/models/InstitutionData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pom/pinselect.dart';
import 'package:flutter_pom/api/models/AccountModel.dart';
import 'package:flutter_pom/api/models/InstitutionModel.dart';

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
  final String testURL =
      "https://pom-test.interswitch-ke.com/f5be0d7e-cb54-4c05-b9a2-79197265b5d5?callbackUrl=www.google.com";
  final String uuid = "f5be0d7e-cb54-4c05-b9a2-79197265b5d5";

  final String serialNumber = "1410916";
  final bool isDebit = true;

  final String clientID = "IKIA971FB5996EADBD16534494CB87B90D1DB3EAD105";
  final String clientSecret = "ONcmxGU4B+A+qaHp+/Nw19yO9w117PY36/SxsH1A1Wc=";
  final int institutionID = 54;
  final String callbackURL = "www.google.com";
  final String keyID = "deee79ba-f912-11eb-9a03-0242ac130003";

  final String publicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAo+eP/jVrcZ5G3A6glDSnY2kpdz67G+3z0Oc0XeI+7kHfdmwyjdC2nalTVyEW4iGLzMUvWX1iK5W1Ozrq8E8NRTy/PNTWCd71+mgvFzt6Fgab8lTRMv8+oniM6X4i9mbOkB0nKaByGmY/DDDiYoCBehvB32KaJIyr39LNke5iB98+3TWhv/cZsJ8LabhdHXgWXsnWZonke0hSkH+lpnph+zFHi1z1bLqghC2zPAUCzBbaYoDVM6DGWJ9tJVHYjMDHjNJC617PEEtOBwIWv5G19Aw51DvtD3cIwGzuA5f5xe4LWc2tZ0RVfUekIvJzwe0MvTjRHqZWCX/08FmayGlNfwIDAQAB";
  final String privateKey = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCj54/+NWtxnkbcDqCUNKdjaSl3Prsb7fPQ5zRd4j7uQd92bDKN0LadqVNXIRbiIYvMxS9ZfWIrlbU7OurwTw1FPL881NYJ3vX6aC8XO3oWBpvyVNEy/z6ieIzpfiL2Zs6QHScpoHIaZj8MMOJigIF6G8HfYpokjKvf0s2R7mIH3z7dNaG/9xmwnwtpuF0deBZeydZmieR7SFKQf6WmemH7MUeLXPVsuqCELbM8BQLMFtpigNUzoMZYn20lUdiMwMeM0kLrXs8QS04HAha/kbX0DDnUO+0PdwjAbO4Dl/nF7gtZza1nRFV9R6Qi8nPB7Qy9ONEeplYJf/TwWZrIaU1/AgMBAAECggEAD5eXRKUbUAcxEX0YvJCXvebCqZPfo+QKljxwaF/+AZdlpTPcyU3qGWyCv56nuSJc1MGLZBV/8cp/n59Wuz6h8gy52pUauXyq5MPleu3PCupdCnwUHKhYcodKTGoR9GPKUb5cO+MGB8njRIsf9iPobU/XrSMJq+Fv9k5s/O1zCPGGZb4Mu7TkqIQSaShQO1mvLXvQ3Bp9CsxdD5SDJs8G2vxZLOlEbChPr7QW4khkN05AVHT8xxc4QUL1IVVf+VrVy68wUs129R4V9BTXojAEu1R9mbkleTWwH50UH/Sd3zQeiQ2MoK7b/kGb5mYqnlDoZnsGtng51Zqff5RPnRDntQKBgQDNV612LWSN5U+z4eS4Q8wDWNftsPnFYTab9r1RfRDtvZuzv7Pc+TpLmWWk/kMMBbaco2luFdTHxg7Xo9fk2rEdLaigE6qz71ulL3/qCaLLdw2sAT3UFKdeQ5d4hRNV1hFLIaX1UXJHT1RsLHIoJzVEHi9rgy+9T+RqUev0jYXqswKBgQDMVuNJlAZjFclhdUcyTTP84k21jKvvVcwpCtHhtZG1XTbMzJt4RaVqvanpo844kYKauPCMdXwIaFgwpV08sa3PGcoQemDx8LUPtyO+f95+msFK57f59qMEoGKUJT1ieKO/SdQr3rySo+Vf1WcP5rOl6HVR6xWtnKkmNuDR4kFoBQKBgE4Yg3tHpk+lH9v9FLzT5Bp9xpm6zjO4VkmY3MXKOA8DJt2FEkX/b6Fi9Np8bUl8PshyCd35ZZSZCfoPcUOzvNqpC9HdyPVoGkXHu/FpusWBQOzjB/3J4SGjuU735bOml6soX/LeCAWA8U221a/ZwZNnm4dbPGPWp7ub7o5y6LSrAoGAYBHJsmIhzpwDngphesjJVG+hUWXdwBx6bCFmI9QVuUsl5Iud3KIB73lUVUBqSDZBTTT+A0uJEPrd26EjgNGYgfICClU/FwCwX78e0wWTObrQfcMLwD2wzxAIyNXpUk6dzeWMF0QVLGxZ/wB6AAPbGnl8DxOTkZhB/nF2qbbSQXECgYEAxKXTRNBY7D95lBEh/ESgxTW7RrXT9swcpgZnT0+ASD2WISfYA9VrRrmyHSm9BZDM0tQpHvylnekXtvla+I6lAXU9WV8A/6WpZsYkA2CUaqC5ILvMwuDJKtZxNWiXK0yCmzKTECCiR4no5n69IONVi2VolxqHgNKpfdX48QhzQbw=";

  PinSelect pinSelect = PinSelect(live: true);

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
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.inversePrimary),
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
                  initialize();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> initialize() async {
    AccountModel accModel = AccountModel(serialNumber, isDebit);
    InstitutionModel instModel = InstitutionModel(clientID, clientSecret,
        institutionID, publicKey, privateKey, keyID, callbackURL);
    pinSelect.initialize(accountModel: accModel, institutionModel: instModel);
  }

  Future<void> changePin(String url, String uuid) async {
    pinSelect.changePin(
        context: context,
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

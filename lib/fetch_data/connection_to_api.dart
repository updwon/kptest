import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class ConnectionToApi {
  final RTO = new Duration(seconds: 15);
  late BuildContext context;

  Future<Object?> fetchProducts() async {
    http.Response response =
        await http.get(Uri.parse('https://fakestoreapi.com/products')).timeout(
      const Duration(seconds: 30), // make time out in 30 seconds when fetching data
      onTimeout: () {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Alert",
          desc: 'Can\'t connect in 30 seconds.',
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();

        return throw TimeoutException('Can\'t connect in 30 seconds.');
      },
    );

    print('Response status: ${response.statusCode}');

    return response.body;
  }
}

import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin Alerts {
  Future showErrorDialog({required BuildContext context, String? textContent}) {
    return showDialog(
        context: context,
        builder: (context) => Center(
              child: AlertDialog(
                title: const Text(
                  'Aviso',
                ),
                content: Text(
                  textContent ?? 'Ocurrió un error, vuelva a intentarlo.',
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      'Aceptar',
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
        barrierDismissible: true);
  }
}

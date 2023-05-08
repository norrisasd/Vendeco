import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vendeco/app/modules/transactions/views/transactions_content.dart';
import 'package:vendeco/firebase_options.dart';

import '../../../../shared/navigation.dart';
import '../../../../shared/responsive.dart';
import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  TransactionsView({Key? key}) : super(key: key);
  final Future<FirebaseApp> _fApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const Navigation(),
      body: FutureBuilder(
          future: _fApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            } else if (snapshot.hasData) {
              return SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    if (Responsive.isDesktop(context))
                      const Expanded(
                        child: Navigation(),
                      ),
                    const Expanded(
                      flex: 3,
                      child: TransactionsContent(),
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

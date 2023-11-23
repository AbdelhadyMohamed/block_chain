import 'package:block_chain/login/presentation/pages/login.dart';
import 'package:block_chain/shared/local/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blockchain_wallet/presentation/manager/wallet_bloc.dart';
import 'blockchain_wallet/presentation/pages/screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheData.init();
  FirebaseFirestore.instance.enableNetwork();
  String? token = await CacheData.getData("token");
  String start;
  if (token == null) {
    start = "Login";
  } else {
    start = "blockScreen";
  }
  runApp(MyApp(start));
}

class MyApp extends StatelessWidget {
  final String start;
  const MyApp(this.start, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blockchain Wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: start,
      routes: {
        WalletScreen.routeName: (context) => WalletScreen(),
        LoginScreen.routeName: (context) => LoginScreen()
      },
      home: BlocProvider(
        create: (context) => WalletBloc(),
        child: WalletScreen(),
      ),
    );
  }
}

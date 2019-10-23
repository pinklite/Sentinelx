import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentinelx/models/db/database.dart';
import 'package:sentinelx/screens/home.dart';
import 'package:sentinelx/shared_state/ThemeProvider.dart';
import 'package:sentinelx/shared_state/appState.dart';
import 'package:sentinelx/shared_state/loaderState.dart';
import 'package:sentinelx/shared_state/networkState.dart';
import 'package:sentinelx/shared_state/txState.dart';

import 'models/wallet.dart';

Future main() async {
  Provider.debugCheckInvalidValueType = null;
  await initDatabase();
  return runApp(MultiProvider(
    providers: [
      Provider<AppState>.value(value: AppState()),
      ChangeNotifierProvider<NetworkState>.value(value: NetworkState()),
      ChangeNotifierProvider<ThemeProvider>.value(value: AppState().theme),
      Provider<Wallet>.value(value: AppState().selectedWallet),
      ChangeNotifierProvider<TxState>.value(value: AppState().selectedWallet.txState),
      ChangeNotifierProvider<LoaderState>.value(value: AppState().loaderState),
    ],
    child: SentinelX(),
  ));
}

class SentinelX extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, model, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: model.theme,
        home: Home(),
      );
    });
//    return
  }
}

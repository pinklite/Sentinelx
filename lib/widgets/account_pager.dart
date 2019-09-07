import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sentinelx/models/wallet.dart';
import 'package:sentinelx/models/xpub.dart';
import 'package:sentinelx/screens/Track/track_screen.dart';
import 'package:sentinelx/shared_state/appState.dart';
import 'package:sentinelx/widgets/balance_card_widget.dart';
import 'package:sentinelx/widgets/card_widget.dart';

class AccountsPager extends StatefulWidget {
  @override
  _AccountsPagerState createState() => _AccountsPagerState();
}

class _AccountsPagerState extends State<AccountsPager> with SingleTickerProviderStateMixin {
  PageController _pageController;
  Wallet wallet;
  @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: 0, keepPage: true, viewportFraction: 0.89);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      height: 230,
      color: Theme.of(context).primaryColorDark,
      child: Consumer<Wallet>(
        builder: (context, model, child) {
          wallet = model;
          final count  =  model.xpubs.length  == 0 ? 1:  model.xpubs.length+ 2;
          return PageView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _pageBuilder(context, index, model.xpubs.length);
              },
              physics: BouncingScrollPhysics(),
              pageSnapping: true,
              onPageChanged: _onPageChange,
              controller: _pageController,
              itemCount: count);
        },
      ),
    );
  }

  Widget _pageBuilder(BuildContext context, int index, int xpubLength) {
    if (index > xpubLength || xpubLength==0) {
      return Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            color: Theme.of(context).primaryColor,
            child: InkWell(
              onTap: navigate,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add),
                  Text(
                    "Track new",
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              )),
            ),
          ),
        ),
      );
    }
    if (index == 0 && AppState().selectedWallet.xpubs.length != 0) {
      return Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BalanceCardWidget(),
        ),
      );
    } else {
      return Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChangeNotifierProvider.value(value: wallet.xpubs[index - 1], child: CardWidget()),
        ),
      );
    }
  }

  void _onPageChange(int index) {
    Provider.of<AppState>(context).setPageIndex(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void navigate() async {
    int result = await Navigator.of(context).push(new MaterialPageRoute<int>(builder: (BuildContext context) {
      return Track();
    }));
    print("result ${result}");
    if(result!=null){
      AppState().setPageIndex(result+1);
      print("setPageIndex");
      await AppState().refreshTx(result);
      print("refresh");

    }

  }
}

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'bitcoin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  BitcoinData data = BitcoinData();
  CoinData coinData = CoinData();
  bool dataLoaded = false;

  var currencyAmtList = {
    'btcCurrencyAmt': '0.00',
    'ethCurrencyAmt': '0.00',
    'ltcCurrencyAmt': '0.00',
  };

  List<Widget> currencyCards = [];

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  void updateUI() {
    getBitcoinData().then(
      (val) {
        setState(() {
          currencyAmtList['btcCurrencyAmt'] =
              coinData.currencyFormatter(val[0]["price"], selectedCurrency);
          currencyAmtList['ethCurrencyAmt'] =
              coinData.currencyFormatter(val[1]["price"], selectedCurrency);
          currencyAmtList['ltcCurrencyAmt'] =
              coinData.currencyFormatter(val[2]["price"], selectedCurrency);

          dataLoaded = true;

          currencyCards = generateCards();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> currencyItems = new List<Text>();

    currenciesList.forEach((element) {
      currencyItems.add(Text(element));
    });

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedCurrency) {
        updateUI();
      },
      children: currencyItems,
    );
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> currencyDropDown =
        new List<DropdownMenuItem<String>>();

    currenciesList.forEach((element) {
      currencyDropDown.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });

    return DropdownButton<String>(
      value: selectedCurrency,
      items: currencyDropDown,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          updateUI();
        });
      },
    );
  }

  Future<dynamic> getBitcoinData() async {
    setState(() {
      dataLoaded = false;
    });
    var bitcoinData = await data.getData(selectedCurrency);
    return bitcoinData;
  }

  List<Card> generateCards() {
    List<Card> cryptoCards = new List<Card>();

    List<String> tempList = new List<String>();

    currencyAmtList.forEach((key, value) {
      tempList.add(value);
    });

    for (int i = 0; i < cryptoList.length; i++) {
      cryptoCards.add(
        Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: dataLoaded
                ? Text(
                    '1 ${cryptoList[i]} = ${tempList[i]} $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Retrieving data...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      );
    }

    return cryptoCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: currencyCards,
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSPicker() : androidDropdown()),
        ],
      ),
    );
  }
}

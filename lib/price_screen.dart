import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'bitcoin_data.dart';
import 'dart:convert';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  BitcoinData data = BitcoinData();
  double currencyAmt;
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();

    getBitcoinData().then(
          (val) {
        setState(() {
          print(currencyAmt);
          currencyAmt = double.parse(val).roundToDouble();
          dataLoaded = true;
          print(currencyAmt);
        });
      },
    );
  }

//  void updatedUI(dynamic bitcoinData) {
//    setState(() {
//      currencyAmt = double.parse(val).roundToDouble();
//      dataLoaded = true;
//    });
//  }

  CupertinoPicker iOSPicker() {
    List<Text> currencyItems = new List<Text>();

    currenciesList.forEach((element) {
      currencyItems.add(Text(element));
    });

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedCurrency) {
        getBitcoinData().then(
          (val) {
            currencyAmt = double.parse(val).roundToDouble();
            setState(() {
              dataLoaded = true;
            });
          },
        );
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
          getBitcoinData().then(
            (val) {
              currencyAmt = double.parse(val).roundToDouble();
              setState(() {
                dataLoaded = true;
              });
            },
          );
        });
      },
    );
  }

  Future<String> getBitcoinData() async {
    setState(() {
      dataLoaded = false;
    });
    var bitcoinData = await data.getData(selectedCurrency) ?? 0.0;
    return bitcoinData[0]["price"];
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
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: dataLoaded
                    ? Text(
                        '1 BTC = $currencyAmt $selectedCurrency',
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

import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const Map<String, String> currencySymbol = {
  'AUD': '\$',
  'BRL': 'R\$',
  'CAD': '\$',
  'CNY': '¥',
  'EUR': '€',
  'GBP': '£',
  'HKD': '\$',
  'IDR': 'Rr',
  'ILS': '₪',
  'INR': '₹',
  'JPY': '¥',
  'MXN': '\$',
  'NOK': 'kr',
  'NZD': '\$',
  'PLN': 'zł',
  'RON': 'lei',
  'RUB': '₽',
  'SEK': 'kr',
  'SGD': '\$',
  'USD': '\$',
  'ZAR': 'R',
};

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String currencyFormatter(String amt, String currency) {
    FlutterMoneyFormatter fmf;

    if (currency == 'AUD' ||
        currency == 'CAD' ||
        currency == 'CNY' ||
        currency == 'GBP' ||
        currency == 'HKD' ||
        currency == 'MXN' ||
        currency == 'NOK' ||
        currency == 'NZD' ||
        currency == 'SGD' ||
        currency == 'USD' ||
        currency == 'ZAR') {
      fmf = FlutterMoneyFormatter(
        amount: double.parse(amt),
        settings: MoneyFormatterSettings(
          symbol: currencySymbol[currency],
          thousandSeparator: ',',
          decimalSeparator: '.',
          symbolAndNumberSeparator: '',
          fractionDigits: 2,
        ),
      );
      return fmf.output.symbolOnLeft;
    } else if (currency == 'BRL' ||
        currency == 'EUR' ||
        currency == 'ILS' ||
        currency == 'JPY') {
      fmf = FlutterMoneyFormatter(
        amount: double.parse(amt),
        settings: MoneyFormatterSettings(
          symbol: currencySymbol[currency],
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: '',
          fractionDigits: 2,
        ),
      );
      return fmf.output.symbolOnLeft;
    } else if (currency == 'PLN' || currency == 'RON' || currency == 'SEK') {
      fmf = FlutterMoneyFormatter(
        amount: double.parse(amt),
        settings: MoneyFormatterSettings(
          symbol: currencySymbol[currency],
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: '',
          fractionDigits: 2,
        ),
      );
      return fmf.output.symbolOnRight;
    } else if (currency == 'INR') {
//      String money = new NumberFormat("##,##,##.0").format(amt);
      String money = NumberFormat.currency(
        locale: currency,
        customPattern: "₹##,##,###.##",
      ).format(
        double.parse(amt),
      );
      return money;
    } else if (currency == 'RUB') {
      fmf = FlutterMoneyFormatter(
        amount: double.parse(amt),
        settings: MoneyFormatterSettings(
          symbol: currencySymbol[currency],
          thousandSeparator: ' ',
          decimalSeparator: ',',
          symbolAndNumberSeparator: '',
          fractionDigits: 2,
        ),
      );
      return fmf.output.symbolOnRight;
    }
    else if (currency == 'IDR') {
      fmf = FlutterMoneyFormatter(
        amount: double.parse(amt),
        settings: MoneyFormatterSettings(
          symbol: currencySymbol[currency],
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 2,
        ),
      );
      return fmf.output.symbolOnLeft;
    }

    //  'PLN', zł -, symbol right
//  'RON', lei -, symbol right
//  'RUB', ₽ -, thousand space, symbol right
//  'SEK', kr -, symbol right

//    switch(currency) {
//      case 'AUD':
//        {
//          FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
//              amount: double.parse(amt),
//              settings: MoneyFormatterSettings(symbol: '\$',
//                thousandSeparator: ',',
//                decimalSeparator: '.',
//                symbolAndNumberSeparator: '',
//                fractionDigits: 2,
//              )
//          );
//          return fmf.output.symbolOnLeft;
//        }
//        break;
//  }
  }

  List<String> seperateMoney(String amt) {
    List tempList = new List();

    return tempList;
  }
}

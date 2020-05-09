import 'dart:convert';
import 'package:http/http.dart' as http;

class BitcoinData {
  BitcoinData();

  String apiURL;

  String getURL(String currency) {
    apiURL = "https://api.nomics.com/v1/currencies/ticker?key=demo-26240835858194712a4f8cc0dc635c7a&ids=BTC,ETH,XRP&interval=1d,30d&convert=$currency";
    return apiURL;
  }

  Future<dynamic> getData(String currency) async {
//    try {
      http.Response response = await http.get(getURL(currency));

      String data = response.body;

      return jsonDecode(data);

//    } catch (e) {
//      print(e);
//      //throw SocketException;
//    }
  }

}

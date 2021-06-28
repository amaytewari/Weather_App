import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper
{

  String url;
  
  NetworkHelper(this.url);

   Future getResponse() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      // jsonDecode(data);

      return jsonDecode(data);
    
    } else {
      print(response.statusCode);
      return null;
    }
  }



}
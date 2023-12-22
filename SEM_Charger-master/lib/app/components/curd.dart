
import 'package:http/http.dart' as http;
import 'dart:convert';

// for Basic API authentication.
String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'senior:senior2_2023'));

Map<String, String> myheaders = {
  'authorization': _basicAuth
};



class Curd{
  getRequest(String url) async {
    try{
      var response = await http.get(Uri.parse(url));
      if(response.statusCode==200){
        //200 = success
        var responseBody = jsonDecode(response.body);
        return responseBody;
      }else{
        print("Error ${response.statusCode}");
      }
    }catch(e){
      print("Error Catch $e ");
    }
  }

  postRequest(String url,Map data) async {
    try{
      var response = await http.post(Uri.parse(url),body: data,headers: myheaders);
      if(response.statusCode==200){
        var responseBody=jsonDecode(response.body);
        return responseBody;
      }else{
        print("Error ${response.statusCode}");
      }
    }catch(e){
      print("Error Catch $e ");
    }
  }
}
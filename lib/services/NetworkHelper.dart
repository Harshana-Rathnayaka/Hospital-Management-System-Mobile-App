import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class Network {
  // for real device
  final String url = "http://0.0.0.0:8000/api";

  // for emulator
  // final String url = "http://10.0.2.2:8000/api";

  postData(values, endpoint) async {
    var fullUrl = url + endpoint;

    return await http.post(fullUrl, body: values);
  }

  getData(endpoint) async {
    var fullUrl = url + endpoint;

    return await http.get(fullUrl);
  }

  checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      return true;
    }
  }
}

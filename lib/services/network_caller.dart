
class NetworkCaller {
  Future<Map<String, dynamic>> postRequest(String url, Map<String, dynamic> body) async {
    // Simulated network request
    await Future.delayed(Duration(seconds: 1));
    return {'status': 'success', 'data': {'email': body['email'], 'name': 'Demo User'}};
  }
}

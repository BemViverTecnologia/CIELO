import 'package:poppy/core/http_client/http_client_interface.dart';

import 'mocks/product_model_mock.dart';

class AwsApi implements HttpClient {
  @override
  Future<HttpResponse> get(String url) async {
    return HttpResponse(data: productListModelMock, statusCode: 200);
  }
}

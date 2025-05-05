import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

import 'package:api2/dist.dart';

Map<String, dynamic> getDistData(int index) {
  List<dynamic> distData = json.decode(dist);
  if (index < 0 || index > distData.length - 1) {
    throw Exception('Index is out of bounds: (0 - ${distData.length - 1})');
  }
  return distData[index];
}

Response _getDist(Request req, int index) {
  try {
    var distData = getDistData(index);
    final jsonData = json.encode(distData);
    return Response.ok(jsonData, headers: {'content-type': 'application/json'});
  } catch (e) {
    return Response.notFound(
      json.encode({'error': e.toString()}),
      headers: {'content-type': 'application/json'},
    );
  }
}

void main() async {
  Router router = Router();
  router.get('/', api);
  router.get('/greet', _greetHandler);
  router.get('/dist/<index>', (Request req, String index) {
    final int? parsedIndex = int.tryParse(index);
    if (parsedIndex == null) {
      return Response.badRequest(
        body: json.encode({'error': 'Index $index is not an integer'}),
        headers: {'content-type': 'application/json'},
      );
    }
    return _getDist(req, parsedIndex);
  });

  var handler = Pipeline().addMiddleware(logRequests()).addHandler(router);
  var server = await io.serve(handler, "0.0.0.0", 8080);
  print('${server.address} : ${server.port}');
  print('server running');
}

Response api(Request req) {
  return Response.ok('Hello again');
}

Response _greetHandler(Request req) {
  return Response.ok('Hello There... Good day');
}

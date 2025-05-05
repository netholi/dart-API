import 'package:api2/api2.dart' as api2;
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main()async{
var router=Router();

Response _getDist(){
return Response.ok('from dist');
}



router.get('/',_home);
router.get('/greet',_greeting);

router.get('/dist/<index>', (Request req, String index){
final int? parsedIndex= int.tryParse(index);
if(parsedIndex==null){
return Response.badRequest(
body:json.encode(
{'error':'Invalid Index: $index is not and integer'}
),
headers:{'content-type' :'application/json'}
);
}
return _getDist();
});



var handler=Pipeline().addMiddleware(logRequests()).addHandler(router);
var server=await io.serve(handler,"0.0.0.0",8080);
print("server is live ${server.address.host} : ${server.port}");
}

Response _home(Request req){
return Response.ok("Hello api - Home page api");
}

Response _greeting(Request req){
return Response.ok('Hello Greetings from api');
}





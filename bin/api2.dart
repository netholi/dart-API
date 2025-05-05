import 'package:api2/api2.dart' as api2;

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main()async{
var router=Router();
router.get('/',_home);
router.get('/greet',_greeting);
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





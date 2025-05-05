import 'package:api2/api2.dart' as api2;

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

void main()async{
var handler=Pipeline().addMiddleware(logRequests()).addHandler(api);
var server=await io.serve(handler,"0.0.0.0",8080);
print("server is live ${server.address.host} : ${server.port}");
}

Response api(Request req){
return Response.ok("Hello api - simple api");
}



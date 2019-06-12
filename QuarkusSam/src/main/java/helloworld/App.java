package helloworld;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

/**
 * Handler for requests to Lambda function.
 */
@Path("/hello")
//@Produces(MediaType.TEXT_PLAIN)
//@Consumes(MediaType.APPLICATION_JSON)
public class App /*implements RequestHandler<String, Object>*/ {

    @Inject
    HelloGreeter greeter;

    @POST
//    @Produces(MediaType.TEXT_PLAIN)
//    @Consumes(MediaType.APPLICATION_JSON)
    public Object handleRequest(final String request/*, final Context context*/) {
        System.out.println("App.handleRequest");
//        System.out.println("request = [" + request + "], context = [" + context + "]");
        System.out.println("greeter = " + greeter);

        return "hey there"; //greeter.greet(request.firstName, request.lastName);
//        Map<String, String> headers = new HashMap<>();
//        headers.put("Content-Type", "application/json");
//        headers.put("X-Custom-Header", "application/json");
//        try {
//            final String pageContents = this.getPageContents("https://checkip.amazonaws.com");
//            String output = String.format("{ \"message\": \"hello world\", \"location\": \"%s\" }", pageContents);
//            return new GatewayResponse(output, headers, 200);
//        } catch (IOException e) {
//            return new GatewayResponse("{}", headers, 500);
//        }
    }

}

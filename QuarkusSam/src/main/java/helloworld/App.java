package helloworld;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/greeting")
public class App {

    @Inject
    HelloGreeter greeter;

    @POST
    @Path("/hello")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public String greet(final HelloRequest request) {
        return greeter.greet(request.firstName, request.lastName);
    }

    @POST
    @Path("/bye")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public String bye(final HelloRequest request) {
        return greeter.bye(request.firstName, request.lastName);
    }

}

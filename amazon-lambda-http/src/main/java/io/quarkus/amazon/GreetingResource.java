package io.quarkus.amazon;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/hello")
public class GreetingResource {
    @Inject
    HelloGreeter greeter;

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String hello() {
        return "hello jaxrs";
    }

    @POST
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

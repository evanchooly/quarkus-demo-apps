package io.quarkus.amazon;

import javax.imageio.ImageIO;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

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

    @GET
    @Path("/kitten")
    @Produces("image/jpeg")
    public Response kitten() throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        InputStream stream = getClass().getResourceAsStream("/kitten.jpeg");
        BufferedImage image = ImageIO.read(stream);
        ImageIO.write(image, "jpeg", baos);
        byte[] imageData = baos.toByteArray();

        return Response.ok(new ByteArrayInputStream(imageData)).build();
    }

}

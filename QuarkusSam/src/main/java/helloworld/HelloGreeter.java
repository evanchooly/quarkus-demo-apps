package helloworld;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class HelloGreeter {

    public String greet(String first, String last) {
        return String.format("Hello %s %s.", first, last);
    }

}

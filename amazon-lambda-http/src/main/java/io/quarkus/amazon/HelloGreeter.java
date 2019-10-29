package io.quarkus.amazon;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class HelloGreeter {

    public String greet(String first, String last) {
        return String.format("Hello %s %s.%n", first, last);
    }

    public String bye(String first, String last) {
        return String.format("Fare well, %s %s.%n", first, last);
    }

}

package sptek.spdevteam.intern;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

@SpringBootApplication(exclude={DataSourceAutoConfiguration.class})
//@SpringBootApplication
public class InternApplication {

    public static void main(String[] args) {
        SpringApplication.run(InternApplication.class, args);
    }

}

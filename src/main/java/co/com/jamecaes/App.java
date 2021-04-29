package co.com.jamecaes;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = {"co.com.jamecaes.*"})
public class App 
{
    public static void main( String[] args )
    {
        String[] arg={};
        SpringApplication.run(App.class, arg);
    }
}

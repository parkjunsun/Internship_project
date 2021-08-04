package sptek.spdevteam.intern;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.view.BeanNameViewResolver;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

@Configuration
@EnableWebMvc
public class WebConfigStarter implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/css/**").addResourceLocations("/resources/css/");
        registry.addResourceHandler("/images/**").addResourceLocations("/resources/images/");
        registry.addResourceHandler("/js/**").addResourceLocations("/resources/js/");
        registry.addResourceHandler("/plugin/**").addResourceLocations("/resources/plugin/");
        registry.addResourceHandler("/upload/**").addResourceLocations("/resources/upload/");
    }

    @Bean
    public ViewResolver viewResolver() {
        BeanNameViewResolver viewResolver = new BeanNameViewResolver();
        viewResolver.setOrder(0);
        return viewResolver;
    }

    @Bean
    MappingJackson2JsonView jsonView(){
        return new MappingJackson2JsonView();
    }
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.jsp("/WEB-INF/jsp/", ".jsp");
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/error").setViewName("error");
        registry.addViewController("/error/401").setViewName("error");
        registry.addViewController("/error/402").setViewName("error");
        registry.addViewController("/error/403").setViewName("error");
        registry.addViewController("/error/404").setViewName("error");
        registry.addViewController("/error/405").setViewName("error");
        registry.addViewController("/error/500").setViewName("error");
        registry.addViewController("/error/501").setViewName("error");

    }
}

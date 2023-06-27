package com.wtf.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.HandlerMethodReturnValueHandler;
import org.springframework.validation.Validator;
import java.util.*;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/favicon.ico")
                .addResourceLocations("classpath:/favicon.ico");
    }
    

    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
        // ºñ¿öµÓ´Ï´Ù.
    }

    @Override
    public void addFormatters(FormatterRegistry registry) {
        // ºñ¿öµÓ´Ï´Ù.
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // ºñ¿öµÓ´Ï´Ù.
    }

    @Override
    public void addReturnValueHandlers(List<HandlerMethodReturnValueHandler> handlers) {
        // ºñ¿öµÓ´Ï´Ù.
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // ºñ¿öµÓ´Ï´Ù.
    }

    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        // ºñ¿öµÓ´Ï´Ù.
    }

    @Override
    public void configureHandlerExceptionResolvers(List<HandlerExceptionResolver> resolvers) {
        // ºñ¿öµÓ´Ï´Ù.
    }

    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        // ºñ¿öµÓ´Ï´Ù.
    }

    @Override
    public Validator getValidator() {
        // ºñ¿öµÓ´Ï´Ù.
        return null;
    }
}

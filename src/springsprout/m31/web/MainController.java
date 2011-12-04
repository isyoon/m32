package springsprout.m31.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {
    @RequestMapping(value = "/main" ,method = RequestMethod.GET)
    public void main(){}

    @RequestMapping(value = "/littlelion" ,method = RequestMethod.GET)
    public void littlelion(){}
}
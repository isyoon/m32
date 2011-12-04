package springsprout.m31.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import springsprout.m31.modules.MapLocationService;

import static springsprout.m31.common.M31System.JSON_VIEW;

@Controller
public class PlayController {

    @Autowired
    MapLocationService mapLocationService;

    @RequestMapping(value="/play", method= RequestMethod.GET)
    public void play(Model model, Integer mapId){
        model.addAttribute("mapLocation",mapLocationService.getById(mapId));
    }

    @RequestMapping(value="/roadView",method=RequestMethod.GET)
    public ModelAndView roadView(Model model,Integer mapId){
        return new ModelAndView(JSON_VIEW).addObject("roadViews",mapLocationService.getRoadViewByMapId(mapId));        
    }

}

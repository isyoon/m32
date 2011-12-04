/**
 * Created by IntelliJ IDEA.
 * User: isyoon
 * Date: 2010. 6. 14
 * Time: 오전 2:02:45
 * enjoy springsprout ! development!
 */
package springsprout.m31.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import springsprout.m31.modules.MapLocationService;

@Controller
public class RegeditController {
    @Autowired
    MapLocationService mapLocationService;
    
    @RequestMapping(value = "/regedit",method = RequestMethod.GET)
    public void regedit(){}

    @RequestMapping(value="/localSearch",method=RequestMethod.GET)
    public ModelAndView localSearch(){
            
        return new ModelAndView();
    }

    @RequestMapping(value="delete",method=RequestMethod.GET)
    public String delete(Integer mapId){
        mapLocationService.delete(mapId);
        return "redirect:/";
    }
}
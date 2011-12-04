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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import springsprout.m31.domain.MapLocation;
import springsprout.m31.modules.MapLocationService;

import java.util.Iterator;

@Controller
public class RecordController {
    @Autowired
    MapLocationService mapLocationService;
    @RequestMapping(value = "/record",method = RequestMethod.GET)
    public String recordTest(ModelMap modelMap ,MapLocation mapLocation){
        mapLocation.setStartPhotoX("37.53729488297610572545");
        mapLocation.setStartPhotoY("127.00551022687500335451");
        mapLocation.setEndPhotoX("37.53800671821374");
        mapLocation.setEndPhotoY("127.00444443456463");
        modelMap.addAttribute("mapLocation",mapLocation);
        return "/record";
    }
    @RequestMapping(value = "/record",method = RequestMethod.POST)
    public void record(ModelMap modelMap ,MapLocation mapLocation){
        modelMap.addAttribute("mapLocation",mapLocation);
    }

    @RequestMapping(value="/save",method=RequestMethod.POST)
    public String save(ModelMap modelMap ,MapLocation mapLoaction){
        Iterator i = modelMap.keySet().iterator();
        MapLocation map = ((MapLocation)modelMap.get("mapLocation"));
        return "redirect:/play?mapId="+mapLocationService.save(mapLoaction);
    }
}
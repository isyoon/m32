/**
 * Created by IntelliJ IDEA.
 * User: isyoon
 * Date: 2010. 6. 11
 * Time: 오전 1:43:10
 * enjoy springsprout ! development!
 */
package springsprout.m31.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import springsprout.m31.modules.MapLocationService;

@Controller
public class SearchController {
    @Autowired
    MapLocationService searchService;
    
    @RequestMapping("/search")
    public String search(String q, ModelMap model){
        model.addAttribute("q",q);
        if(q == null || q.trim().length() == 0){
            model.addAttribute("maps","");
        }else{
            model.addAttribute("maps",searchService.findByKeyWord(q));
        }
        return "search_result";
    }

}

/**
 * Created by IntelliJ IDEA.
 * User: helols
 * Date: 2009. 12. 17
 * Time: 오후 5:56:02
 * enjoy springsprout ! development!
 */
package springsprout.m31.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import springsprout.m31.modules.gateway.support.NaverAPIHelper;

import java.util.HashMap;

import static springsprout.m31.common.M31System.JSON_VIEW;

@Controller
public class OpenApiGateWay {
    Logger log = LoggerFactory.getLogger(getClass());

    @RequestMapping("/gateway/localSearch")
    public ModelAndView localSearch(@RequestParam String q) {
        log.debug("p>>" + q);// 개발때 확인용

        HashMap<String, Object> resultMap = NaverAPIHelper.localSearch(q);
        return new ModelAndView(JSON_VIEW).addObject("localInfos", resultMap.get("localInfos")).addObject("total", resultMap.get("total"));
    }
}

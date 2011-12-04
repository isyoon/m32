/**
 * Created by IntelliJ IDEA.
 * User: helols
 * Date: 2009. 12. 21
 * Time: 오전 10:02:14
 * enjoy springsprout ! development!
 */
package springsprout.m31.modules.gateway.support;

import org.jdom.Document;
import org.jdom.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.beans.MutablePropertyValues;
import org.springframework.util.CollectionUtils;
import springsprout.m31.domain.NaverLocalInfo;
import springsprout.m31.utils.DefaultIntegerEditor;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import static springsprout.m31.utils.OpenApiRequestHelper.docElementValueToMap;
import static springsprout.m31.utils.OpenApiRequestHelper.loadXml;

public class NaverAPIHelper {
	
	private final static Logger log = LoggerFactory.getLogger(NaverAPIHelper.class);

    public static HashMap<String, Object> localSearch(String q) {
        String api_url = "http://openapi.naver.com/search?key=b020ac68a52b2089aae394e4ec7bff2d";
        try {
            api_url += "&sort=random&start=1&display=100&target=local&query="+ URLEncoder.encode(q, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        log.debug("Naver api : " + api_url);
        HashMap<String, Object> resultMap =  new HashMap<String, Object>();
        HashMap<String,Object> rMap =  docElementValueToMap(loadXml(api_url),false);
        if(rMap.get("item") == null){
            resultMap.put("total",0);
            return resultMap;
        }
        ArrayList<NaverLocalInfo> localList = new ArrayList<NaverLocalInfo>();
        for (HashMap<String, String> tmpMap : (ArrayList<HashMap<String, String>>) rMap.get("item")) {
            localList.add(
                    new NaverLocalInfo(
                              tmpMap.get("title")
                            , tmpMap.get("link")
                            , tmpMap.get("description")
                            , tmpMap.get("telephone")
                            , tmpMap.get("address")
                            , tmpMap.get("mapx")
                            , tmpMap.get("mapy"))
            );
        }
        resultMap.put("total",rMap.get("total"));
        resultMap.put("localInfos",localList);
        return resultMap;
    }
    /**
     * 네이버 API 검색 결과로부터 rss.channel 내의 item 엘리먼트들을  bean 으로 생성해서 List 로 반환한다.
     * @param document
     * @param beanClass
     * @return
     */
	@SuppressWarnings("unchecked")
	private static List convertItemElementToBeanList(Document document, Class beanClass) {
		if(document == null){
			return Collections.emptyList();
		}
		if(document.getRootElement() == null){
			return Collections.emptyList();
		}
		if(document.getRootElement().getChild("channel") != null){
			List<Element> itemList = document.getRootElement().getChild("channel").getChildren("item");
			if(!CollectionUtils.isEmpty(itemList)){
				List<Object> beanList = new ArrayList<Object>();
				for(Element item : itemList){
					Object bean = convertElementToBean(item, beanClass);
					if(bean != null) beanList.add(bean);
				}
				return beanList;
			}
		}
		return Collections.emptyList();
	}
	
	/**
	 * 해당 엘리먼트내의 값들을 bean 으로 생성해서 반환한다.
	 * @param source
	 * @param beanClass
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private static Object convertElementToBean(Element source, Class beanClass) {
		if(source == null){
			return null;
		}
		List<Element> elements = source.getChildren();
		if(!CollectionUtils.isEmpty(elements)){
			BeanWrapper beanWrapper = new BeanWrapperImpl(beanClass);
			beanWrapper.registerCustomEditor(int.class, new DefaultIntegerEditor());
			
			MutablePropertyValues propertyValues = new MutablePropertyValues();
			for(Element element : elements){
				propertyValues.add(element.getName(), element.getValue());
			}
			beanWrapper.setPropertyValues(propertyValues, true);
			return beanWrapper.getWrappedInstance();
		}
		return null;
	}    
	
}

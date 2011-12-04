package springsprout.m31.common.converter;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;
import org.springframework.core.CollectionFactory;
import org.springframework.core.convert.TypeDescriptor;
import org.springframework.core.convert.converter.ConditionalGenericConverter;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import springsprout.m31.domain.MapLocationKeyWord;
import springsprout.m31.domain.RoadView;

import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: ecwork_kwon
 * Date: 2010. 6. 11
 * Time: 오후 3:53:17
 * To change this template use File | Settings | File Templates.
 */
public class JsonStringToCollectionConverter implements ConditionalGenericConverter {

	public Set<ConvertiblePair> getConvertibleTypes() {
		return Collections.singleton(new ConvertiblePair(String.class, Collection.class));
	}

	public boolean matches(TypeDescriptor sourceType, TypeDescriptor targetType) {
		if( targetType.getElementType() == MapLocationKeyWord.class ||
            targetType.getElementType() == RoadView.class){
            return true;
        }
        return false;
	}

	@SuppressWarnings("unchecked")
	public Object convert(Object source, TypeDescriptor sourceType, TypeDescriptor targetType) {
        if(JSONUtils.mayBeJSON((String) source)){
            JSONArray jsonArray = JSONArray.fromObject(source);
            if(!CollectionUtils.isEmpty(jsonArray)){
                Class<?> beanClass = targetType.getElementType();
                Collection target = CollectionFactory.createCollection(targetType.getType(), 1);
                
                for(Object jsonObject : jsonArray){
                    target.add(
                        JSONObject.toBean((JSONObject) jsonObject, beanClass)
                    );
                }

                return target;
            }
        }
        return Collections.emptyList();
	}

}

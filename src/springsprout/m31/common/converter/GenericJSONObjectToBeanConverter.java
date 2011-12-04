package springsprout.m31.common.converter;

import net.sf.json.JSONObject;
import org.springframework.core.convert.converter.Converter;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

/**
 * Created by IntelliJ IDEA.
 * User: ecwork_kwon
 * Date: 2010. 6. 11
 * Time: 오전 10:59:08
 */
public class GenericJSONObjectToBeanConverter<T> implements Converter<JSONObject, T> {

    protected Class<T> beanClass;

    @SuppressWarnings("unchecked")
    public GenericJSONObjectToBeanConverter() {
        ParameterizedType genericSuperclass = (ParameterizedType) getClass().getGenericSuperclass();
        Type type = genericSuperclass.getActualTypeArguments()[0];
        if (type instanceof ParameterizedType) {
            this.beanClass = (Class) ((ParameterizedType) type).getRawType();
        }
        else {
            this.beanClass = (Class) type;
        }
    }

    @Override
    public T convert(JSONObject source) {
        return (T) JSONObject.toBean((JSONObject) source, beanClass);
    }
    
}
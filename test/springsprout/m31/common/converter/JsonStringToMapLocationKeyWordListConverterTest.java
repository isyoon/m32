package springsprout.m31.common.converter;

import static org.junit.Assert.*;
import static org.hamcrest.Matchers.*;

import com.sun.java.swing.plaf.windows.WindowsTreeUI;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.core.convert.ConversionService;
import org.springframework.core.convert.TypeDescriptor;
import org.springframework.core.convert.converter.Converter;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import springsprout.m31.domain.MapLocation;
import springsprout.m31.domain.MapLocationKeyWord;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ecwork_kwon
 * Date: 2010. 6. 11
 * Time: 오전 10:59:08
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"testContext.xml"})
public class JsonStringToMapLocationKeyWordListConverterTest {

    @Autowired ConversionService conversionService;

    @Test public void convert() throws NoSuchMethodException {
        String jsonData = "[{keyWord:'keyWord1'},{keyWord:'keyWord2'}]";
        List<MapLocationKeyWord> keyWords = (List<MapLocationKeyWord>) conversionService.convert(
                jsonData,
                TypeDescriptor.forObject(jsonData),
                new TypeDescriptor(new MethodParameter(MapLocation.class.getDeclaredMethod("getKeyWords"), -1)));

        assertNotNull(keyWords);
        assertThat(keyWords.size(), is(2));
        assertThat(keyWords.get(0).getKeyWord(), is("keyWord1"));
        assertThat(keyWords.get(1).getKeyWord(), is("keyWord2"));
    }

}
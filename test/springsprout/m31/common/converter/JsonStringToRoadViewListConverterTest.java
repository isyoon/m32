package springsprout.m31.common.converter;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.core.convert.ConversionService;
import org.springframework.core.convert.TypeDescriptor;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import springsprout.m31.domain.MapLocation;
import springsprout.m31.domain.RoadView;

import java.util.List;

import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;

/**
 * Created by IntelliJ IDEA.
 * User: ecwork_kwon
 * Date: 2010. 6. 11
 * Time: 오전 10:59:08
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"testContext.xml"})
public class JsonStringToRoadViewListConverterTest {

    @Autowired ConversionService conversionService;

    @Test public void convert() throws NoSuchMethodException {
        String jsonData = "[" +
                "{'addr':'본채','date':'','mapId':0,'pan':'','panoId':'','photoX':'','photoY':'','seq':0,'stName':'','stNo':'','stType':'','tilt':'','zoom':0}," +
                "{'addr':'별채','date':'','mapId':1,'pan':'','panoId':'','photoX':'','photoY':'','seq':0,'stName':'','stNo':'','stType':'','tilt':'','zoom':0}" +
                "]";
        List<RoadView> roadViews = (List<RoadView>) conversionService.convert(
                jsonData,
                TypeDescriptor.forObject(jsonData),
                new TypeDescriptor(new MethodParameter(MapLocation.class.getDeclaredMethod("getRoadViews"), -1)));

        assertNotNull(roadViews);
        assertThat(roadViews.size(), is(2));
        assertThat(roadViews.get(0).getMapId(), is(0));
        assertThat(roadViews.get(1).getMapId(), is(1));

        
    }

}
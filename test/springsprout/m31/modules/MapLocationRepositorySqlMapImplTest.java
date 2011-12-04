package springsprout.m31.modules;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;
import springsprout.m31.domain.MapLocation;
import springsprout.m31.domain.MapLocationKeyWord;
import springsprout.m31.domain.RoadView;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;

/**
 * Created by IntelliJ IDEA.
 * User: ecwork_kwon
 * Date: 2010. 6. 9
 * Time: 오후 1:47:51
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:META-INF/spring/*Context.xml"})
@TransactionConfiguration
@Transactional
public class MapLocationRepositorySqlMapImplTest {

    @Autowired MapLocationRepository repository;
    @Autowired SqlMapClientTemplate template;

    @Test public void testAll(){
        assertThat(repository.getAll().size(), is(1));
    }

    @Test public void testById(){
        MapLocation mapLocation = repository.getById(1);

        assertNotNull(mapLocation);
        assertThat(mapLocation.getId(), is(1));

        assertThat(mapLocation.getKeyWords().size(), is(2));
        assertThat(mapLocation.getKeyWords().get(0).getMapId(), is(1));

        assertThat(mapLocation.getRoadViews().size(), is(2));
        assertThat(mapLocation.getRoadViews().get(0).getMapId(), is(1));
    }

    @Test public void testByKeyWord(){
        List<MapLocation> mapLocations = repository.findByKeyWord("다음");

        assertNotNull(mapLocations);
        assertThat(mapLocations.size(), is(1));

        assertThat(mapLocations.get(0).getKeyWords().size(), is(2));
        assertThat(mapLocations.get(0).getKeyWords().get(0).getMapId(), is(1));
    }

    @Test public void save(){
        MapLocation mapLocation = new MapLocation();

        mapLocation.setTitle("MapLocationRepositorySqlMapImplTest");
        mapLocation.setStartPhotoX("0.0");
        mapLocation.setStartPhotoY("0.0");
        mapLocation.setEndPhotoX("0.0");
        mapLocation.setEndPhotoY("0.0");
        mapLocation.setAddr("MapLocationRepositorySqlMapImplTest");

        List<MapLocationKeyWord> keyWords = new ArrayList<MapLocationKeyWord>();
        keyWords.add(createKeyWord("우리집"));
        mapLocation.setKeyWords(keyWords);

        List<RoadView> roadViews = new ArrayList<RoadView>();
        roadViews.add(createRoadView("", "0626", "0.0", "0.0"));
        roadViews.add(createRoadView("", "0626", "1.0", "1.0"));
        mapLocation.setRoadViews(roadViews);

        repository.save(mapLocation);
    }

    @Test public void update(){
        MapLocation mapLocation = repository.getById(1);
        assertNotNull(mapLocation);

        repository.update(mapLocation);
    }

    private MapLocationKeyWord createKeyWord(String keyWordString){
        MapLocationKeyWord keyWord = new MapLocationKeyWord();
        keyWord.setKeyWord(keyWordString);
        return keyWord;
    }

    private RoadView createRoadView(String addr, String panoid, String x, String y){
        RoadView roadView = new RoadView();

        roadView.setPanoId(panoid);
        roadView.setPhotoX(x);
        roadView.setPhotoY(y);

        return roadView;
    }

}
package springsprout.m31.modules;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;
import springsprout.m31.domain.MapLocation;
import springsprout.m31.domain.MapLocationKeyWord;
import springsprout.m31.domain.RoadView;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ecwork_kwon
 * Date: 2010. 6. 9
 * Time: 오후 1:47:51
 */
@Repository
public class MapLocationRepositorySqlMapImpl implements MapLocationRepository  {

    @Autowired SqlMapClientTemplate template;

    @Override
    public Integer save(MapLocation mapLocation) {
        validate(mapLocation);

        Integer mapId = (Integer) template.insert("mapLocation.saveMapLocation", mapLocation);

        mapLocation.setId(mapId.intValue());

        for(MapLocationKeyWord keyWord : mapLocation.getKeyWords()){
            keyWord.setMapId(mapLocation.getId());
            template.insert("mapLocation.saveKeyWord", keyWord);
        }

        int roadViewSeq = 1;
        for(RoadView roadView : mapLocation.getRoadViews()){
            roadView.setMapId(mapLocation.getId());
            roadView.setSeq(roadViewSeq++);
            template.insert("mapLocation.saveRoadView", roadView);
        }

        return mapId;
    }

    @Override
    public void update(MapLocation mapLocation) {
        validate(mapLocation);

        template.update("mapLocation.updateMapLocation", mapLocation);

        for(MapLocationKeyWord keyWord : mapLocation.getKeyWords()){
            template.update("mapLocation.updateKeyWord", keyWord);
        }

        template.delete("mapLocation.deleteRoadViewByMapId", mapLocation.getId());

        int roadViewSeq = 1;
        for(RoadView roadView : mapLocation.getRoadViews()){
            roadView.setMapId(mapLocation.getId());
            roadView.setSeq(roadViewSeq++);
            template.insert("mapLocation.saveRoadView", roadView);
        }
    }

    @Override
    public void deleteById(int id) {
        template.delete("mapLocation.deleteMapLocationById", id);
        template.delete("mapLocation.deleteKeyWordByMapId", id);
        template.delete("mapLocation.deleteRoadViewByMapId", id);
    }

    @Override
    public List<MapLocation> getAll() {
        return template.queryForList("mapLocation.all");
    }

    @Override
    public MapLocation getById(int id) {
        return (MapLocation) template.queryForObject("mapLocation.byId", id);
    }

    @Override
    public List<MapLocation> findByKeyWord(String keyWord) {
        return template.queryForList("mapLocation.byKeyWord", keyWord);
    }

    @Override
    public List<RoadView> getRoadViewByMapId(Integer mapId) {
        System.out.println("mapIdmapIdmapId"+mapId);
        return template.queryForList("mapLocation.roadViewByMapId",mapId);
    }

    private void validate(MapLocation mapLocation){
        Assert.notNull(mapLocation, "지도 위치 정보가 없습니다.");
        //Assert.notEmpty(mapLocation.getKeyWords(), "지도 위치 키워드가 비어있습니다.");
        Assert.notEmpty(mapLocation.getRoadViews(), "로드뷰 정보가 비어있습니다.");
    }
}

package springsprout.m31.modules;

import springsprout.m31.domain.MapLocation;
import springsprout.m31.domain.RoadView;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ecwork_kwon
 * Date: 2010. 6. 9
 * Time: 오후 1:42:49
 */
public interface MapLocationRepository {

    Integer save(MapLocation mapLocation);

    void update(MapLocation mapLocation);

    void deleteById(int id);

    List<MapLocation> getAll();

    MapLocation getById(int id);

    List<MapLocation> findByKeyWord(String keyWord);

    List<RoadView> getRoadViewByMapId(Integer mapId);
}

/**
 * Created by IntelliJ IDEA.
 * User: isyoon
 * Date: 2010. 6. 11
 * Time: 오전 2:05:59
 * enjoy springsprout ! development!
 */
package springsprout.m31.modules;

import springsprout.m31.domain.MapLocation;
import springsprout.m31.domain.RoadView;

import java.util.List;

public interface MapLocationService {
    public List<MapLocation> findByKeyWord(String keyWord);
    public Integer save(MapLocation mapLocation);
    public MapLocation getById(Integer mapId);
    public List<RoadView> getRoadViewByMapId(Integer mapId);

    public void delete(Integer mapId);
}

/**
 * Created by IntelliJ IDEA.
 * User: isyoon
 * Date: 2010. 6. 11
 * Time: 오전 2:07:27
 * enjoy springsprout ! development!
 */
package springsprout.m31.modules;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import springsprout.m31.domain.MapLocation;
import springsprout.m31.domain.RoadView;

import java.util.List;

@Transactional
@Service
public class MapLocationImpl implements MapLocationService {

    @Autowired
    MapLocationRepository mapLocationRepository;

    @Override
    @Transactional(readOnly = true)
    public List<MapLocation> findByKeyWord(String keyWord) {
        return mapLocationRepository.findByKeyWord(keyWord);  
    }

    @Override
    public Integer save(MapLocation mapLocation) {
        return mapLocationRepository.save(mapLocation);
    }

    @Override
    public MapLocation getById(Integer mapId) {
        return mapLocationRepository.getById(mapId);
    }

    @Override
    public List<RoadView> getRoadViewByMapId(Integer mapId) {
        return mapLocationRepository.getRoadViewByMapId(mapId);
    }

    @Override
    public void delete(Integer mapId) {
        mapLocationRepository.deleteById(mapId);
    }
}

package springsprout.m31.domain;

/**
 * 지도 위치 검색 키워드 도메인
 * User: ecwork_kwon
 * Date: 2010. 6. 9
 * Time: 오전 9:44:36
 */
public class MapLocationKeyWord {

    private int id;

    /** MapLocation id */
    private int mapId;
    /** 키워드 */
    private String keyWord;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getMapId() {
        return mapId;
    }
    public void setMapId(int mapId) {
        this.mapId = mapId;
    }

    public String getKeyWord() {
        return keyWord;
    }
    public void setKeyWord(String keyWord) {
        this.keyWord = keyWord;
    }

    @Override
    public String toString() {
        return "MapLocationKeyWord{" +
                "id=" + id +
                ", mapId=" + mapId +
                ", keyWord='" + keyWord + '\'' +
                '}';
    }
}

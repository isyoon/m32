package springsprout.m31.domain;

import java.util.List;

/**
 * 다음 지도 위치 도메인
 * User: ecwork_kwon
 * Date: 2010. 6. 9
 * Time: 오전 9:44:13
 */
public class MapLocation {

    private int id;

    /** 제목 */
    private String title;
    /** 출발 x좌표 */
    private String startPhotoX;
    /** 출발 y좌표 */
    private String startPhotoY;
    /** 도착 x좌표 */
    private String endPhotoX;
    /** 도착 y좌표 */
    private String endPhotoY;
    /** 출발장소 */
    private String startPlace;
    /** 도착 장소*/
    private String endPlace;
    /** 도착 주소 */
    private String addr;
    /** 등록일 */
    private String regDate;
    /** 조회수 */
    private int viewCount;

    /** 키워드 목록 */
    private List<MapLocationKeyWord> keyWords;

    /** 로드뷰 목록 */
    private List<RoadView> roadViews;

    /**
     * 설명
     */
    private String description;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getStartPhotoX() {
        return startPhotoX;
    }
    public void setStartPhotoX(String startPhotoX) {
        this.startPhotoX = startPhotoX;
    }

    public String getStartPhotoY() {
        return startPhotoY;
    }
    public void setStartPhotoY(String startPhotoY) {
        this.startPhotoY = startPhotoY;
    }

    public String getEndPhotoX() {
        return endPhotoX;
    }
    public void setEndPhotoX(String endPhotoX) {
        this.endPhotoX = endPhotoX;
    }

    public String getEndPhotoY() {
        return endPhotoY;
    }
    public void setEndPhotoY(String endPhotoY) {
        this.endPhotoY = endPhotoY;
    }

    public String getAddr() {
        return addr;
    }
    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getRegDate() {
        return regDate;
    }
    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }

    public int getViewCount() {
        return viewCount;
    }
    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public List<MapLocationKeyWord> getKeyWords() {
        return keyWords;
    }
    public void setKeyWords(List<MapLocationKeyWord> keyWords) {
        this.keyWords = keyWords;
    }

    public List<RoadView> getRoadViews() {
        return roadViews;
    }
    public void setRoadViews(List<RoadView> roadViews) {
        this.roadViews = roadViews;
    }

    public boolean isNewMapLocation(){
        return getId() <= 0 ? true : false;
    }

    public String getStartPlace() {
        return startPlace;
    }

    public void setStartPlace(String startPlace) {
        this.startPlace = startPlace;
    }

    public String getEndPlace() {
        return endPlace;
    }

    public void setEndPlace(String endPlace) {
        this.endPlace = endPlace;
    }

    @Override
    public String toString() {
        return "MapLocation{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", startPhotoX='" + startPhotoX + '\'' +
                ", startPhotoY='" + startPhotoY + '\'' +
                ", endPhotoX='" + endPhotoX + '\'' +
                ", endPhotoY='" + endPhotoY + '\'' +
                ", startPlace='" + startPlace + '\'' +
                ", endPlace='" + endPlace + '\'' +
                ", addr='" + addr + '\'' +
                ", regDate='" + regDate + '\'' +
                ", viewCount=" + viewCount +
                ", keyWords=" + keyWords +
                ", roadViews=" + roadViews +
                '}';
    }
}

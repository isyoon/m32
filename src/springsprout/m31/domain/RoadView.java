package springsprout.m31.domain;

/**
 * 다음 로드뷰 도메인
 * User: ecwork_kwon
 * Date: 2010. 6. 9
 * Time: 오전 9:44:44
 */
public class RoadView {

    /** MapLocation id */
    private int mapId;
    /** 순번 */
    private int seq;
    /** x좌표 */
    private String photoX;
    /** y좌표 */
    private String photoY;
    /** 파노라마 id */
    private String panoId;
    /** 수평각도 */
    private String pan;
    /** 수직각도 */
    private String tilt;
    /** zoom 레벨 */
    private int zoom;

    public int getMapId() {
        return mapId;
    }
    public void setMapId(int mapId) {
        this.mapId = mapId;
    }

    public int getSeq() {
        return seq;
    }
    public void setSeq(int seq) {
        this.seq = seq;
    }

    public String getPhotoX() {
        return photoX;
    }
    public void setPhotoX(String photoX) {
        this.photoX = photoX;
    }

    public String getPhotoY() {
        return photoY;
    }
    public void setPhotoY(String photoY) {
        this.photoY = photoY;
    }

    public String getPanoId() {
        return panoId;
    }
    public void setPanoId(String panoId) {
        this.panoId = panoId;
    }

    public String getPan() {
        return pan;
    }
    public void setPan(String pan) {
        this.pan = pan;
    }

    public String getTilt() {
        return tilt;
    }
    public void setTilt(String tilt) {
        this.tilt = tilt;
    }

    public int getZoom() {
        return zoom;
    }
    public void setZoom(int zoom) {
        this.zoom = zoom;
    }

    @Override
    public String toString() {
        return "RoadView{" +
                "mapId=" + mapId +
                ", seq=" + seq +
                ", photoX='" + photoX + '\'' +
                ", photoY='" + photoY + '\'' +
                ", panoId='" + panoId + '\'' +
                ", pan='" + pan + '\'' +
                ", tilt='" + tilt + '\'' +
                ", zoom=" + zoom +
                '}';
    }
}

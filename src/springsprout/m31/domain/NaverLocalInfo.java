/**
 * Created by IntelliJ IDEA.
 * User: isyoon
 * Date: 2010. 6. 18
 * Time: 오후 3:50:52
 * enjoy springsprout ! development!
 */
package springsprout.m31.domain;

public class NaverLocalInfo {
    private String title;
    private String link;
    private String description;
    private String telephone;
    private String address;
    private String mapx;
    private String mapy;

    public NaverLocalInfo(String title, String link, String description, String telephone, String address, String mapx, String mapy) {
        this.title = title;
        this.link = link;
        this.description = description;
        this.telephone = telephone;
        this.address = address;
        this.mapx = mapx;
        this.mapy = mapy;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getMapx() {
        return mapx;
    }

    public void setMapx(String mapx) {
        this.mapx = mapx;
    }

    public String getMapy() {
        return mapy;
    }

    public void setMapy(String mapy) {
        this.mapy = mapy;
    }
}

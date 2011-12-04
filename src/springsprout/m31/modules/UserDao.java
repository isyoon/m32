/**
 * Created by IntelliJ IDEA.
 * User: isyoon
 * Date: 2010. 6. 17
 * Time: 오후 12:17:49
 * enjoy springsprout ! development!
 */
package springsprout.m31.modules;

import springsprout.m31.domain.User;

import java.sql.*;

public class UserDao {

    public Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (Exception ex) {
            System.out.println("드라이버가 없어용~" + ex.getMessage());
        }
        try {
            conn = DriverManager.getConnection("jdbc:mysql://dev.springsprout.org:3306/m31?useUnicode=true&characterEncoding=utf8", "m31", "13m");
        } catch (SQLException ex) {
            System.out.println("커넥션 에러~~" + ex.getMessage());
        }
        return conn;
    }

    public int add(User user) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement pstat = conn.prepareStatement("insert into user (name,password) values (?,?)");
        pstat.setString(1,user.getName());
        pstat.setString(2,user.getPassword());
        return pstat.executeUpdate();
    }

    public User get(int id) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement pstat = conn.prepareStatement("select * from user where id = ?");
        pstat.setInt(1,id);
        ResultSet rs = pstat.executeQuery();
        User user = null;
        while(rs.next()){
            user = new User(rs.getInt("id"),rs.getString("name"),rs.getString("password"));
        }
        return user;
    }

    public static void main(String[] args) throws SQLException {
        System.out.println("몇개 들어갔니? "+new UserDao().add(new User("is윤군","비밀이에요!")));
        User user = new UserDao().get(1);
        System.out.println(user.getId());        
        System.out.println(user.getName());
        System.out.println(user.getPassword());
    }
}

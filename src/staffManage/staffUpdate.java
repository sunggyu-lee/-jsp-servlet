package staffManage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class staffUpdate
 */
@WebServlet("/staffUpdate")
public class staffUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String url = null;
	  String userid = null;
	  String passwd = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public staffUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		String nick = request.getParameter("nick");
		String mobile = request.getParameter("mobile");
		String gender = request.getParameter("gender");
		String staffid = request.getParameter("staffid");
		PreparedStatement pstmt=null;
		Connection conn=null;
		try {
	         Class.forName("oracle.jdbc.OracleDriver");
	         url="jdbc:oracle:thin:@localhost:1521:orcl";
		     userid="system";
		     passwd="human123";
		     conn = DriverManager.getConnection(url,userid,passwd);
		     String sql = "update staff set staff_nick=?, staff_mobile=?, staff_gender=? where staff_id=?";
		     pstmt = conn.prepareStatement(sql);
		     pstmt.setString(1, nick);
		     pstmt.setString(2, mobile);
		     pstmt.setString(3, gender);
		     pstmt.setString(4, staffid);
		     pstmt.executeUpdate();
	      	}catch(ClassNotFoundException e){
	      		System.out.println(e.getMessage());
	      	}catch(SQLException se) {
	    	  System.out.println(se.getMessage());
	      	}finally {
	      		try {
	      			if(pstmt!=null) pstmt.close();
	      			if(conn!=null) conn.close();
	      		}catch(SQLException se) {
	      			System.out.println(se.getMessage());
	      		}
	      }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

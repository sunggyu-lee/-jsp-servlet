package staffManage;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Servlet implementation class staffSelect
 */
@WebServlet("/staffSelect")
public class staffSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 String url;
     String userid;
     String passwd; 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public staffSelect() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		url="jdbc:oracle:thin:@localhost:1521:orcl";
	    userid="system";
	    passwd="human123";
	    Connection conn=null;
	    Statement stmt=null;
	    ResultSet rs=null;
	    PrintWriter out=response.getWriter();
	    try {
	    	String sql="select * from staff";
	    	Class.forName("oracle.jdbc.driver.OracleDriver");
	    	conn = DriverManager.getConnection(url,userid,passwd);
	    	stmt=conn.createStatement();
	    	rs=stmt.executeQuery(sql);
	    	JSONArray ja = new JSONArray();
	    	while(rs.next()) {
       	 		JSONObject jo =new JSONObject();
       	 		jo.put("staffid",rs.getString("staff_id"));
       	 		jo.put("nick",rs.getString("staff_nick"));
       	 		jo.put("mobile",rs.getString("staff_mobile"));
       	 		jo.put("gender",rs.getString("staff_gender"));
       	 		ja.add(jo);
        }
        out.println(ja.toString());
        out.close();
     }catch(ClassNotFoundException e){
   	  System.out.println(e.getMessage());
     }catch(SQLException se) {
   	  System.out.println(se.getMessage());
     }finally {
   	  try {
   		  if(rs!=null) rs.close();
   		  if(stmt!=null) stmt.close();
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

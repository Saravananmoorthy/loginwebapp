<%@ page import="java.sql.*"%>
<%
    String userName = request.getParameter("userName");    
    String password = request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://192.168.56.104:3306/users?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=GMT", "root", "Admin@123");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from USER where userName='" + userName + "' and password='" +password + "'");
    if (rs.next()) 
      {
        session.setAttribute("userid", userName);
        response.sendRedirect("success.jsp");
      } 
    else {
        out.println("Invalid password <a href='index.jsp'>try again</a>");
     }
%>

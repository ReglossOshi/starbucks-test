<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="utils.DBConfig"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

//1.JSDB로 Oracle연결 ->java - DBConfig.java
	Connection conn = null; //디비 접속 성공시 접속 정보 저장
	PreparedStatement pstmt = null; //쿼리를 실행하기 객체 정보
	ResultSet rs = null;//select 결과를 저장하는 정보
	Exception exception = null;
	
	String id_equal="";
	String pw_equal="";
	
	if(id.equals("")){
		out.println("<script>location.href='login.jsp'</script>");
	} else if(pw.equals("")){
		out.println("<script>location.href='login.jsp'</script>");
	}
	
	
	try{
		conn=DBConfig.getConnection();
		
		//2. BO_FREE 테이블에서 SQL로 데이터 가져오기
		int result=0;
		String sql = "SELECT ID,PW FROM BO_FREE WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				id_equal=rs.getString(1);
				pw_equal=rs.getString(2);
			}
			
			if(id_equal.equals(id)){
				
				if(pw_equal.equals(pw)){
					out.println("<script>location.href='index.jsp?id="+id+" & pw="+pw+"'</script>");
				} else{
					out.println("<script>location.href='login.jsp'</script>");
				}
			} else{
				out.println("<script>location.href='login.jsp'</script>");
			}
		
	}catch(Exception e){
		exception=e;
		System.out.println("에러 로그:"+e.getMessage());
	} finally{
		if(pstmt !=null){try{pstmt.close();}catch(SQLException e){}}
		if(conn !=null){try{conn.close();}catch(SQLException e){}}
	}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="utils.DBConfig"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <title>스타벅스 어드민 공지사항</title>
</head>
<body>
    <!-- 1. 게시판의 화면은 class="card"로 적용 -->
    <div class="card">

        <!-- 1-1. 게시판 이름은 class="card-header"로  <div>로 구역 설정 -->
        <div class="card-header"><a href="#"><h1>스타벅스 어드민 공지사항</h1></a></div>

        <!-- 1-2. 내용은 class="card-body"로 <div>로 구역 설정 -->
        <div class="card-body">

            <!-- 검색어 입력하기 -->
            <input type="search" name="" id="" placeholder="검색어를 입력하세요."><a class="search" href="#">검색</a>
            
            <!-- 내용을 HTML로 작성하기 -->
            
            <%
        			//1.JSDB로 Oracle연결 ->java - DBConfig.java
        			Connection conn = null; //디비 접속 성공시 접속 정보 저장
					Statement stmt = null; //쿼리를 실행하기 객체 정보
					ResultSet rs = null;
					
					try{
						conn=DBConfig.getConnection();
						System.out.println("접속 성공");
						
						//2. BO_FREE 테이블에서 SQL로 데이터 가져오기
						stmt = conn.createStatement();
						String sql = "SELECT num, subject, TO_CHAR(regdate,'YYYY-MM-DD'),hit FROM BO_FREE order by num FETCH FIRST 5 ROW ONLY";
						
						//3. rs로 데이터 가져온 걸 웹에 보여주기 => 쿼리 실행 결과 출력
						rs = stmt.executeQuery(sql);
						
						//rs.last();
						//int i=rs.getRow();
						//rs.beforeFirst();

						while(rs.next()){
						
							%>
								<div class="content-box">
					                <div class="check"><input type="checkbox" name="" id=""></div>
					                <div class="title"><a href="#"><%=rs.getString(2) %></a></div>
					                <div class="delete"><button>X</button></div>
           						</div>
							<% 
						}
						
					}catch(SQLException e){
						System.out.println("에러 로그:"+e.getMessage());
					}
        		%>

            <ul class="number">
                <li><a href="#">&lt;</a></li>
                <li><a href="#" class="active">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">&gt;</a></li>
            </ul>
        </div>

        <!-- 1-3. 글쓰기 버튼은 class="btn"로 <div>로 구역 설정 -->
        <div class="btn">
            <a href="adminNoticeInsertForm.jsp">글쓰기</a>
        </div>
    </div>
</body>
</html>
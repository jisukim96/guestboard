<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--  필요한 라이브러리 등록 -->
<%@ page import = "java.sql.*,java.util.*" %>    
 
<!--  DB의 값을 select해서 값을 출력 -->
<%@ include file = "conn_mssql.jsp" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록의 내용을 DB에서 가져와서 출력하는 페이지</title>
<link href = "filegb.css" rel = "stylesheet" type = "text/css">
<style>
	div{
		/* border : 1px solid red;
		height : 300px; */
		width : 600px;
		margin : 0 auto;
	}
	table,tr,td {
		padding : 5px;
		border-collapse : collapse;
	}
</style>
</head>
<body>

<!--  DataBase에서 Select한 결과를 담는 변수 선언 : 컬렉션 방이 자동으로 늘어남 -->
<%

	//사용할 변수 선언
	String sql = null;					//SQL 쿼리를 담는 변수
	Statement stmt = null;				
		//DBMS에 sql 쿼리를 보내는 객체. Connection 객체로 생성
	ResultSet rs = null;				//select한 결과 레코드 셋을 담은 객체 | 레코드(한 줄)
	
	//sql 쿼리를 변수에 할당
	sql = "select * from guestboard order by inputdate desc";
	
	//Connection 객체를 사용해서 Statement 객체 생성
	stmt = conn.createStatement();
	
	//stmt 객체를 실행
	//rs : select한 결과 레코드를 담은 객체
	rs = stmt.executeQuery(sql);
	
	
	/* rs에 담긴 값을 루프 돌리며 출력
		rs.next() : 커서의 위치를 다음 레코드로 이동
		첫번째 레코드 -> 그 다음행 -> ... 넘어가게 하는 메소드 넘어감 = true
		레코드가 존재하면 rs.next의 값 : true , 레코드의 값이 존재하지 않으면 false */
		
	/* rs.next(); */
		
	
	if(rs.next()){			//레코드가 존재할 때 루프 돌리면서 출력
		do{
	
	%>
	
<!--  rs에 담긴 내용을 출력할 테이블 생성 
	rs.getString("컬럼명")
-->

<div>
	<table width = "600px" border = "1px">
		<tr>
			<td colspan="2" align ="center">
				<h3> <%= rs.getString("subject") %> </h3>
			</td>
			
		</tr>
		<tr>
			<td> 글쓴이 : <%= rs.getString("name") %> </td>
			<td> E-mail : <%= rs.getString("email") %></td>
		</tr>
		<tr>
			<td colspan = "2"> 글쓴 날짜 : <%= rs.getString("inputdate") %> </td>
		</tr>
		<tr>
			<td colspan = "2" width = "600px"><%= rs.getString("content") %> </td>
		</tr>
	</table>
		<p></p>
</div>	
		
<% 
		} while(rs.next());
			
		
	}else{			//레코드가 존재하지 않을 때
		out.println("방명록에 데이터가 존재하지 않습니다.");
	}
	
	%>
<div>
	<a href = "dbgb_write.html"><img src = "images/write.gif" width = "70px"></a>
</div>

</body>
</html>

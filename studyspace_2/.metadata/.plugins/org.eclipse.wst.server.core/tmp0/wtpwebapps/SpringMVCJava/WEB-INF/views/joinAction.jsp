<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID"/> <!-- index페이지에서 사용한 input 텍스트 박스의 내용을 여기로 넘겨주는것 -->
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/> 
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/> 

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID=null;
		if(session.getAttribute("userID")!=null){
			userID=(String)session.getAttribute("userID");
		}
		if(userID!=null){
			PrintWriter script = response.getWriter();
			script.println("<script>"); //jsp파일에서 html처럼 페이지를 이동시킬때 사용하는 방법
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href='mainpage'");
			script.println("</script>"); 
		}
		if(user.getUserID()==null||user.getUserPassword()==null||user.getUserName()==null||user.getUserGender()==null||
		user.getUserEmail()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>"); //jsp파일에서 html처럼 페이지를 이동시킬때 사용하는 방법
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");//이전 페이지로 돌려보내기 
			script.println("</script>"); 
		}else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if(result ==-1){//비밀번호가 맞을떄
				PrintWriter script = response.getWriter();
				script.println("<script>"); //jsp파일에서 html처럼 페이지를 이동시킬때 사용하는 방법
				script.println("alert('이미 ID가 존재합니다')");
				script.println("history.back()");//이전 페이지로 돌려보내기 
				script.println("</script>"); 
			}
			else{
				session.setAttribute("userID",user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>"); //jsp파일에서 html처럼 페이지를 이동시킬때 사용하는 방법
				script.println("location.href='mainpage'");
				script.println("</script>"); 
			}	
		}
		
	%>
</body>
</html>
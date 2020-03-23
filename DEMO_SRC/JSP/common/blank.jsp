<%
/**
 * Title       : 빈페이지에서 스크립트 호출되기
 * Description : 팝업으로 submit하기
 * File        : blank.jsp
 * Copyright   : Copyright (c) 2004 CyberImagination
 * @author     : Sang-Mi Lee
 * First Write : 
 * 
 * update date : 
 * update desc :
 */
%>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%
// -----------------------------------------------------------------------------
// argument로 들어온 데이로 들어온 스크립트 호출
// -----------------------------------------------------------------------------
    String function = request.getParameter("function");

    if( function!=null ){%>
        <script>
            try{
            <%=function+"();"%>
            }catch(e){
                alert("["+e+"] 찾을 수 없습니다.");
            }
        </script>
    <%}
%>

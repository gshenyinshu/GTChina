<%
/**
 * Title       : ������������ ��ũ��Ʈ ȣ��Ǳ�
 * Description : �˾����� submit�ϱ�
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
// argument�� ���� ���̷� ���� ��ũ��Ʈ ȣ��
// -----------------------------------------------------------------------------
    String function = request.getParameter("function");

    if( function!=null ){%>
        <script>
            try{
            <%=function+"();"%>
            }catch(e){
                alert("["+e+"] ã�� �� �����ϴ�.");
            }
        </script>
    <%}
%>

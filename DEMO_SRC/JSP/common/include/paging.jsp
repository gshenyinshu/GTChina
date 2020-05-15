<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%
    String function = request.getParameter("function") ;
	//변수 선언
	//int CONTENTS_PER_PAGE = 20;	//한 페이지에 보여줘야 하는 글 수
	int PAGE_PER_LIST = 10;		//한 리스트에 보여줘야 하는 paging 수
	
	int total = 1;						//전체 글수
	int cpage = 1;						//현재 페이지 수
	int prev = 1;						//이전 리스트
	int next = 1;						//다음 리스트
	int totalPage = 1;					//전체 페이지 수
	int start = 1;						//페이징 시작 넘버
	int end = 1;						//페이징 마지막 넘버
	int CONTENTS_PER_PAGE = 20;
	//에러 체크
	//에러가 날경우 1로 셋팅한다.
	try {
        if(request.getParameter("row")!=null)
            CONTENTS_PER_PAGE=Integer.parseInt(request.getParameter("row"));
        if(request.getParameter("list")!=null)
            PAGE_PER_LIST = Integer.parseInt(request.getParameter("list"));

        if(request.getParameter("top")!=null)
            CONTENTS_PER_PAGE = Integer.parseInt(request.getParameter("top"));

		total = Integer.parseInt( request.getParameter( "total" ) );
		cpage = Integer.parseInt( request.getParameter( "cpage" ) );
	} catch ( Exception e ) {
		total = 1;
		cpage = 1;
	}

	if( function==null || function.trim().length()==0)
        function = "goPage" ;
    function = function.trim() ;
    
	totalPage = ( ( total - 1 ) / CONTENTS_PER_PAGE ) + 1;
	start = ( ( cpage - 1 ) / PAGE_PER_LIST ) * PAGE_PER_LIST + 1;
	end = start + PAGE_PER_LIST;
	
	//이전 페이지 설정
	prev = start - PAGE_PER_LIST;
	//다음 페이지 설정
	next = start + PAGE_PER_LIST;
%>
        <table align="center" class=page>
	<tr>
		<td width="26"></td>		
		<td width="45">
<%
	//이전
	if ( prev < 0 ) {
%>
			<img src="/img/common/paging_btn_prev.gif" width="32" height="9" alt="" border="0" align="absmiddle">
<%
	} else {
%>
			<a href="javascript:<%=function%>('<%= prev %>')"><img src="/img/common/paging_btn_prev.gif" width="32" height="9" alt="" border="0" align="absmiddle"></a>
<%
	}
%>
		
		</td>
		<td style="color:#E5E5E5">
			|
<%
	for ( int i = start; i < end && totalPage >= i ; i++ ) {
		if ( cpage == i ) {
%>
			<span style="color:#3554A4"><%= i %></span> |
<%		
		} else {
%>
			<a href="javascript:<%=function%>( '<%= i %>' )"><%= i %></a> |			
<%		
		}
	}
%>
		</td>
		<td width="50" align="right">
<%
	//다음
	if ( next > totalPage ) {
%>
			<img src="/img/common/paging_btn_next.gif" width="38" height="9" alt="" border="0" align="absmiddle">
<%
	} else {
%>
			<a href="javascript:<%=function%>( '<%= next %>' )"><img src="/img/common/paging_btn_next.gif" width="38" height="9" alt="" border="0" align="absmiddle"></a>
<%
	}
%>		
		</td>
		<td width="30"></td>
	</tr>
</table>
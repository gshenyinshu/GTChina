package kr.co.openeg.lab.test.controller;

import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Scanner;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.openeg.lab.member.model.MemberModel;
import kr.co.openeg.lab.member.service.MemberService;
import kr.co.openeg.lab.test.util.DBinit;
import kr.co.openeg.lab.test.util.TestUtil;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;




@Controller
public class TestController {
	
	@Resource(name="memberService")
	private MemberService service;
	
	@RequestMapping("/test/test.do")
	public String test() {		
		
		return "/test/test";
	}
	
	@RequestMapping(value="/test/xpath_test.do", method = RequestMethod.POST)
	@ResponseBody
	public String testXpathInjection(HttpServletRequest request){
		StringBuffer buffer=new StringBuffer();
		String name=request.getParameter("name");		
		buffer.append("执行结果: ");
		TestUtil util=new TestUtil();
	    buffer.append(util.readXML(name));
        return buffer.toString();
		
	}
	
	@RequestMapping(value="/test/command_test.do", method = RequestMethod.POST)
	@ResponseBody
	public String testCommandInjection(HttpServletRequest request, HttpSession session){
		StringBuffer buffer=new StringBuffer();	
		String data=request.getParameter("data");

		
	    if ( data != null  && data.equals("type")) {
	    		data=data+" "+
	    	            request.getSession().getServletContext().getRealPath("/")+
	    	            "file1.txt"; 
	    		System.out.println(data);
	    }
    	
		Process process;
		String osName = System.getProperty("os.name");
		String[] cmd;

		if(osName.toLowerCase().startsWith("window")) {
		    cmd = new String[] { "cmd.exe","/c",data };
		    for( String s : cmd)
		       System.out.print(s+" ");
		} else {
		    cmd = new String[] { "/bin/sh",data };
		}

		try {
			process = Runtime.getRuntime().exec(cmd);
			InputStream in = process.getInputStream(); 
			Scanner s = new Scanner(in,"EUC-KR");
			buffer.append("실행결과: <br/>");
			while(s.hasNextLine() == true) {
			    buffer.append(s.nextLine()+"<br/>");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			buffer.append("실행오류발생");
			e.printStackTrace();
		} 
			return buffer.toString();

	}
	
	@RequestMapping(value="/test/encrypt_test.do", method = RequestMethod.POST)
	@ResponseBody
	public String testEncryption(HttpServletRequest request){
		StringBuffer buffer=new StringBuffer();
		String data=request.getParameter("data");
		String type=request.getParameter("type");
		switch ( TestUtil.getInt(type)  ) {
		case 0:
			buffer.append("SHA-256 테스트."); break;
		case 1:
			buffer.append("AES 암호화 테스트."); break;
		case 2:
			buffer.append("AES 복호화 테스트."); break;
		case 3:
			buffer.append("RSA 암호화 테스트."); break;
		case 4:
			buffer.append("RSA 복호화 테스트."); break;
	    default:
	    	buffer.append("잘못된 요청입니다.");
		}
		
        return buffer.toString();
		
	}
	
	@RequestMapping(value="/test/encode_test.do",method = RequestMethod.POST)
	@ResponseBody
	public String testEncoding(HttpServletRequest request) {
		StringBuffer buffer=new StringBuffer();
		String data=request.getParameter("data");
		String type=request.getParameter("type");
		switch ( TestUtil.getInt(type)  ) {
		case 0:
			buffer.append("BASE64 인코딩 테스트."); break;
		case 1:
			buffer.append("BASE64 디코딩 테스트."); break;
		case 2:
			buffer.append("URL 인코딩 테스트."); break;
		case 3:
			buffer.append("URL 디코딩 테스트."); break;
		case 4:
			buffer.append("HTML 인코딩 테스트."); break;
		case 5:
			buffer.append("HTML 디코딩 테스트."); break;
	    default:
	    	buffer.append("잘못된 요청입니다.");
		}
		return buffer.toString();
	}
	
	@RequestMapping(value="/test/reg_test.do",method = RequestMethod.POST)
	@ResponseBody
	public String testRegEx(HttpServletRequest request) {
		StringBuffer buffer=new StringBuffer();
		String data=request.getParameter("data");
		buffer.append("정규식테스트  입력값: "+data);
        return buffer.toString();		

	}
	
	@RequestMapping(value="/test/xss_test.do", method = RequestMethod.POST)
	@ResponseBody
	public String testXss(HttpServletRequest request) {
		StringBuffer buffer=new StringBuffer();
		String data=request.getParameter("data");
		buffer.append(data.replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
		//buffer.append(data);
        return buffer.toString();	
	}
	
	@RequestMapping(value="/test/xss_test_b.do", method = RequestMethod.POST)
	@ResponseBody
	public String testXssB(HttpServletRequest request) {
        HashMap<String,String> map = new HashMap<String,String>();
        map.put("1", "<script>alert('xss');</script>");
        map.put("2", "&lt;script&gt;alert('xss');&lt;/script&gt;");
		StringBuffer buffer=new StringBuffer();
		String data=request.getParameter("data");
		if ("1".equals(data)) {
			buffer.append(map.get("1"));
		}else if ( "2".equals(data)) {
			buffer.append(map.get("2"));
		} else {
			buffer.append("잘못된 요청입니다.");
		}
        return buffer.toString();	
	}
	
	@RequestMapping(value="/test/xss_test_c.do")
	public void testXssC(HttpServletRequest request, HttpServletResponse response) {
		String data=request.getParameter("data");
        try {
	         response.sendRedirect("../domxss.jsp?message="+data);
        } catch (IOException e) {
	
          System.out.println("ERROR");
        }
	}
	
	@RequestMapping(value="/test/sql_test.do", method = RequestMethod.POST)
	@ResponseBody
	public String testSqlInjection(HttpServletRequest request){
		StringBuffer buffer=new StringBuffer();
		String id=request.getParameter("id");
		String passwd=request.getParameter("passwd");
		TestUtil util=new TestUtil();
		buffer.append("ID,PASSWD 조회 결과:   " );
		buffer.append(util.readDB(id, passwd));
        return buffer.toString();
		
	}
	
	@RequestMapping(value="/test/sql_test_b.do", method = RequestMethod.GET)
	@ResponseBody
	public String testSqlInjectionB(HttpServletRequest request){
		StringBuffer buffer=new StringBuffer();
		String id=request.getParameter("id");
		TestUtil util=new TestUtil();
		buffer.append("MySQL 조회결과:    " );
		buffer.append(util.readDB2(id));
        return buffer.toString();
		
	}
	
	@RequestMapping(value="/test/sql_test_b2.do", method = RequestMethod.GET)
	@ResponseBody
	public String testSqlInjectionB2(HttpServletRequest request) throws Exception{
		StringBuffer buffer=new StringBuffer();
		String id=request.getParameter("id");
		TestUtil util=new TestUtil();
		buffer.append("MS SQL Server 조회결과:    " );
		buffer.append(util.readDB3(id));
        return buffer.toString();
		
	}
	
	@RequestMapping(value="/test/init_db.do", method = RequestMethod.GET)
	@ResponseBody
	public String initDB(HttpServletRequest request, HttpServletResponse response) throws Exception{
		StringBuffer buffer=new StringBuffer();
		String id = request.getParameter("id");
		if ( id.equals(request.getSession().getAttribute("userId")) && "admin".equals(id)) {
		     DBinit util=new DBinit();
		    // util.initMSSQLDB();
		     util.initMySQLDB();
		     buffer.append("DB 초기화 완료");
		} else {
			buffer.append("작업권한이 없습니다.");
		}
		request.getSession().invalidate();
		response.sendRedirect("/openeg/login.do");
        return buffer.toString();
		
	}
	
	@RequestMapping(value="/test/authenticator_test.do", method = RequestMethod.POST)
	@ResponseBody
	public String testAuthenticator(HttpServletRequest request, 
			HttpServletResponse response, HttpSession session){
		StringBuffer buffer=new StringBuffer();
		buffer.append("인증테스트");
        return buffer.toString();
		
	}

	@RequestMapping(value="/test/secure_cookie_test.do", method = RequestMethod.POST)
	@ResponseBody
	public String testSecureCookie(HttpServletRequest request, HttpServletResponse response) {
		StringBuffer buffer=new StringBuffer();
		String data=request.getParameter("data");
		String type=request.getParameter("type");
		switch( Integer.parseInt(type)) {
		case 0:
			Cookie c=new Cookie("openeg",data);
			c.setMaxAge(60*60*24*365);            // 쿠키 유지 기간 - 1년
			c.setPath("/"); 
			response.addCookie(c);
			buffer.append("openeg="+data +"  쿠키값 추가");
			break;
		case 1:
			Cookie[] cookies = request.getCookies();
			buffer.append("수신된 쿠키<br/>");
			for (int i = 0; i < cookies.length; i++) {
			    buffer.append(cookies[i].getName() +"=");
			    buffer.append(cookies[i].getValue() + "<br/>");
			}
			break;
		default:
			buffer.append("요청오류");
			break;
		}

        return buffer.toString();		
	}
	

	@RequestMapping(value="/test/http_split_test.do", method = RequestMethod.POST)
	@ResponseBody
	public String testHttpSplit(HttpServletRequest request, HttpServletResponse response) {
		StringBuffer buffer=new StringBuffer();
		String data=request.getParameter("data");
		System.out.println("수신된 데이터: "+data);
		response.setHeader("openeg", data);
//		Cookie cookie=new Cookie("data",data);
//		response.addCookie(cookie);
		buffer.append("HTTP 응답 분할 테스트: Cookie 값 확인");
	    return buffer.toString();
	}
	
	@RequestMapping(value="/test/int_overflow_test.do", method = RequestMethod.POST)
	@ResponseBody
	public String testIntOverflow(HttpServletRequest request, HttpServletResponse response) {
		StringBuffer buffer=new StringBuffer();
		String data=request.getParameter("data");
		System.out.println("수신데이터: "+data);
		int size=Integer.parseInt(data);
		String[] strings = new String[size+1];
        strings[0]="hello";
        buffer.append(strings[0]+"  int overflow test");    
	    return buffer.toString();
	}
	
	@RequestMapping(value="/test/forward_test.do", method = RequestMethod.POST)
	@ResponseBody
	public String testForwarding(HttpServletRequest request,HttpServletResponse response){
		String url=request.getParameter("data");
		try {
			response.sendRedirect(url);
		} catch (IOException e) {
			return "redirect 테스트 오류";
		}
		return null;
	}
	
	    
	@RequestMapping(value="/test/access_control_test.do", method = RequestMethod.POST)
	@ResponseBody
	public String testAccessControlPost(HttpServletRequest request,HttpServletResponse response,
	                                    HttpSession session){			
	 StringBuffer buffer=new StringBuffer(); 
	 MemberModel m=null;
	 String name = request.getParameter("name");
	 String action=request.getParameter("action");
	 // 사용자정보 조회 요청인 경우 DB에서 해당 사용자 정보를 조회한 결과를 응답
	 if( "view".equals(action)) {
	   if( name != null && ! "".equals(name)) {
	       m=service.findMember(name);
	       if(m==null) {
		buffer.append("등록되지 않은 사용자입니다. ");
	       } else {
	          // 조회한 사용자 정보는 세션에 저장
		session.setAttribute("member", m);
		buffer.append("조회결과 [ 사용자ID: "+m.getUserId()+"  이름: "+m.getUserName() +" ]");   
	       }
	   }else{
	       buffer.append("userId가 입력되지 않았습니다.");
	   }
	  // 사용자정보 수정 요청인 경우, 사용자정보를 먼저 조회한 뒤 수정
	 } else if( "modify".equals(action)) {
	   m=(MemberModel)session.getAttribute("member");
	   if(m==null) {
	       buffer.append("사용자정보 조회부터 실행하세요");
	   } else {
	       m.setUserName(name);
	       service.modifyMember(m);
	       session.setAttribute("member", m);
	       buffer.append("[ 사용자ID: "+m.getUserId()+"  이름: "+m.getUserName() +
	                       " ]  사용자정보 업데이트를 완료하였습니다.");   
	    }
	  // 사용자정보 삭제 요청인 경우, 사용자정보를 먼저 조회한 뒤 삭제
	 }else if ( "delete".equals(action)) {
	      m=(MemberModel)session.getAttribute("member");
	      if(m==null) {
		      buffer.append("사용자정보 조회부터 실행하세요");
	      } else {				
		service.deleteMember(m);
		session.removeAttribute("member");
		buffer.append(m.getUserId()+" 정보를 삭제하였습니다.");
	      }
	  // 사용자정보 편집 요청인 경우, 사용자정보를 DB에 추가
	 }else if ( "edit".equals(action)) {
	    if( name != null && ! "".equals(name)) {
	        m=new MemberModel(0,name,"","","","");
	        int result=service.addMember(m);
	        if ( result == 3) {
		         buffer.append(m.getUserId()+" 사용자 등록을 완료하였습니다.");   
	        } else {
		        buffer.append("사용자 등록 실패: "+result);
	        }
	    }else {
	         buffer.append("userId가 입력되지 않았습니다.");
	    }
	 }	
	 return buffer.toString();
	}

	@RequestMapping(value="/test/exception_test.do", method = RequestMethod.POST)
	@ResponseBody
	public String testException(HttpServletRequest request, HttpServletResponse response) {
		StringBuffer buffer=new StringBuffer();
		String data=request.getParameter("data");
		String type=request.getParameter("type");
		switch( Integer.parseInt(type)) {
		// 에러메시지를 통한 정보노출
		case 0:		
			int i=100/TestUtil.getInt(data);
			buffer.append("처리결과: "+i);
			break;
	    // 에러처리부재
		case 1:
			  String level="S";
			  try {
			    if ( data.equals("admin")) {
			         level="S";
			    } else {
			         level="G";
			    }
			  }catch(Exception e){}

			  if ( level.equals("S"))  {
			      buffer.append("관리자 권한으로 작업을 수행합니다"); 
			  } else {
			      buffer.append("일반사용자 권한으로 작업을 수행합니다"); 
			  }
			  break;
        //부적절한 예외처리
		case 2:	
			char[] cbuf=new char[512];
			try {
			    FileReader fr=new FileReader(data);
			    fr.read(cbuf);
			}catch(Exception e){
				buffer.append("에러발생으로 요청을 처리할 수 없습니다. ");
			}			
			break;
		default:
			buffer.append("요청오류");
			break;
		}

        return buffer.toString();		
	}	


}

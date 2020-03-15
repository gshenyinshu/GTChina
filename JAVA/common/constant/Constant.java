/**
 * Title       : 전체 상수
 * Description : 말이 필요없음.
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author Dong-hyun Sohn
 * @version 1.0
 */

package gtone.changeminer.common.constant;

public class Constant
{


	//회원정보 session key
	 
	public static final String SESSION_LOGINMODE  = "session.LoingMode";
	public static final String SESSION_LEVEL  = "session.UserLevel";
	public static final String SESSION_USERID	= "session.UserID";	
	public static final String SESSION_USERNAME	= "session.UserName";	
	public static final String SESSION_SSN		= "session.SSN";	
	public static final String SESSION_GENDER   = "session.UserGender";	
	public static final String SESSION_EMAIL     = "session.UserEmail";	
	public static final String SESSION_HOMEPHONE = "session.UserHomePhone";
	public static final String SESSION_MOBILEPHONE  = "session.UserMobilePhone";
	public static final String SESSION_COMPANYPHONE  = "session.UserCompanyPhone";
	public static final String SESSION_PUBLIC_LOGIN  = "session.UserPublicLoginMode";
	public static final String SESSION_PUBLIC_LOGIN_DATE  = "session.PublicLoginDate";

	public static final String SESSION_PUBLIC_LOGIN_PROCESS  = "session.UserPublicLoginpProcess";

	public static final String SESSION_AUTHORITY  = "session.Authority";	//	권한

	public static final String SESSION_MYLP  = "session.MyLp";


	public static final String YES_VALUE  = "Y";
	public static final String NO_VALUE  = "N";
	public static final String PUBLIC_LOGIN_VALUE  = "public";
	public static final String PWD_LOGIN_VALUE  = "pwd";
	
	public static final String SESSION_ERR_MSG  = "session.ErrMsg";


	//	고급자용에서는 지정된 templateId를 사용한다.
	public static final String TYPE_HTML_TEMPLATEID = "temp101";

	//	데이타구분자
	public static final String DELIM_MENU = String.valueOf((char)2);

	//	발송고객리스트에서 항목간 구분자
	public static final String DELIM_COL = String.valueOf((char)2);
	//	발송고객리스트에서 고객간 구분자
	public static final String DELIM_ROW = String.valueOf((char)4);

	//	게시판 류의 리스트에서 아래 페이지 목록표시
	public static final int PAGE_LIMIT = 10;

	//	게시판 류의 리스트에서 게시물출력갯수
	public static final int LIST_DISPLAYCOUNT = 10;




	//MyPage LoveLette List Display 갯수
	public static final int MYPAGE_LOVE_LETTER_LIST_PAGE_COUNT = 5;


	//	ServerName & ServerPort
	public static String SERVER_NAME = "";
	public static String SERVER_PORT = "";
	public static String PRUHOME_XML = "";
	
	public static void setVariablePath(String _pruhome_xml)
	{
		PRUHOME_XML = _pruhome_xml;
	}
}


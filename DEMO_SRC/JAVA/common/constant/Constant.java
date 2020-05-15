/**
 * Title       : ��ü ���
 * Description : ���� �ʿ����.
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author Dong-hyun Sohn
 * @version 1.0
 */

package gtone.changeminer.common.constant;

public class Constant
{


	//ȸ������ session key
	 
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

	public static final String SESSION_AUTHORITY  = "session.Authority";	//	����

	public static final String SESSION_MYLP  = "session.MyLp";


	public static final String YES_VALUE  = "Y";
	public static final String NO_VALUE  = "N";
	public static final String PUBLIC_LOGIN_VALUE  = "public";
	public static final String PWD_LOGIN_VALUE  = "pwd";
	
	public static final String SESSION_ERR_MSG  = "session.ErrMsg";


	//	����ڿ뿡���� ������ templateId�� ����Ѵ�.
	public static final String TYPE_HTML_TEMPLATEID = "temp101";

	//	����Ÿ������
	public static final String DELIM_MENU = String.valueOf((char)2);

	//	�߼۰�����Ʈ���� �׸� ������
	public static final String DELIM_COL = String.valueOf((char)2);
	//	�߼۰�����Ʈ���� ���� ������
	public static final String DELIM_ROW = String.valueOf((char)4);

	//	�Խ��� ���� ����Ʈ���� �Ʒ� ������ ���ǥ��
	public static final int PAGE_LIMIT = 10;

	//	�Խ��� ���� ����Ʈ���� �Խù���°���
	public static final int LIST_DISPLAYCOUNT = 10;




	//MyPage LoveLette List Display ����
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


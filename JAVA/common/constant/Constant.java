/**
 * Title       : �3�7�4�7 �1�8�2�1
 * Description : �0�1�3�3 �6�9�3�9�2�3�3�3.
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author Dong-hyun Sohn
 * @version 1.0
 */

package gtone.changeminer.common.constant;

public class Constant
{


	//�6�7�3�9�3�4�1�5 session key
	 
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

	public static final String SESSION_AUTHORITY  = "session.Authority";	//	�7�1�6�3

	public static final String SESSION_MYLP  = "session.MyLp";


	public static final String YES_VALUE  = "Y";
	public static final String NO_VALUE  = "N";
	public static final String PUBLIC_LOGIN_VALUE  = "public";
	public static final String PWD_LOGIN_VALUE  = "pwd";
	
	public static final String SESSION_ERR_MSG  = "session.ErrMsg";


	//	�7�9�8�6�3�1�3�0�2�3�1�9�8�9 �3�1�3�4�9�1 templateId�0�7 �1�7�3�0�6�3�9�9.
	public static final String TYPE_HTML_TEMPLATEID = "temp101";

	//	�9�9�3�3�5�3�7�9�1�9�3�1
	public static final String DELIM_MENU = String.valueOf((char)2);

	//	�0�9�2�2�7�9�7�4�0�5�2�1�5�7�2�3�1�9 �6�0�0�8�7�9 �7�9�1�9�3�1
	public static final String DELIM_COL = String.valueOf((char)2);
	//	�0�9�2�2�7�9�7�4�0�5�2�1�5�7�2�3�1�9 �7�9�7�4�7�9 �7�9�1�9�3�1
	public static final String DELIM_ROW = String.valueOf((char)4);

	//	�7�5�2�7�5�5 �0�1�3�5 �0�5�2�1�5�7�2�3�1�9 �2�3�9�3 �5�1�3�3�3�1 �0�8�0�0�5�7�2�7
	public static final int PAGE_LIMIT = 10;

	//	�7�5�2�7�5�5 �0�1�3�5 �0�5�2�1�5�7�2�3�1�9 �7�5�2�7�0�5�4�9�0�4�7�2�2�1
	public static final int LIST_DISPLAYCOUNT = 10;




	//MyPage LoveLette List Display �7�2�2�1
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


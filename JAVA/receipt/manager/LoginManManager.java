/**
 * Title       	: LoginManManager.java
 * Description 	: �6�9�5�1�3�3�3�1 �1�7�3�3�0�3 �1�1�5�5 �0�9�8�9�3�7 �1�8�5�1 �1�3�7�4 
 * Company     : gtone
 * @author 	: Kim Bo Young
 * @version 1.0
 */
package gtone.changeminer.receipt.manager;

import java.util.List;

import gtone.changeminer.receipt.dao.LoginManDao;

import anyframe.data.DataSet;


public  class LoginManManager{
	private LoginManManager(){
	}

	private static LoginManManager instance = null;

	public static LoginManManager getInstance(){
		if( instance == null )
			instance = new LoginManManager();

		return instance; 
	}

	public static LoginManManager getInstance(boolean newInstance){
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////save login status 
	public void changeLoginSts(DataSet input)  throws Exception{
		try{
			
			LoginManDao dao = getLoginManDao();
			dao.changeLoginSts(input);
			
		}catch(Exception e){
			throw (e);	
		}
	}
	
	////get login status
	public DataSet getLoginSts(DataSet input)  throws Exception{
		try
		{
			DataSet output = new DataSet();
			LoginManDao dao = getLoginManDao();
			output = dao.getLoginSts(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}		
	}
	
	private LoginManDao getLoginManDao()
	{
		return new LoginManDao();
	}

}


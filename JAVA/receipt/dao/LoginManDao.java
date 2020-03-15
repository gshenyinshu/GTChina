/**
 * Title       	: LoginManDao.java
 * Description 	: �6�9�5�1�3�3�3�1 �1�7�3�3�0�3 �1�1�5�5 �0�9�8�9�3�7 �1�8�5�1 �1�3�7�4 
 * Company     : gtone
 * @author 	: Kim Bo Young
 * @version 1.0
 */
package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class LoginManDao{
	
	////save login status 
	public void changeLoginSts(DataSet input) throws Exception{
		try{
			
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("changeLoginSts ----  input : "+input);	
			executor.execute("/changeminer/save_login_sts", input);		
			
		}catch(Exception e){
			throw(e);	
		}
	}

	////get login status
	public DataSet getLoginSts(DataSet input) throws Exception{
		try{
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("getLoginSts ----  input : "+input);
			DataSet output = executor.execute("/changeminer/get_login_sts", input);
			////anyframe.log.Logger.debug.println("getLoginSts ----  output : "+output);				
			return output;
			
		}catch(Exception e){
			throw(e);	
		}
	}	

}
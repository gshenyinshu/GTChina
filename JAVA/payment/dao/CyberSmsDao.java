/**
 * Title       	: CyberSmsDao
 * Description 	: SMS�1�5�8�9�8�5
 * Copyright   	: Copyright (c) 2004
 * Company     : CyberImagination
 * @author 	Park,JH
 * @version 1.0
 */

package gtone.changeminer.payment.dao;

import anyframe.data.*;
import anyframe.log.*;
import gtone.changeminer.common.dao.Executor;

public  class CyberSmsDao
{
	////SMS�1�5�8�9�8�5
	public DataSet findSms(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS �3�3�3�2(DAO) INPUT-----------------: "+input);						
			DataSet output = executor.execute("/changeminer/usp_sms_ins", input);
			anyframe.log.Logger.debug.println("SMS �3�3�3�2(DAO) OUTPUT-----------------: "+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}

	
	////SMS�1�5�8�9�8�5 - �7�9�7�4�3�4�1�5�1�3�7�4,�3�1�9�4�3�3�4�7�6�7�3�1,�8�9�0�6�1�9�0�6
	public DataSet findClientSms(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS �3�3�3�2(DAO) INPUT-----------------: "+input);						
			DataSet output = executor.execute("/changeminer/usp_client_sms_ins", input);
			anyframe.log.Logger.debug.println("SMS �3�3�3�2(DAO) OUTPUT-----------------: "+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}

	////SMS�1�5�8�9�8�5 - �5�8�1�7�6�3 �7�1�4�2�2�3�3�3 �1�5�8�7�9�5 �1�7�3�0
	public void sendSimpleSms(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS �0�9�2�2(DAO) INPUT-----------------: "+input);						
			DataSet output = executor.execute("/changeminer/sms_simple_send", input);
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	
}


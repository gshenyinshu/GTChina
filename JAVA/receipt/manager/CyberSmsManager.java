/**
 * Title       	: CyberSmsManager
 * Description 	: SMS�1�5�8�9�8�5
 * Copyright   	: Copyright (c) 2004
 * Company     : CyberImagination
 * @author 	Park,JH
 * @version 1.0
 */

package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.CyberSmsDao;

public  class CyberSmsManager
{
	private CyberSmsManager()
	{}

	private static CyberSmsManager instance = null;

	public static CyberSmsManager getInstance()
	{
		if( instance == null )
			instance = new CyberSmsManager();

		return instance; 
	}


	public static CyberSmsManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}


	////SMS�1�5�8�9�8�5
	public DataSet findSms(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberSmsDao dao = getCyberSmsDao();
			output = dao.findSms(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////SMS�1�5�8�9�8�5 - �7�9�7�4�3�4�1�5�1�3�7�4�2�3�1�9 �1�7�3�0
	public DataSet findClientSms(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberSmsDao dao = getCyberSmsDao();
			output = dao.findClientSms(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////LP, SM�4�2�3�7�3�9
	public DataSet findLpSmtot(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberSmsDao dao = getCyberSmsDao();
			output = dao.findLpSmtot(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	
	////�7�9�7�4 �6�1�9�3�5�9 �0�7�6�3
	public DataSet findCusttel(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberSmsDao dao = getCyberSmsDao();
			output = dao.findCusttel(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
		
	////SMS�1�5�8�9�8�5 - �5�8�1�7�6�3 �7�1�4�2�2�3�3�3 �1�5�8�7�9�5 �1�7�3�0
	public void sendSimpleSms(DataSet input) throws Exception {
		try
		{
			DataSet output = null;
			CyberSmsDao dao = getCyberSmsDao();
			dao.sendSimpleSms(input);
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
		
	}

	
	private CyberSmsDao getCyberSmsDao()
	{
		return new CyberSmsDao();
	}


}
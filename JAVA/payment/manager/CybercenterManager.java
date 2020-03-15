/**
 * Title       	: CybercenterManager
 * Description 	: �2�0�7�1�9�7�4�9�3�1�9�4�8�9�2�2
 * Copyright   	: Copyright (c) 2004
 * Company     : CyberImagination
 * @author 	Son,HoJun
 * @version 1.0
 */

package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.CybercenterDao;

public  class CybercenterManager
{
	private CybercenterManager()
	{}

	private static CybercenterManager instance = null;

	public static CybercenterManager getInstance()
	{
		if( instance == null )
			instance = new CybercenterManager();

		return instance; 
	}


	public static CybercenterManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}


	////C-W
	public DataSet findKsps2000(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.findKsps2000(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	

	////WebDB Process�2�3�1�9 �2�2�3�7 �4�9�0�5�1�8�5�1 �3�5�6�7 : 80�3�3 �3�3�8�9�3�1 �6�2�3�7
	////2006-09-07:�8�1�1�5�2�2:0601914:�2�2�3�7 �2�7�2�3 WEBDB�2�3�1�9 �3�3�0�3 �2�2�3�7 �9�1 �7�1�3�3 �2�3�8�9�3�1 �4�7�5�9�6�9�8�9 �1�5�1�9 �4�1�7�5
	public DataSet findAppvProcessStatus(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.findAppvProcessStatus(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	

	////WebDB Payment�2�3�1�9 �2�2�3�7 �4�9�0�5�1�8�5�1 �3�5�6�7 
	////2006-09-07:�8�1�1�5�2�2:0601914:�2�2�3�7 �2�7�2�3 WEBDB�2�3�1�9 �3�3�0�3 �2�2�3�7 �9�1 �7�1�3�3 �2�3�8�9�3�1 �4�7�5�9�6�9�8�9 �1�5�1�9 �4�1�7�5
	public DataSet findAppvPaymentStatus(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.findAppvPaymentStatus(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	

	////�3�7�2�2�0�7�6�3 �3�3�3�2
	public DataSet Sendingsave(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.Sendingsave(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////�3�7�2�2�0�7�6�3 �3�3�3�2
	public DataSet findSend(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.findSend(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////KSPS0450
	public DataSet findIsaogong(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.findIsaogong(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////WB_PAYMENT�2�3�1�9 �3�0�2�1�0�7�6�3�0�9 �6�3 ROW �7�3�1�6
	public DataSet findRecei(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.findRecei(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	////�2�5�3�1�8�6�8�5�3�3�3�2
	public DataSet Realpaysave(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.Realpaysave(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////�3�0�2�3�1�9 �2�1�4�0�6�3 �7�9�7�4�3�5 �9�0�3�1 �2�0�9�7 �3�1�8�6�2�2�3�3 �2�3�0�3�3�7�3�1 �6�2�3�7
	public DataSet getProcamtInfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.getProcamtInfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	private CybercenterDao getCybercenterDao()
	{
		return new CybercenterDao();
	}
}


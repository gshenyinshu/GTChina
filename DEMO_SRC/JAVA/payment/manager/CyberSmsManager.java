/**
 * Title       	: CyberSmsManager
 * Description 	: SMS������
 * Copyright   	: Copyright (c) 2004
 * Company     : CyberImagination
 * @author 	Park,JH
 * @version 1.0
 */

package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.CyberSmsDao;

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


	////SMS������
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


	////SMS������ - ���������濡�� ���
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

	////SMS������ - Ư���� �������� ������ ���
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
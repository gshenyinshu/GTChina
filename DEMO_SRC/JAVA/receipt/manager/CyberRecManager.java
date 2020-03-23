/**
 * Title       	: CyberRecManager
 * Description 	: ��������
 * Copyright   	: Copyright (c) 2004
 * Company     : CyberImagination
 * @author 	Son,HoJun
 * @version 1.0
 */

package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.CyberRecDao;

public  class CyberRecManager
{
	private CyberRecManager()
	{}

	private static CyberRecManager instance = null;

	public static CyberRecManager getInstance()
	{
		if( instance == null )
			instance = new CyberRecManager();

		return instance; 
	}


	public static CyberRecManager getInstance(boolean newInstance)
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
			CyberRecDao dao = getCyberRecDao();
				
			output = dao.findKsps2000(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////���۹�ȣ ����
	public DataSet Sendingsave(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberRecDao dao = getCyberRecDao();
				
			output = dao.Sendingsave(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////���۹�ȣ ����
	public DataSet findSend(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberRecDao dao = getCyberRecDao();
				
			output = dao.findSend(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////�ڵ���ü
	public DataSet findIsaogong(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberRecDao dao = getCyberRecDao();
				
			output = dao.findIsaogong(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////������Ȯ��
	public DataSet confBank(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberRecDao dao = getCyberRecDao();
			output = dao.confBank(input);
			
			return output;
		}		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////WB_PROCESS���� ���°� �˻�
	public DataSet findProcstatus(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberRecDao dao = getCyberRecDao();
			output = dao.findProcstatus(input);
			
			return output;
		}		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	private CyberRecDao getCyberRecDao()
	{
		return new CyberRecDao();
	}
}


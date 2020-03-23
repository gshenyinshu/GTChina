/**
 * Title       	: CybercenterManager
 * Description 	: ��������ڵ�����
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
	

	////WebDB Process���� ���� ó������ ��ȸ : 80�� �ִ��� Ȯ��
	////2006-09-07:�躸��:0601914:���� �ÿ� WEBDB���� �̹� ���� �� ���� ������ üũ�ϴ� �κ� �߰�
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
	

	////WebDB Payment���� ���� ó������ ��ȸ 
	////2006-09-07:�躸��:0601914:���� �ÿ� WEBDB���� �̹� ���� �� ���� ������ üũ�ϴ� �κ� �߰�
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
	

	////���۹�ȣ ����
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

	////���۹�ȣ ����
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

	////WB_PAYMENT���� ������ȣ�� �� ROW �˻�
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
	
	////�����ޱ�����
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

	////������ ��û�� ���� ���� ��� ���޾��� ������ Ȯ��
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


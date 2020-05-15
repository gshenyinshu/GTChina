package gtone.changeminer.receipt.dao;

import anyframe.data.*;
import anyframe.db.*;

import gtone.changeminer.common.dao.Executor;

public  class CyberRecDao
{
	/////////C-W
	public DataSet findKsps2000(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();	
			anyframe.log.Logger.debug.println("KSPS2000 input===========>"+input);				
			DataSet output = executor.execute("/changeminer/ksps2000", input);
			anyframe.log.Logger.debug.println("KSPS2000 output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}

	////���۹�ȣ ����
	public DataSet Sendingsave(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("���۹�ȣ ���� input===========>"+input);
			DataSet output = executor.execute("/changeminer/usp_wb_sending_update", input);
			anyframe.log.Logger.debug.println("���۹�ȣ ���� output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}

	////���۹�ȣ �˻�
	public DataSet findSend(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("���۹�ȣ �˻� input===========>"+input);
			DataSet output = executor.execute("/changeminer/wb_payment_sending", input);
			anyframe.log.Logger.debug.println("���۹�ȣ �˻� output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}
	
	////�ڵ���ü�˻�
	public DataSet findIsaogong(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�ڵ���ü �˻� input===========>"+input);			
			DataSet output = executor.execute("/changeminer/ksps0450", input);			
			anyframe.log.Logger.debug.println("�ڵ���ü �˻� output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////������Ȯ��
	public DataSet confBank(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			DataSet output1  = new DataSet();			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("������ Ȯ�� input===========>"+input);			
			DataSet output = executor.execute("/changeminer/ksps0340", input);
			anyframe.log.Logger.debug.println("������ Ȯ�� output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}
	
	////WB_PAYMENT���� PROC_STATUS�˻�
	public DataSet findProcstatus(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("WB_PROCESS���� ���°�  input===========>"+input);			
			DataSet output = executor.execute("/changeminer/findProcval", input);
			anyframe.log.Logger.debug.println("WB_PROCESS���� ���°�  output===========>"+output);			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}			
}
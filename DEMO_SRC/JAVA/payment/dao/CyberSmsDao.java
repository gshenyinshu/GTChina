/**
 * Title       	: CyberSmsDao
 * Description 	: SMS������
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
	////SMS������
	public DataSet findSms(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS ����(DAO) INPUT-----------------: "+input);						
			DataSet output = executor.execute("/changeminer/usp_sms_ins", input);
			anyframe.log.Logger.debug.println("SMS ����(DAO) OUTPUT-----------------: "+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}

	
	////SMS������ - ����������,�ڵ���ü����,�׷����
	public DataSet findClientSms(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS ����(DAO) INPUT-----------------: "+input);						
			DataSet output = executor.execute("/changeminer/usp_client_sms_ins", input);
			anyframe.log.Logger.debug.println("SMS ����(DAO) OUTPUT-----------------: "+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}

	////SMS������ - Ư���� �������� ������ ���
	public void sendSimpleSms(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS �߼�(DAO) INPUT-----------------: "+input);						
			DataSet output = executor.execute("/changeminer/sms_simple_send", input);
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	
}


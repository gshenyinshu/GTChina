/**
 * Title       	: CyberSmsDao
 * Description 	: SMS������
 * Copyright   	: Copyright (c) 2004
 * Company     : CyberImagination
 * @author 	Park,JH
 * @version 1.0
 */

package gtone.changeminer.receipt.dao;

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
			anyframe.log.Logger.debug.println("SMS ����(DAO)  C INPUT-----------------: "+input);						
			DataSet output = executor.execute("/changeminer/usp_client_sms_ins", input);
			anyframe.log.Logger.debug.println("SMS ����(DAO) C OUTPUT-----------------: "+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}


	////SMS������ - ���� �ڵ��� ��ȣ
	public DataSet findCusttel(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/ksps0930", input);
			anyframe.log.Logger.debug.println("���� �ڵ��� ��ȣ OUTPUT-----------------: "+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
	
   ////LP,SM  ���ο�
   public DataSet findLpSmtot(DataSet input) throws Exception
    {
        try
        {	  
        	DataSet input1 = new DataSet();	
        	
            Executor executor = null;
            executor = Executor.getInstance();
	     anyframe.log.Logger.debug.println("LP,SM���ο�  input  : "+input );			            
	     DataSet output = executor.execute("/changeminer/my_lifeplanner_list", input);
	     anyframe.log.Logger.debug.println("LP,SM���ο�   output  : "+output );						
	     
	     int cnt = output.getCount("lpcode");
	     if(cnt > 0)	     
	     {
	     		for(int i=0;i<cnt;i++)
	     		{
	     			String lpcode = output.getText("lpcode",i);
	     			input1.put("lpcode", lpcode);
	     			InteractionBean interact1 = new InteractionBean();
	     			DataSet output1 = interact1.execute("/changeminer/lpsm_info_search", input1);		
				output.put("sm_code", output1.getText("sm_code"), i);	
				output.put("sm_name", output1.getText("sm_name"), i);	
				output.put("sm_mail", output1.getText("sm_email"), i);	
	     		}
	     }
	     
	     return output;
        }
        catch(Exception e)
        {
            throw e;
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


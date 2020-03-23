/**
 * Title       	: CyberSmsDao
 * Description 	: SMS보내기
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
	////SMS보내기
	public DataSet findSms(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS 저장(DAO) INPUT-----------------: "+input);						
			DataSet output = executor.execute("/changeminer/usp_sms_ins", input);
			anyframe.log.Logger.debug.println("SMS 저장(DAO) OUTPUT-----------------: "+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}

	
	////SMS보내기 - 고객정보변경,자동이체해지,그룹빌링
	public DataSet findClientSms(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS 저장(DAO)  C INPUT-----------------: "+input);						
			DataSet output = executor.execute("/changeminer/usp_client_sms_ins", input);
			anyframe.log.Logger.debug.println("SMS 저장(DAO) C OUTPUT-----------------: "+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}


	////SMS보내기 - 고객의 핸드폰 번호
	public DataSet findCusttel(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/ksps0930", input);
			anyframe.log.Logger.debug.println("고객의 핸드폰 번호 OUTPUT-----------------: "+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
	
   ////LP,SM  총인원
   public DataSet findLpSmtot(DataSet input) throws Exception
    {
        try
        {	  
        	DataSet input1 = new DataSet();	
        	
            Executor executor = null;
            executor = Executor.getInstance();
	     anyframe.log.Logger.debug.println("LP,SM총인원  input  : "+input );			            
	     DataSet output = executor.execute("/changeminer/my_lifeplanner_list", input);
	     anyframe.log.Logger.debug.println("LP,SM총인원   output  : "+output );						
	     
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
   
	////SMS보내기 - 특별한 계층없이 보낼때 사용
	public void sendSimpleSms(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS 발송(DAO) INPUT-----------------: "+input);						
			DataSet output = executor.execute("/changeminer/sms_simple_send", input);
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
}


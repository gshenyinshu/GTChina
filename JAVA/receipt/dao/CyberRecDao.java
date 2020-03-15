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

	////전송번호 저장
	public DataSet Sendingsave(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("전송번호 저장 input===========>"+input);
			DataSet output = executor.execute("/changeminer/usp_wb_sending_update", input);
			anyframe.log.Logger.debug.println("전송번호 저장 output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}

	////전송번호 검색
	public DataSet findSend(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("전송번호 검색 input===========>"+input);
			DataSet output = executor.execute("/changeminer/wb_payment_sending", input);
			anyframe.log.Logger.debug.println("전송번호 검색 output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}
	
	////자동이체검색
	public DataSet findIsaogong(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("자동이체 검색 input===========>"+input);			
			DataSet output = executor.execute("/changeminer/ksps0450", input);			
			anyframe.log.Logger.debug.println("자동이체 검색 output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////예금주확인
	public DataSet confBank(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			DataSet output1  = new DataSet();			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("예금주 확인 input===========>"+input);			
			DataSet output = executor.execute("/changeminer/ksps0340", input);
			anyframe.log.Logger.debug.println("예금주 확인 output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}
	
	////WB_PAYMENT에서 PROC_STATUS검색
	public DataSet findProcstatus(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("WB_PROCESS에서 상태값  input===========>"+input);			
			DataSet output = executor.execute("/changeminer/findProcval", input);
			anyframe.log.Logger.debug.println("WB_PROCESS에서 상태값  output===========>"+output);			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}			
}

package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class ReturnDao
{
	
	////반송내역 display
	public DataSet findReturn(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("반송내역 display ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_reason", input);
			anyframe.log.Logger.debug.println("반송내역 display ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////반송내역 저장
	public DataSet findRtnsave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("반송내역 WB_PROCESS 저장 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_return_update", input);
			anyframe.log.Logger.debug.println("반송내역 WB_PROCESS 저장 ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////반송내역 저장1
	public DataSet findRtnsave1(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("반송내역 저장 WB_PAYMENT----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_return_update1", input);
			anyframe.log.Logger.debug.println("반송내역 저장 WB_PAYMENT----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////상태변경한 상태값 저장
	public DataSet findchgSave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("상태변경한 값 저장 WB_PROCESS 저장 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_chg_status", input);
			anyframe.log.Logger.debug.println("상태변경한 값 저장 WB_PROCESS 저장 ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////WB_PAYMENT에서 RSLT, ERR_MSG READ
	public DataSet findRsltread(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/wb_rslt_read", input);
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}						
	
	////업무분류코드 검색
	public DataSet findSrvc_cd(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("업무분류코드 검색 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/find_srvcode", input);
			anyframe.log.Logger.debug.println("업무분류코드 검색 ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////반송메일을 보내기위한 검색값들 search
	public DataSet findReturnview(DataSet input) throws Exception
	{		
		try
		{
			DataSet input1 = new DataSet();	  
			DataSet input2 = new DataSet();
			
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("반송메일 검색 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/user_return_mail", input);
						
			
			int cnt = output.getCount("policy_no");
			for(int i=0;i<cnt;i++)
			{
				String policy = "";
				policy = output.getText("policy_no");
				
				input1.put("deptcd", "INT");
				input1.put("init", "CYBER");
				input1.put("plyno", policy);
				
				InteractionBean interact1 = new InteractionBean();
				DataSet output1 = interact1.execute("/changeminer/coveragenormal", input1);			     					
				
				output.put("plan_nm", output1.getText("plnname"), 0);				
				
				String lpcode = "";
				lpcode = output.getText("lp_id");	
				input2.put("lpcode", lpcode);
				
				InteractionBean interact2 = new InteractionBean();
				DataSet output2 = interact2.execute("/changeminer/lpsm_info_search", input2);			     					
				
				output.put("sm_code", output2.getText("sm_code"),0);
				output.put("sm_name", output2.getText("sm_name"),0);
				output.put("sm_email", output2.getText("sm_email"),0);
				
				
			}
			anyframe.log.Logger.debug.println("반송메일 검색----  output : "+output);	
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}								
}
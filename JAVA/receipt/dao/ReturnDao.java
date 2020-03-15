
package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class ReturnDao
{
	
	////�0�5�2�2�8�9�2�2 display
	public DataSet findReturn(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�5�2�2�8�9�2�2 display ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_reason", input);
			anyframe.log.Logger.debug.println("�0�5�2�2�8�9�2�2 display ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////�0�5�2�2�8�9�2�2 �3�3�3�2
	public DataSet findRtnsave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�5�2�2�8�9�2�2 WB_PROCESS �3�3�3�2 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_return_update", input);
			anyframe.log.Logger.debug.println("�0�5�2�2�8�9�2�2 WB_PROCESS �3�3�3�2 ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////�0�5�2�2�8�9�2�2 �3�3�3�21
	public DataSet findRtnsave1(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�5�2�2�8�9�2�2 �3�3�3�2 WB_PAYMENT----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_return_update1", input);
			anyframe.log.Logger.debug.println("�0�5�2�2�8�9�2�2 �3�3�3�2 WB_PAYMENT----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////�1�8�5�1�1�3�7�4�6�3 �1�8�5�1�7�3 �3�3�3�2
	public DataSet findchgSave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�1�8�5�1�1�3�7�4�6�3 �7�3 �3�3�3�2 WB_PROCESS �3�3�3�2 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_chg_status", input);
			anyframe.log.Logger.debug.println("�1�8�5�1�1�3�7�4�6�3 �7�3 �3�3�3�2 WB_PROCESS �3�3�3�2 ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////WB_PAYMENT�2�3�1�9 RSLT, ERR_MSG READ
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
	
	////�2�2�0�7�1�9�0�1�4�9�9�3 �7�3�1�6
	public DataSet findSrvc_cd(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�2�2�0�7�1�9�0�1�4�9�9�3 �7�3�1�6 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/find_srvcode", input);
			anyframe.log.Logger.debug.println("�2�2�0�7�1�9�0�1�4�9�9�3 �7�3�1�6 ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////�0�5�2�2�0�3�3�1�3�5 �1�5�8�9�8�5�3�1�6�3 �7�3�1�6�7�3�9�1 search
	public DataSet findReturnview(DataSet input) throws Exception
	{		
		try
		{
			DataSet input1 = new DataSet();	  
			DataSet input2 = new DataSet();
			
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�5�2�2�0�3�3�1 �7�3�1�6 ----  input : "+input);				
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
			anyframe.log.Logger.debug.println("�0�5�2�2�0�3�3�1 �7�3�1�6----  output : "+output);	
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}								
}
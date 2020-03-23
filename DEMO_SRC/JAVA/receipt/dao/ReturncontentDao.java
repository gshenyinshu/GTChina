package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class ReturncontentDao
{
	
	////반송사유 검색
	public DataSet Selcontent(DataSet input) throws Exception
	{		
		try
		{
			DataSet input1 = new DataSet();
			DataSet input2 = new DataSet();
			DataSet input3 = new DataSet();
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/return_content", input);

			String policy = output.getText("policy",0);
   			input1.put("policy", policy);
   			InteractionBean interact1 = new InteractionBean();
			DataSet output1 = interact1.execute("/changeminer/ksps0300", input1);		
			output.put("slpcd", output1.getText("slpcd"), 0);	


			input3.put("deptcd", "INT");
			input3.put("init", "     ");
			input3.put("plyno", policy);
			InteractionBean interact4 = new InteractionBean();
			DataSet output4 = interact4.execute("/changeminer/coveragenormal", input3);			     					
					
			output.put("plan_nm", output4.getText("plnname"), 0);	
					
			input2.put("lpcode", output1.getText("slpcd"));
			InteractionBean interact2 = new InteractionBean();
			DataSet output2 = interact2.execute("/changeminer/lpsm_info_search", input2);			     					
			output.put("lpname", output2.getText("lp_name"), 0);	
			output.put("lpemail", output2.getText("lp_email"),0);	
			output.put("smcode", output2.getText("sm_code"), 0);	
			output.put("smname", output2.getText("sm_name"), 0);	
			output.put("smemail", output2.getText("sm_email"),0);	

			anyframe.log.Logger.debug.println("반송사유 리스트 ----  output : "+output);	


			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
			
	
					
}
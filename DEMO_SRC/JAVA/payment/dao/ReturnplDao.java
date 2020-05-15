package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class ReturnplDao
{

   public DataSet findPolicyreturnList(DataSet input)
        throws Exception
    {
                try
        {	  
            String lp_id = "";          
	     DataSet input1 = new DataSet();			
	     
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policy_return", input);
	     
	     int cnt = output.getCount("policy_no");
	     
	     for(int i=0;i<cnt;i++) 
	     {
	     	lp_id = output.getText("lp_id",i);	
	     	if(lp_id.trim().equals("") || lp_id.trim() == null ) 
	     	{
	     		output.put("lpname", "");
	     	}
	     	else
	     	{
	     		input1.put("lpcode", lp_id);
			InteractionBean interact1 = new InteractionBean();
			DataSet output1 = interact1.execute("/changeminer/lp_search", input1);			     					
			output.put("lpname", output1.getText("lpname"), i);	
	    }
	     	
	    }
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }

    }

    public DataSet findPolicyreturn(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policyreturn_count", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}
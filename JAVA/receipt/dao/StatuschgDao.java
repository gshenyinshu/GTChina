package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class StatuschgDao
{

   public DataSet findStatuschgList(DataSet input)
        throws Exception
    {
        try
        {	  
            String lp_id = "";          
	     DataSet input1 = new DataSet();			
	     
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/status_chg", input);
	     
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

    public DataSet findStatuschg(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/status_count", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
    
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
	

}
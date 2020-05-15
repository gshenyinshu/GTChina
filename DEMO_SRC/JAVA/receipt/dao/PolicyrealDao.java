package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class PolicyrealDao
{

   public DataSet findPolicyrealList(DataSet input)
        throws Exception
    {
        try
        {	  
            String lp_id = "";          
	     DataSet input1 = new DataSet();			
	     
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policy_realtime", input);
	     
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }

    public DataSet findPolicyreal(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policyreal_count", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}
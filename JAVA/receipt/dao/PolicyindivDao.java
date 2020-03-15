package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class PolicyindivDao
{

   public DataSet findPolicyindivList(DataSet input) throws Exception
   {
        try
        {	  
            String lp_id = "";          
	     	DataSet input1 = new DataSet();			
	     
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policy_indiv", input);
	     
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }

    public DataSet findPolicyindiv(DataSet input) throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policyindiv_count", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
    
	////�2�9�8�5�3�5�2�5�5�9
    public DataSet updateBank(DataSet input) throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policyindiv_bankupt", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }    
    
    
    ////wb_master�2�3 process_mode�2�3 "B"�0�9 update
    public DataSet master_upt(DataSet input) throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            anyframe.log.Logger.debug.println("wb_master�2�3 process_mode�2�3 update ---- input : "+input);
            DataSet output = executor.execute("/changeminer/policyindiv_masterUpt", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }  
    
}
package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class PolicyReissueDao
{

   public DataSet findPolicyReissueList(DataSet input)
        throws Exception
    {
        try
        {	  
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policy_reissue_list", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }

    public DataSet findPolicyReissueCount(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policy_reissue_account", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
    
    
	////�1�8�5�1�1�3�7�4 : �3�0�2�1 -> �0�9�2�2,�0�5�2�2
 	public DataSet findPolicyReissue_up(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 - �1�8�5�1�1�3�7�4 : �3�0�2�1 -> �0�9�2�2,�0�5�2�2(DAO) ======== input : "+input);
            DataSet output = executor.execute("/changeminer/policy_reissue_update", input);
anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 - �1�8�5�1�1�3�7�4 : �3�0�2�1 -> �0�9�2�2,�0�5�2�2(DAO) ======== output : "+output);            
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }


	////�1�8�5�1�1�3�7�4 : �3�0�2�1 -> �3�6�2�7�4�9�0�5
 	public DataSet findPolicyReissue_up1(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 - �1�8�5�1�1�3�7�4 : �3�0�2�1 -> �3�6�2�7�4�9�0�5(DAO) ======== input : "+input);
            DataSet output = executor.execute("/changeminer/policy_reissue_update1", input);
anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 - �1�8�5�1�1�3�7�4 : �3�0�2�1 -> �3�6�2�7�4�9�0�5(DAO) ======== output : "+output);            
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }



	////�3�1�7�5�4�9�0�5�2�7 - list �7�5�3�9�2�7�8�5
	public DataSet findChange_list(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 ----(�3�1�7�5�4�9�0�5�2�7 - list �7�5�3�9�2�7�8�5)  input  : "+input );				
			DataSet output = executor.execute("/changeminer/policy_reissue_change_list", input);
anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 ----(�3�1�7�5�4�9�0�5�2�7 - list �7�5�3�9�2�7�8�5)  output  : "+output );				
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
    }


	////�3�1�7�5�4�9�0�5�2�7 - Host�3�3�3�2
	public DataSet findSave_host(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 ----(�3�1�7�5�4�9�0�5�2�7 -�3�3�3�2)  input  : "+input );				
			DataSet output = executor.execute("/changeminer/ksps1300", input);
anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 ----(�3�1�7�5�4�9�0�5�2�7 -�3�3�3�2)  output  : "+output );				
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
    }



	////�3�1�7�5�4�9�0�5�2�7 - �3�3�3�2(msdb)
	public DataSet findSave_msdb(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 ----(�3�1�7�5�4�9�0�5�2�7-�3�3�3�2-msdb)  input  : "+input );				
			DataSet output = executor.execute("/changeminer/wb_letter_msdb_ins", input);
anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 ----(�3�1�7�5�4�9�0�5�2�7-�3�3�3�2-msdb)  output  : "+output );				
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	



	////�0�5�3�3�1�3 - list
 	public DataSet findPolicyReissue_pop_list(DataSet input)
    throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 - �0�5�3�3�1�3 - list(DAO) ======== input : "+input);
            DataSet output = executor.execute("/changeminer/policy_reissue_pop_list", input);
anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 - �0�5�3�3�1�3 - list(DAO) ======== output : "+output);            
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }


	////�0�5�3�3�1�3 - update
 	public DataSet findPolicyReissue_label_upt(DataSet input)
    throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 - �0�5�3�3�1�3 - update(DAO) ======== input : "+input);
            DataSet output = executor.execute("/changeminer/policy_reissue_label_upt", input);
anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 - �0�5�3�3�1�3 - update(DAO) ======== output : "+output);            
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }


    
    
}
package gtone.changeminer.monitor.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class MoniteringprDao
{

   public DataSet findMonitorList(DataSet input)
        throws Exception
    {
        try
        {	  
            String lp_id = "";          
	     DataSet input1 = new DataSet();			
	     
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/monitering_proof_sel", input);
	     
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }

    public DataSet findMonitor(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/monitering_proof_account", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
    
    
    
    public DataSet findMonitor_count(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            Logger.debug.println("findMonitor_count ----  input : "+input);
            DataSet output = executor.execute("/changeminer/monitering_proof_krct0100_pmsYN_count", input);
            Logger.debug.println("findMonitor_count ----  output : "+output);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
    
     public DataSet findMonitor_sel(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            Logger.debug.println("findMonitor_sel ----  input : "+input);
            DataSet output = executor.execute("/changeminer/monitering_proof_pmsYN_sel", input);
            Logger.debug.println("findMonitor_sel ----  output : "+output);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
    
     public DataSet findMonitor_upt(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            Logger.debug.println("findMonitor_upt ----  input : "+input);
            DataSet output = executor.execute("/changeminer/monitering_proof_upt", input);
            Logger.debug.println("findMonitor_upt ----  output : "+output);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}
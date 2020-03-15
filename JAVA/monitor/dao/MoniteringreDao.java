package gtone.changeminer.monitor.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class MoniteringreDao
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
            DataSet output = executor.execute("/changeminer/monitering_resurr", input);
	     
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
            DataSet output = executor.execute("/changeminer/monitering1_account", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}
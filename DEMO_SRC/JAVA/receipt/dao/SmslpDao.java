package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class SmslpDao
{

   public DataSet findSmslpList(DataSet input)
        throws Exception
    {
        try
        {	  
	     
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/smslp", input);
	    
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}
////�ۼ��� : ������ 2006.06.01

package gtone.changeminer.common.dao;

import anyframe.data.DataSet;
import anyframe.log.*;

import gtone.changeminer.common.dao.Executor;

public  class CyberIndexDao
{

   public  DataSet findList(DataSet input) throws Exception {
        try {	  
                      
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/cyber_index_list", input);

            return output;
        } catch(Exception e) {
        	Logger.debug.println("your findList : "+e.toString());
            throw e;
            e.printStackTrace();
        }
    }

	public DataSet findListAdd(DataSet input) throws Exception	{
	   try {	  
	       String lp_id = "";          
	       DataSet input1 = new DataSet();			
	    
	       Executor executor = null;
	       executor = Executor.getInstance();
	       DataSet output = executor.execute("/changeminer/cyber_index_add_list", input);
	    
	       return output;
	   } catch(Exception e) {
		   Logger.debug.println("�����߻� findListAdd : "+e.toString());
	       throw e;
	   }
	}
	
    public DataSet findPubStat(DataSet input) throws Exception {
        try {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/cyber_index_pub_stat", input);
            return output;
        } catch(Exception e){
        	Logger.debug.println("�����߻� findPubStat : "+e.toString());
            throw e;
        }
    }
    
    public void causeAdd(DataSet input) throws Exception {
        try {
            
        	Executor executor = null;
            executor = Executor.getInstance();
            executor.execute("/changeminer/cyber_index_save", input);
            Logger.debug.println("causeAdd Dao "+input);
        } catch(Exception e){
        	Logger.debug.println("�����߻� causeAdd : "+e.toString());
            throw e;
        }
    }
 
    public DataSet findCause(DataSet input) throws Exception {
        try {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/cyber_index_cause", input);
            return output;
        } catch(Exception e){
        	Logger.debug.println("�����߻� findCause : "+e.toString());
            throw e;
        }
    }
    
    public String findCauseTotal(DataSet input) throws Exception {
        try {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/cyber_index_cause_total", input);
            return output.getText("total");
        } catch(Exception e){
        	Logger.debug.println("�����߻� findCauseTotal : "+e.toString());
            throw e;
        }
    }

    
/*    public DataSet findStandardList() throws Exception {
        try {	  
                      
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet input = new DataSet();
            
            DataSet output = executor.execute("/changeminer/cyber_index_standard", input);

            return output;
        } catch(Exception e) {
        	Logger.debug.println("�����߻� findStandardList : "+e.toString());
            throw e;
        }
    }

    public void findStandardUpdate(DataSet input) throws Exception {
        try {
            
        	Executor executor = null;
            executor = Executor.getInstance();
            executor.execute("/changeminer/cyber_index_standard_update", input);
            Logger.debug.println("causeAdd Dao "+input);
        } catch(Exception e){
        	Logger.debug.println("�����߻� findStandardUpdate : "+e.toString());
            throw e;
        }
    }*/
}

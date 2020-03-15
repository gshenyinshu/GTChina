package gtone.changeminer.withdrawal.dao;

import anyframe.data.DataSet;
import anyframe.log.*;

import gtone.changeminer.common.dao.Executor;

public class WithdrawalDao
{

   public DataSet findList(DataSet input) throws Exception {
        try {	  
			System.out.println("findList�2�7�3�2-------------------------------------------------------->");
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/withdrawal_list", input);
			
            return output;
        } catch(Exception e) {
        	Logger.debug.println("�2�3�0�7�0�9�1�6 findList : "+e.toString());
            throw e;
        }
    }

	public DataSet findListCount(DataSet input) throws Exception {
		 try {	  
			 System.out.println("findListCount�2�7�3�2-------------------------------------------------------->");
			 Executor executor = null;
			 executor = Executor.getInstance();
			 DataSet output = executor.execute("/changeminer/withdrawal_list_count", input);
			
			 return output;
		 } catch(Exception e) {
			 Logger.debug.println("�2�3�0�7�0�9�1�6 findList : "+e.toString());
			 throw e;
		 }
	 }

	public void save(DataSet input) throws Exception {
		 try {	  
             System.out.println("�3�3�3�2 dao �2�7�3�2-------------------------------------------------------->");
			 Executor executor = null;
			 executor = Executor.getInstance();
			 executor.execute("/changeminer/withdrawal_save", input);

		 } catch(Exception e) {
			 Logger.debug.println("�2�3�0�7�0�9�1�6 save : "+e.toString());
			 throw e;
		 }
	 }	 
	/**
	 * �1�5�6�7�8�8�3�1�3�1 �7�5�3�9�2�7�8�5
	 * @param   
	 * @return void
	 */
	public DataSet selectContract(DataSet input)throws Exception{
		DataSet     output  ;//[DB]output data
		Executor    executor;//[DB]query�3�7�2�2
		int         cnt     ;//[DB]�4�7�0�5�4�9�0�4�7�2�2�1
        
		try{
			output  = new DataSet();
			executor = Executor.getInstance();           
			output = executor.execute("cybercenter/contract_sum", input);
			System.out.println(output);
			return output ;
		}catch(Exception e){
			throw(e);	
		}
	}
}

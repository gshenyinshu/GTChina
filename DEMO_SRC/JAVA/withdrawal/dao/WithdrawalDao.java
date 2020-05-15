package gtone.changeminer.withdrawal.dao;

import anyframe.data.DataSet;
import anyframe.log.*;

import gtone.changeminer.common.dao.Executor;

public class WithdrawalDao
{

   public DataSet findList(DataSet input) throws Exception {
        try {	  
			System.out.println("findList����-------------------------------------------------------->");
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/withdrawal_list", input);
			
            return output;
        } catch(Exception e) {
        	Logger.debug.println("�����߻� findList : "+e.toString());
            throw e;
        }
    }

	public DataSet findListCount(DataSet input) throws Exception {
		 try {	  
			 System.out.println("findListCount����-------------------------------------------------------->");
			 Executor executor = null;
			 executor = Executor.getInstance();
			 DataSet output = executor.execute("/changeminer/withdrawal_list_count", input);
			
			 return output;
		 } catch(Exception e) {
			 Logger.debug.println("�����߻� findList : "+e.toString());
			 throw e;
		 }
	 }

	public void save(DataSet input) throws Exception {
		 try {	  
             System.out.println("���� dao ����-------------------------------------------------------->");
			 Executor executor = null;
			 executor = Executor.getInstance();
			 executor.execute("/changeminer/withdrawal_save", input);

		 } catch(Exception e) {
			 Logger.debug.println("�����߻� save : "+e.toString());
			 throw e;
		 }
	 }	 
	/**
	 * ���賳���� ��������
	 * @param   
	 * @return void
	 */
	public DataSet selectContract(DataSet input)throws Exception{
		DataSet     output  ;//[DB]output data
		Executor    executor;//[DB]query����
		int         cnt     ;//[DB]������°���
        
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

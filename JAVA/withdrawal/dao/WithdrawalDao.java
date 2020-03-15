package gtone.changeminer.withdrawal.dao;

import anyframe.data.DataSet;
import anyframe.log.*;

import gtone.changeminer.common.dao.Executor;

public class WithdrawalDao
{

   public DataSet findList(DataSet input) throws Exception {
        try {	  
			System.out.println("findList시작-------------------------------------------------------->");
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/withdrawal_list", input);
			
            return output;
        } catch(Exception e) {
        	Logger.debug.println("에러발생 findList : "+e.toString());
            throw e;
        }
    }

	public DataSet findListCount(DataSet input) throws Exception {
		 try {	  
			 System.out.println("findListCount시작-------------------------------------------------------->");
			 Executor executor = null;
			 executor = Executor.getInstance();
			 DataSet output = executor.execute("/changeminer/withdrawal_list_count", input);
			
			 return output;
		 } catch(Exception e) {
			 Logger.debug.println("에러발생 findList : "+e.toString());
			 throw e;
		 }
	 }

	public void save(DataSet input) throws Exception {
		 try {	  
             System.out.println("저장 dao 시작-------------------------------------------------------->");
			 Executor executor = null;
			 executor = Executor.getInstance();
			 executor.execute("/changeminer/withdrawal_save", input);

		 } catch(Exception e) {
			 Logger.debug.println("에러발생 save : "+e.toString());
			 throw e;
		 }
	 }	 
	/**
	 * 보험납일일 가져오기
	 * @param   
	 * @return void
	 */
	public DataSet selectContract(DataSet input)throws Exception{
		DataSet     output  ;//[DB]output data
		Executor    executor;//[DB]query전송
		int         cnt     ;//[DB]쿼리출력갯수
        
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

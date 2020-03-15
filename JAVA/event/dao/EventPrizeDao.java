/**
 * Title       : 
 * Description : Sample dao
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author 
 * @version 1.0
 */
package gtone.changeminer.event.dao;

import anyframe.data.DataSet;
import gtone.changeminer.common.dao.Executor ;

public  class EventPrizeDao
{

	/**
	 * Sample Dao
	 * @param   
	 * @return  
	 */
	public DataSet selectPrize(DataSet input)throws Exception
	{

		DataSet     output  ;////[DB]input  data
		Executor    executor;////[DB]query전송

		try {
			output  = new DataSet();
			executor = Executor.getInstance();           
System.out.println("selectPrize_input --------------------------" + input);
			output = executor.execute("cybercenter/prudb_usp_prize_cyberevent", input);
System.out.println("selectPrize_output --------------------------" + output);
			return output ;
		}catch(Exception e){
			throw(e);	
		}
	}
}

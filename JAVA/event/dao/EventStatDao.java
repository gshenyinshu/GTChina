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

public  class EventStatDao
{

	/**
	 * Sample Dao
	 * @param   
	 * @return  
	 */
	public DataSet getApplyStat(DataSet input)throws Exception
	{

		DataSet     output  ;////[DB]input  data
		Executor    executor;////[DB]query�3�7�2�2

		try {
			output  = new DataSet();
			executor = Executor.getInstance();           
System.out.println("getApplyStat_input --------------------------" + input);
			output = executor.execute("cybercenter/cyberevent_apply_stat", input);
System.out.println("getApplyStat_output --------------------------" + output);
			return output ;
		}catch(Exception e){
			throw(e);	
		}
	}
}

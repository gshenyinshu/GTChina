/**
 * Title       : Exception Data Access Object
 * Description : exception �3�5 �0�3�1�7�3�1�0�7 �2�2�2�5�2�7�8�9 dao.
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author Dong-hyun Sohn
 * @version 1.0
 */

package gtone.changeminer.common.dao;

import java.util.List;
import anyframe.data.DataSet;
import gtone.changeminer.common.dao.Executor;

public  class ExceptionDao
{
	public DataSet findException(String exceptionId)
		throws Exception
	{

/**
 * ID       : dba
 * Password : pass
 */
		try
		{
			DataSet input = new DataSet();
			input.put("ExceptionId", exceptionId);

			Executor executor = Executor.getInstance();
			DataSet output = executor.execute("/common/select_exception", input);

			return output;
		}
		catch (Exception e)
		{
			throw(e);
                  e.printStackTrace();
		}
	}
}


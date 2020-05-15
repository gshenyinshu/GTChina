/**
 * Title       : RequestToDataset
 * Description : Http Request를 받아와서 DataSet에 copy한다
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author Kim, Bumjin
 * @version 1.0
 */


package gtone.changeminer.common.utility;

import java.util.*;
import java.lang.reflect.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import anyframe.*;
import anyframe.log.*;
import anyframe.data.DataSet;

public  class RequestToDataset
{
	public static void copyProperties(DataSet dataSet, HttpServletRequest request)
	{
		try
		{
	        Enumeration fieldNames = request.getParameterNames();
	
	        while (fieldNames.hasMoreElements())
	        {
	            String paramName = (String)fieldNames.nextElement();
	
	            try
	            {
	                for (int i=0;i<request.getParameterValues(paramName).length; i++)
	                {
	                	Object paramValue = request.getParameterValues(paramName)[i];
	
						//////Logger.debug.println("##################RequestToDataset##########################" + i);					
						//////Logger.debug.println(paramName + " | " + paramValue);
						dataSet.put(paramName, paramValue);
						//////Logger.debug.println("##################RequestToDataset##########################" + i);					
	                }
	
	            }
	            catch(Exception ex){ ex.printStackTrace();}
	        }
		}	       

		catch(Exception e)
		{}
	}

}

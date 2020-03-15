/**
 * Title       : io_schema executor
 * Description : anylogic 의 Interaction를 얻어와서 execute()를 실행시켜준다.
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author Dong-hyun Sohn
 * @version 1.0
 */

package gtone.changeminer.common.dao;

import anyframe.data.DataSet;
import anyframe.data.ResourceException;
import anyframe.data.cci.Connection;
import anyframe.data.cci.Interaction;
import anyframe.data.cci.DefaultConnectionFactory;

/*
 * @web.resource-ref name="jdbc/cybercenterDS"
 *                   type="javax.sql.DataSource"
 *                   auth="Container"
 *                   description="devserver : nec2/mylp (mssql2k)"
 *                   scope="Unshareable"
 *
 * @web.resource-ref name="jdbc/AS400DS"
 *                   type="javax.sql.DataSource"
 *                   auth="Container"
 *                   description="devserver : nec2/ call sp (db2)"
 *                   scope="Unshareable"
 */
public  class Executor
{
	private static Executor executor = null;
	private Connection connection    = null;
	boolean isTransaction            = false;
	Interaction interact             = null;

	private Executor()
		throws Exception
	{
		try
		{
			connection = getConnection();
		}
		catch (Exception e)
		{
			throw (e);
		}
	}

	public static Executor getInstance()
		throws Exception
	{
		/*
		if( executor == null )
			executor = new Executor();

		return executor;
		*/
		return new Executor();
	}

	public static Executor getInstance(boolean newInstance)
		throws Exception
	{
		if (newInstance)
			executor = null;

		return getInstance();
	}

	public DataSet execute(String schema_id, DataSet input)
		throws ResourceException, Exception
	{
		try
		{
			if (interact == null)
				interact = connection.createInteraction();

			return interact.execute(schema_id, input);
		}
		catch (ResourceException re)
		{
			throw(re);
		}
		catch (Exception e)
		{
			throw(e);
		}
		finally
		{
			if (!isTransaction)
				disconnect();
		}
	}

	private Connection getConnection()
		throws ResourceException, Exception
	{
		try
		{
		////	if (ds_alias == null || ds_alias.trim().equals(""))
				return DefaultConnectionFactory.getConnection();
		////	else
		
		////		connection = ConnectionFactory.getConnection(ds_alias);
		}
		catch (ResourceException re)
		{
			throw(re);
		}
		catch (Exception e)
		{
			throw(e);
		}
	}

	public void beginTransaction()
		throws Exception
	{
		connection.beginTransaction();
		isTransaction = true;
	}

	public void disconnect()
		throws Exception
	{
		if (connection != null)
			connection.close();
	}

	public void commitTransaction()
		throws Exception
	{
		try
		{
			connection.commitTransaction();
		}
		finally
		{
			disconnect();
			isTransaction = false;
		}
	}

	public void rollbackTransaction()
		throws Exception
	{
		try
		{
			connection.rollbackTransaction();
		}
		finally
		{
			disconnect();
			isTransaction = false;
		}
	}
};



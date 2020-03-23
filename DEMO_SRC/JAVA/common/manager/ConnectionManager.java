package gtone.changeminer.common.manager;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/***
 * Connection Pooling의 Connection 객체를 관리하는 클래스. 
 */
public  class ConnectionManager
{
	static String ANYBORN_DATASOURCE = "jdbc/anybornDS";
	static String DEVSERV_DATASOURCE = "jdbc/cybercenterDS";
	static String DB2_DATASOURCE = "jdbc/AS400DS";

	/**
	 * Connection 객체를 반환하는 메써드.
	 * @return
	 * @throws SQLException
	 */

	public static Connection getConnection()
		throws SQLException, NamingException
	{
		try
		{
			return getConnection(DEVSERV_DATASOURCE);
		}
		catch (SQLException se)
		{
			throw(se);
		}
		catch (NamingException ne)
		{
			throw(ne);
		}
	}

	public static Connection getAnybornConnection()
		throws SQLException, NamingException
	{
		try
		{
			return getConnection(ANYBORN_DATASOURCE);
		}
		catch (SQLException se)
		{
			throw(se);
		}
		catch (NamingException ne)
		{
			throw(ne);
		}
	}

	public static Connection getDb2Connection()
		throws SQLException, NamingException
	{
		try
		{
			return getConnection(DB2_DATASOURCE);
		}
		catch (SQLException se)
		{
			throw(se);
		}
		catch (NamingException ne)
		{
			throw(ne);
		}
	}


	private static Connection getConnection(String datasource_name) throws SQLException, NamingException
	{
		try
		{
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup(datasource_name);
		
			return ds.getConnection();
		}
		catch (SQLException se)
		{
			throw(se);
		}
		catch (NamingException ne)
		{
			throw(ne);
		}
	}
}




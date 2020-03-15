package gtone.changeminer.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/*
 * ServletRequest�7�4�4�7�2�3 �3�7�4�9�9�0�3�5 �1�7�3�4�6�9�8�9 Filter�5�7�9�3�2�1.
 * 
 * @web.filter name="Encoding Filter" 
 * 			   display-name="Encoding Filter"
 * 	
 * @web.filter-init-param name="encoding"
 * 						  value="EUC-KR"		    
 * 
 * @web.filter-mapping url-pattern="*.do"
 *
 */
public  class EncodingFilter implements Filter
{
	private String encoding = null;

	protected FilterConfig filterConfig = null;

	public void destroy()
	{
		this.encoding = null;
		this.filterConfig = null;
	}

	/**
	 * ServletRequest�7�4�4�7�2�3 web.xml�2�3�1�9 �3�7�9�7�9�1 �3�7�4�9�9�0�3�5 �1�7�3�4�6�9�8�9 �0�3�2�7�9�3.
	 */
	public void doFilter(ServletRequest request,
						 ServletResponse response,
						 FilterChain chain)
		throws IOException, ServletException
	{
		if (request.getCharacterEncoding() == null)
			if (encoding != null)
				request.setCharacterEncoding(encoding);

		chain.doFilter(request, response);
	}

	/**
	 * web.xml�2�3�1�9 �3�7�9�7�9�1 �3�7�4�9�9�0 �7�3�3�5 �4�1�8�5�6�1�6�9�8�9 �0�3�2�7�9�3.
	 */
	public void init(FilterConfig filterConfig) throws ServletException
	{
		this.filterConfig = filterConfig;
		this.encoding = filterConfig.getInitParameter("encoding");
	}

	public FilterConfig getFilterConfig()
	{
		return filterConfig;
	}

	public void setFilterConfig(FilterConfig cfg)
	{
		filterConfig = cfg;
	}
}

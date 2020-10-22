package gtone.changeminer.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/*
 * ServletRequest��ü�� ���ڵ��� �����ϴ� FilterŬ����.
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
	 * ServletRequest��ü�� web.xml���� ���޵� ���ڵ��� �����ϴ� �޽��.
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
	 * web.xml���� ���޵� ���ڵ� ���� �ʱ�ȭ�ϴ� �޽��.
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
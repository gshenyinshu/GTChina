package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="newcategoryForm"
 */
public  class NewcategoryForm extends ActionForm
{
	
	private String flag;
	private String chkyn;
	private String category;

	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		flag           = "";
		chkyn          = "";
		category           = "";

	}

	public void setFlag(String flag)
	{
		this.flag = flag;
	}

	public String getFlag()
	{
		return flag;
	}


	public void setChkyn(String chkyn)
	{
		this.chkyn = chkyn;
	}

	public String getChkyn()
	{
		return chkyn;
	}


	public void setCategory(String category)
	{
		this.category = category;
	}

	public String getCategory()
	{
		return category;
	}


	
}
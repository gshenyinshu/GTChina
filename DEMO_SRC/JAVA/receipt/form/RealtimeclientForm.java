package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="realtimeclientForm"
 */
public  class RealtimeclientForm extends ActionForm
{
	
	private String indate;	
	private String seq_no;	
	private String srvc_cd;		

	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		indate = "";		
		seq_no = "";
		srvc_cd = "";
	}
	


	public void setIndate(String indate)
	{
		this.indate = indate;
	}

	public String getIndate()
	{
		return indate;
	}
			
	public void setSeq_no(String seq_no)
	{
		this.seq_no = seq_no;
	}

	public String getSeq_no()
	{
		return seq_no;
	}	

	public void setSrvc_cd(String srvc_cd)
	{
		this.srvc_cd = srvc_cd;
	}

	public String getSrvc_cd()
	{
		return srvc_cd;
	}	
	
}
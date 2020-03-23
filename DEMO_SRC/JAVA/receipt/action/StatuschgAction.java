package gtone.changeminer.receipt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;

import gtone.changeminer.common.utility.*;
import gtone.changeminer.receipt.form.StatuschgForm;
import gtone.changeminer.receipt.manager.StatuschgManager;
import gtone.changeminer.payment.manager.ReturnManager;
import anyframe.util.*;////StringFormater.fillZero(String,int)

////����
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;
/**
 * @struts.action
 *      path="/status_chg_list"
 *      name="statuschgForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="status_chg_list"
 *      path="/status_chg_list.jsp"
 * 
 */

public  class StatuschgAction extends Action
{
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws Exception
    {
        int POLICY_LIST_PAGE_SIZE = 20;
        
        try
        {
            Logger.debug.println("################ StatuschgAction Start ####################");

            DataSet input = new DataSet();
            DataSet input2 = new DataSet();
            DataSet input3= new DataSet();
            DataSet input4= new DataSet();
            DataSet input5= new DataSet();
            DataSet input6= new DataSet();
            DataSet input7= new DataSet();
            DataSet inputCount = new DataSet();
            
            StatuschgForm statuschgForm = (StatuschgForm)form;

            FormToDataset.copyProperties(input, statuschgForm);
		
	     String searchgubun 	 = request.getParameter("searchgubun")	== null ? "S" : request.getParameter("searchgubun");		
	     String searchgubun1 	 = request.getParameter("searchgubun1")	== null ? "N" : request.getParameter("searchgubun1");		

            String fromdate = request.getParameter("fromdate") == null ? "" : request.getParameter("fromdate");
            String todate = request.getParameter("todate") == null ? "" : request.getParameter("todate");
            String mode = request.getParameter("mode") == null ? "" : request.getParameter("mode");
            String rslt = request.getParameter("rslt") == null ? "" : request.getParameter("rslt");
            
            String search = request.getParameter("search") == null ? "" : request.getParameter("search");
            String key = request.getParameter("key") == null ? "" : request.getParameter("key");
            
            String modeind = request.getParameter("modeind") == null ? "1" : request.getParameter("modeind");////����/����
            String srvc_ind = request.getParameter("srvc_ind") == null ? "" : request.getParameter("srvc_ind");
            
	     String policy_apln_no = request.getParameter("policy_apln_no") == null ? "" : request.getParameter("policy_apln_no");////������ȣ
	     String policy_no = request.getParameter("policy_no") == null ? "" : request.getParameter("policy_no");////������ȣ
	     String srvc_cd = request.getParameter("srvc_cd") == null ? "" : request.getParameter("srvc_cd");////��������
	     String inout= "";
	     ////2006-09-25:�躸�� IN/OUT�� ReturnAction�� �޶� ����
	     if(srvc_cd.equals("1") || srvc_cd.equals("4") ||srvc_cd.equals("5") || srvc_cd.equals("7"))
	     {
	     		inout = "OUT";	
	     }
	     else if(srvc_cd.equals("2") || srvc_cd.equals("3") || srvc_cd.equals("6") || srvc_cd.equals("8"))
	     {
	     		inout = "IN";
	     }
	     
	     if(srvc_cd.equals("1")) srvc_cd = "L1";////�������
	     if(srvc_cd.equals("2") || srvc_cd.equals("3")) srvc_cd = "P3";////���,APL��ȯ	     
	     if(srvc_cd.equals("4") || srvc_cd.equals("7")) srvc_cd = "D1";////��������
	     if(srvc_cd.equals("5")) srvc_cd = "E1";////�ؾ�ȯ�ޱ�
	     if(srvc_cd.equals("6")) srvc_cd = "P2";////����ᳳ��
	     if(srvc_cd.equals("8")) srvc_cd = "P2";////�߰�����ᳳ��
	     String bank_cd = request.getParameter("bank_cd") == null ? "" : request.getParameter("bank_cd");////����
	     String acct_no = request.getParameter("acct_no") == null ? "" : request.getParameter("acct_no");////����
	     String payor_ssn = request.getParameter("payor_ssn") == null ? "" : request.getParameter("payor_ssn");////�����ֺι�
		
		String errrtn = "";////�����ڵ�

		////���ǻ���ϱ�
		SessionManager sessionManager = new SessionManager(request);
		String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
		String emp_no = sessionManager.getString(Constant.SESSION_USERID);
		String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);		
		
	     	String proc_emp_no = emp_no;////ó���ڻ��	
	     	String tproc_emp_no = proc_emp_no.toUpperCase();			
	     	
		String deptcd  		= "INT";
		String init	   		= "     ";		
		String gubun    	= "W";////ó������(C,W)
		String reqnum  	= "   ";////��û�Ǽ�
		String fromdt 		=    "        ";
		String policy	 	=    request.getParameter("policy_no")	== null ? "" : request.getParameter("policy_no");////���ǹ�ȣ		
		String procdt   		= "        ";////����ó������
		String proctm   	= "      ";////����ó���ð�
		
		
		String procgb  		= srvc_cd;
		
		String lvlnum  		= "";////ó������
		String lvlbef   		= "  ";////ó��������
		String mbkcd    	= "  ";////����� �����ڵ�
		String mbkact   	= "               ";////����� ���¹�ȣ
		String cltbk    		=  request.getParameter("bank_cd")	== null ? "" : request.getParameter("bank_cd");////�����ڵ�
		String cltact   		= request.getParameter("acct_no")	== null ? "" : request.getParameter("acct_no");////�� ���¹�ȣ
		String cltnum   	= request.getParameter("payor_ssn")	== null ? "" : request.getParameter("payor_ssn");////�� �ֹι�ȣ
		String procamt = "0000000000000";
		String procno   	= "      ";////��ü������ȣ 
		String brltcd   		= "    ";////������	
		String chgstatus     = request.getParameter("rtnflag")	== null ? "" : request.getParameter("rtnflag");////���º����ڵ尪
		anyframe.log.Logger.debug.println("ó�����°�()��?==========="+chgstatus);
  		String message = "";
	       StatuschgManager manager = StatuschgManager.getInstance();
	       ReturnManager returns = ReturnManager.getInstance();////�ݼ�
	       
		if(searchgubun1.equals("C"))
		{	
	
			input2.put("deptcd", deptcd);
			input2.put("init", init);
			input2.put("reqnum", reqnum );
			input2.put("fromdt", fromdt );
			input2.put("policy", policy );
			input2.put("procdt", procdt );
			input2.put("proctm", proctm );
			input2.put("inout", inout  );
			input2.put("procgb", procgb );
			input2.put("lvlnum", lvlnum );
			input2.put("lvlbef", lvlbef );
			input2.put("mbkcd", mbkcd  );
			input2.put("mbkact", mbkact );
			input2.put("cltbk", "  ");
			input2.put("cltact", "               " );
			input2.put("cltnum", "             ");
			input2.put("procamt", "0000000000000");
			input2.put("procno", procno );
			input2.put("brltcd", brltcd );			
			
			input2.put("gubun", "W" );
			
			input2.put("cltbk", cltbk);
			input2.put("cltact", cltact);
			input2.put("cltnum", cltnum);
			input2.put("procamt", procamt);

			DataSet ksps2000_91  = new DataSet();
			
			if(chgstatus.equals(""))////����
			{
				input2.put("lvlnum", "91");
				ksps2000_91 = manager.findKsps2000(input2);										
				
				errrtn = "";
				errrtn = ksps2000_91.getText("rtn");										
				if(errrtn.equals("0"))
				{
					input2.put("lvlnum", "10");
					ksps2000_91 = manager.findKsps2000(input2);																
					errrtn = "";
					errrtn = ksps2000_91.getText("rtn");										
				}////ksps2000
				
				if(errrtn.equals("0"))
				{
					////�̷����� ���������� �Ʒ��� ���� wb_process�� �ι� ����� ������
					////���̹����Ϳ��� �������¸� Ȯ���Ŀ� ������ ���� ���·� �����Ϸ��� �ϴ�
					////�� ���� ���°� ���������� ������� �����
					////�ٽ� ���� ���·� �����Ϸ��� �ߴ��� ����.
					////�м��� �� �غ��� �˰� ����.
					
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "91");
					input5.put("err_msg", "�����޽��� Ȯ���� ����ó��");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);
					////findRtnsave
////					ó����Ȱ
////					1.wb_process��  ���°��� �Է��Ѵ�.
					
					input3.put("policy_apln_no", policy_apln_no);
					input3.put("proc_emp_no", proc_emp_no);
					input3.put("proc_status", "10");
					input3.put("err_msg", "");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input3);
					
					DataSet rtnsave0 = returns.findRtnsave(input3);
					message = "���º����� ������ ����Ǿ����ϴ�.";
				}	
			}	
			else if(chgstatus.equals("0"))////����
			{
				input2.put("lvlnum", "80");
				ksps2000_91 = manager.findKsps2000(input2);										
				
				errrtn = "";
				errrtn = ksps2000_91.getText("rtn");										
				anyframe.log.Logger.debug.println("�����϶� ���ϰ�==========="+errrtn);
				if(errrtn.equals("0"))
				{
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "80");
					input5.put("err_msg", "����ó�� ��� ����, HOSTó����� ����");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);						
					message = "���º����� �������� ����Ǿ����ϴ�.";
				}	
			}
			else if(chgstatus.equals("2"))////����
			{
				input2.put("lvlnum", "70");
				ksps2000_91 = manager.findKsps2000(input2);										
				
				errrtn = "";
				errrtn = ksps2000_91.getText("rtn");																
				
				if(errrtn.equals("0"))
				{
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "70");
					input5.put("err_msg", "����ó�� ��� ����, HOSTó����� ����");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);												
				}	
				message = "���º����� ���з� ����Ǿ����ϴ�.";
			} 
			else if(chgstatus.equals("3")) ////����
			{
				input2.put("lvlnum", "50");
				ksps2000_91 = manager.findKsps2000(input2);										
				
				errrtn = "";
				errrtn = ksps2000_91.getText("rtn");																
				
				if(errrtn.equals("0"))
				{
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "50");
					input5.put("err_msg", "����ó�� ��� ����");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);						
				}	
				message = "���º����� �������� ����Ǿ����ϴ�.";
			}			
////			������ 2006.12.06 ���̹� ������ ȭ�� ����
////			�ݼ� ó���� lvlnum 91�� �����޽�����Ȯ���ġ�����ó��
			////  91�� �ƴ϶� 30�� �Ǿ�� �ϴ°� �ƴ���....
////			wb_tbl_process���� ���°��� 1�� ó���� ���ش�. "" ���� , 0�� ����, 1�� �ݼ�, 2�� ����, 3�� ����, A�� ó����
			else if(chgstatus.equals("1")) ////�ݼ�
			{
				input2.put("lvlnum", "91");
				ksps2000_91 = manager.findKsps2000(input2);										
				
				errrtn = "";
				errrtn = ksps2000_91.getText("rtn");																
				
				if(errrtn.equals("0"))
				{
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "1");   
					input5.put("err_msg", "�ݼ� ���� ����");	//// 30 : �ݼۣ�����ó������					
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);
					////findRtnsave
////					ó����Ȱ
////					1.wb_process��  ���°��� �Է��Ѵ�.

				}	
				message = "���º����� �ݼ����� ����Ǿ����ϴ�.";
			}
			
			input6.put("policy_apln_no", policy_apln_no);
			DataSet readrslt = returns.findRsltread(input6);	
			String prslt = "";
			String perrmsg = "";
			prslt = readrslt.getText("rslt").trim();////���º����� ��
			perrmsg = readrslt.getText("err_msg").trim();
			
			////wb_payment ���� �������� rslt, err_msg
			input5.put("policy_apln_no", policy_apln_no);
			input5.put("proc_emp_no", proc_emp_no);
			input5.put("proc_status", prslt);
			input5.put("err_msg", perrmsg);						
			anyframe.log.Logger.debug.println("wb_payment ���� �������� rslt, err_msg==========="+input5);
			
			DataSet rtnpayment = returns.findchgSave(input5);							
			
			////wb_payment�� ����
			////�Ʒ� ���뿡�� proc_status�� ���� wb_payment�� ������ �ʵɰ� ����
			////    wb_process������ ksps2000���� ����ϴ� ó�����°��� ���°��� �´°� ����
			//// �׷��ٸ�  proc_status�� ���� 30�� ������ ����
			//// �׷��� ������ �ϴ� �κ��� �ľ��� ���� 
			//// rslt�� proc_status�� ���νÿ� �̿��ϱ� ������
			//// �����丮������ proc_status�� ����鼭 ���νÿ� �ʿ��� �ڵ尪�� �־���� �ϴ� ������
			//// �ִ°��� �˾Ҵ�...
			
			input7.put("policy_apln_no", policy_apln_no);
			input7.put("proc_emp_no", proc_emp_no);
			input7.put("proc_status", chgstatus);
			input7.put("err_msg", message);						
			anyframe.log.Logger.debug.println("wb_payment ���� �������� rslt, err_msg==========="+input7);
			
			DataSet rtnprocess = returns.findchgSave(input7);
			////findchgSave
			////ó�� ��Ȱ
////			1.wb_payment�� ���¸� �ٲٴ� ��Ȱ�� �Ѵ�.
////			2.wb_process�� ó�������� ���°��� �Է��Ѵ�.
////			�� �ΰ��� ��Ȱ�� �����ϰ� �ִ�.
	
			////������Ȯ���� �����ϰ�� WB_PAYMENT�� RSLT�� ����(),����(1),����(2),����(3)
////			"" ���� , 0�� ����, 1�� �ݼ�, 2�� ����, 3�� ����, A�� ó���� ���� ������ Ʋ���� ����...
			input4.put("policy_apln_no", policy_apln_no);				
			input4.put("proc_status", chgstatus);
			input4.put("err_msg", message);
			anyframe.log.Logger.debug.println("wb_payment input4==========="+input4);					
			DataSet rtnsave1 = returns.findRtnsave1(input4);	
			////findRtnsave1
////			ó����Ȱ
////			1.wb_payment�� ���°��� �����Ѵ�.
			
		}	
		
	     	 
	     	 
	     	     
		if(searchgubun.equals("S"))
		{	
	            String current = request.getParameter("current") == null ? "1" : request.getParameter("current");
	            String page = String.valueOf(POLICY_LIST_PAGE_SIZE * (Integer.parseInt(current) - 1));
	            
	            String where = "";
	            String where1 = "";
	            
			
			if(fromdate.length() > 0)
			{
				where = where + " and CONVERT(CHAR(8),apln_dt, 112) >='"+fromdate+"'"; 	
				where1 = where1 + " and CONVERT(CHAR(8),apln_dt, 112)  >='"+fromdate+"'";
			}
			
			if(todate.length() >0)
			{
				where = where + " and CONVERT(CHAR(8),apln_dt, 112)  <= '"+ todate+"'";
				where1 = where1 + " and CONVERT(CHAR(8),apln_dt, 112)  <= '"+ todate+"'";
			}

			anyframe.log.Logger.debug.println("Policyview���� modeind-----------------: "+modeind);				
			anyframe.log.Logger.debug.println("Policyview���� srvc_ind-----------------: "+srvc_ind);							


			if(modeind.length() > 0)
			{
				where 	= where + " and mode = "+ modeind;
				where1 	= where1 + " and mode = "+ modeind;
			}
			
			if(srvc_ind.length() > 0)
			{
				where = where + " and srvc_cd = " + srvc_ind;
				where1 = where1 + " and srvc_cd = " + srvc_ind;
			}
			
			////rslt�� �����̸� ���������ε� �� �κ��� �����Ǿ� ����...
			////if(rslt.length() > 0)
			////{
				if(!rslt.equals("T"))
				{
					if(rslt.equals("B"))
					{
						where = where + " and rslt = ''";
						where1 = where1 + " and rslt = ''";
					}
					else
					{
						where = where + " and rslt = '"+ rslt+"'";						
						where1 = where1 + " and rslt = '"+ rslt+"'";
					}
				}
			////}
			anyframe.log.Logger.debug.println("search�� ����=============>"+search);			
	
	
			////search(1:���ǹ�ȣ, 2:�����, 3;�ֹι�ȣ)
			if(search.equals("1"))
			{
				if(key.length() > 0)
				{
					where = where + "  and policy_no like '%"+ key +"%'	";				
					where1 = where1 + "  and policy_no like '%"+ key +"%'	";				
				}	

			}
			else if(search.equals("2"))
			{
				if(key.length() > 0)
				{
					where = where + "  and acct_nm like '%"+ key +"%'	";				
					where1 = where1 + "  and acct_nm like '%"+ key +"%'	";				
				}
			}
			else if(search.equals("3"))
			{
				if(key.length() > 0)
				{
					String keyvalue1 = "";
					keyvalue1 = anyframe.util.StringFormater.replaceStr(key,"-","");
					where = where + "  and payor_ssn like '%"+ keyvalue1 +"%'	";				
					where1 = where1 + "  and payor_ssn like '%"+ keyvalue1 +"%'	";				
				}
			}	
	
	            input.put("page", page);
	            input.put("where", where);            
	            input.put("subwhere", where1);
	            
		     anyframe.log.Logger.debug.println("SQL���� WHERE�� INPUT��-----------------: "+where);	
		     anyframe.log.Logger.debug.println("SQL���� WHERE[1]�� INPUT��-----------------: "+where1);	
	
	            inputCount.put("where", where1);
	
	            DataSet statuschg = manager.findStatuschgList(input);
	            DataSet totalCount = manager.findStatuschg(inputCount);
	
	            request.setAttribute("statuschg", statuschg);
	            request.setAttribute("totalCount", totalCount.getText("count"));
	            request.setAttribute("current", current);
		
		}
	
	
 	   			
            request.setAttribute("fromdate", fromdate);
            request.setAttribute("todate",todate);
            request.setAttribute("modeind",modeind);
            request.setAttribute("srvc_ind",srvc_ind);
            request.setAttribute("rslt", rslt);	            
            request.setAttribute("search", search);
            request.setAttribute("key", key);
            request.setAttribute("searchgubun",searchgubun);
            request.setAttribute("searchgubun1",searchgubun1);
            
            request.setAttribute("policy_apln_no",policy_apln_no);
            request.setAttribute("policy_no",policy_no);
            request.setAttribute("srvc_cd",srvc_cd);
            request.setAttribute("bank_cd",bank_cd);
            request.setAttribute("acct_no",acct_no);
            request.setAttribute("payor_ssn",payor_ssn);
            request.setAttribute("chgstatus",chgstatus);
		
            Logger.debug.println("################ StatuschgAction End ####################");

     		return mapping.findForward("status_chg_list");
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}

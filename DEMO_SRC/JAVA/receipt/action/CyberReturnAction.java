//// modified by wihyuk yi 2005.08.22
////package gtone.home.common.action;
package gtone.changeminer.receipt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.*;
import anyframe.util.*;////StringFormater.fillZero(String,int)

////�߰�����
import anyframe.data.DataSet;
import anyframe.log.*;
import gtone.changeminer.common.utility.*;

////ksps2000
import gtone.changeminer.receipt.manager.AuthManager;
import gtone.changeminer.receipt.manager.CyberRecManager;
import gtone.changeminer.receipt.manager.PlrepaymentsearchManager;
import gtone.changeminer.payment.manager.CybercenterManager;
import gtone.changeminer.payment.manager.ReturnManager;
import gtone.changeminer.payment.manager.PlpaymentManager;

import java.util.*;////StringTokenizer�� ���
import anyframe.util.*;////StringFormater

////����
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

////SMS������
import gtone.changeminer.payment.manager.CyberSmsManager;

////���Ϻ�����
import gtone.changeminer.receipt.manager.PolicychangeManager;
import gtone.changeminer.common.utility.Variable;////prumail.xml���� ���ϰ��



public abstract class CyberReturnAction extends Action 
{


	/**
	 * �α��� �Ǿ������� ���θ� �Ǵ��ϴ� �޽��.
	 * �α��ε��� ���� ������ ��� �α��� �������� �̵�.
	 * �α��ε� ������ ��� doExecute() �޽�� ȣ��. 
	 */

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)throws Exception 
	{

		/**************************************
		 * ����� ksps2000 �˻� - S
	 	 ***************************************/

		DataSet input = new DataSet();
		DataSet input1 = new DataSet();
		DataSet input2 = new DataSet();
		DataSet input3 = new DataSet();
		DataSet input4 = new DataSet();
		DataSet input5 = new DataSet();
		DataSet input6 = new DataSet();
		DataSet input7 = new DataSet();
		DataSet input8 = new DataSet();////KSPS0450
		DataSet input9 = new DataSet();		
		DataSet policyan = new DataSet();	
		
		DataSet input10 = new DataSet();	
		DataSet input11 = new DataSet();	
		DataSet smscu = new DataSet();	
		DataSet realpay = new DataSet();
		
		CybercenterManager manager3 = CybercenterManager.getInstance();		
		CyberRecManager manager = CyberRecManager.getInstance();		
		ReturnManager returns = ReturnManager.getInstance();////�ݼ�
		PlpaymentManager Pmanager = PlpaymentManager.getInstance();////M0181SP1�� ����
		PolicychangeManager mailsend = PolicychangeManager.getInstance();////����
		CyberSmsManager manager2 = CyberSmsManager.getInstance();
		
		String errrtn = "-1";
		String message = "";
		String bankerr = "-1";
		String proc_status = "";
		
		String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");////ó������	
		String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");			
		String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");	
		String message1 = "";
		
		////���ǻ���ϱ�
		SessionManager sessionManager = new SessionManager(request);
		String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
		String emp_no = sessionManager.getString(Constant.SESSION_USERID);
		String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
		
		String proc_emp_no = emp_no;////ó���ڻ��			
		policyan.put("policy_apln_no", policy_apln_no);
		
		////KSPS2000�� �����Ҷ� ���
		String deptcd  		= "INT";
		String init	   		= "     ";		
		String gubun    	= "";////ó������(C,W)
		String reqnum  	= "   ";////��û�Ǽ�
		String fromdt 		=    request.getParameter("indate")	== null ? "" : request.getParameter("indate");////��ȸ��������			
		String policy	 	=    request.getParameter("policy")	== null ? "" : request.getParameter("policy");////���ǹ�ȣ		
		String procdt   		= "        ";////����ó������
		String proctm   	= "      ";////����ó���ð�
		String inout 		= "IN";////����(IN), ����(OUT)
		String procgb  		=  "P3";
		String lvlnum  		= "";////ó������
		String lvlbef   		= "  ";////ó��������
		String mbkcd    	= "  ";////����� �����ڵ�
		String mbkact   	= "               ";////����� ���¹�ȣ
		String cltbk    		=  request.getParameter("bnkcode")	== null ? "" : request.getParameter("bnkcode");////�����ڵ�
		String cltact   		= request.getParameter("bnkacct")	== null ? "" : request.getParameter("bnkacct");////�� ���¹�ȣ
		String cltnum   	= request.getParameter("bnkclt")	== null ? "" : request.getParameter("bnkclt");////�� �ֹι�ȣ
		String procamt  	= request.getParameter("cash")	== null ? "" : request.getParameter("cash");////��ü�ݾ�
			  procamt       = StringFormater.fillZero(StringFormater.replaceStr(procamt,",",""),13);
		String procno   	= "      ";////��ü������ȣ 
		String brltcd   		= "    ";////������
		
		////alertâ�� ���� �ٽ� �ش��������� �ǵ��ư� url
		String returnurl = request.getParameter("returnurl")	== null ? "" : request.getParameter("returnurl");	
		String urlname =  returnurl + "?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy;		
		anyframe.log.Logger.debug.println("���� url�� ��===================>"+urlname);					

		////������Ȯ�� ���μ���
		String musera = "INTUSER";
		String sbkcda = request.getParameter("sbkcda")	== null ? "" : request.getParameter("sbkcda");	
		String sbknoa = request.getParameter("sbknoa")	== null ? "" : request.getParameter("sbknoa");	
		String amount = request.getParameter("amount")	== null ? "" : request.getParameter("amount");	
		String pyrna = request.getParameter("pyrna")	== null ? "" : request.getParameter("pyrna");	
		
		////���ν� M0181SP1�� �����Ұ���
		String opt1 =  request.getParameter("opt1")	== null ? "P3" : request.getParameter("opt1");	
		String regdate  = request.getParameter("regdate")	== null ? "" : request.getParameter("regdate");	
		String cash =  request.getParameter("cash")	== null ? "" : request.getParameter("cash");	
		String bnkclt =  request.getParameter("bnkclt")	== null ? "" : request.getParameter("bnkclt");	
		String bnkcode  = request.getParameter("bnkcode")	== null ? "" : request.getParameter("bnkcode");	
		String bnkacct = request.getParameter("bnkacct")	== null ? "" : request.getParameter("bnkacct");	
		String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");			
		String tproc_emp_no = proc_emp_no.toUpperCase();
		String v_toyear = Util.getTodayToYMD();
		String  to_year = v_toyear.substring(0,8);
		
		String sending_num = "";	  
		String msg = "";
		String url  = "";
		String sendingnum = "";
		String date = "";
		String rtn0450 = "";
		String rtn0450err = "";
		
		////���ν� M0181SP1�� ����
		input.put("deptcd", deptcd);
		input.put("init", init);
		input.put("reqnum", reqnum );
		input.put("fromdt", fromdt );
		input.put("policy", policy );
		input.put("procdt", procdt );
		input.put("proctm", proctm );
		input.put("inout", inout  );
		input.put("procgb", procgb );
		input.put("lvlnum", lvlnum );
		input.put("lvlbef", lvlbef );
		input.put("mbkcd", mbkcd  );
		input.put("mbkact", mbkact );
		input.put("cltbk", "  ");
		input.put("cltact", "               " );
		input.put("cltnum", "             ");
		input.put("procamt", "0000000000000");
		input.put("procno", procno );
		input.put("brltcd", brltcd );
		
		
		
		////ó���� ��ȸ
		/*
		 * ��������� ��ȯ	��û�ݾ��� �� ��������� ������ �̳����� üũ, ��û�ݾ��� �� ū ��� ó������ �Ұ�

		 * 
		 */
		DataSet inputp1  = new DataSet();
		DataSet inputp2  = new DataSet();
		DataSet inputp3  = new DataSet();	


		anyframe.log.Logger.debug.println("ó�� ���μ���.... �ڵ� ==========="+process);	

		String cnvdate = to_year;
		inputp1.put("policy", policy);
		inputp1.put("cnvdate",   cnvdate);
			
		inputp2.put("policy_apln_no", policy_apln_no);
		inputp3.put("proc_emp_no", proc_emp_no);
				

		
		String seladvcnt =  request.getParameter("seladvcnt")	== null ? "0" : request.getParameter("seladvcnt");	
		
		
			if(process.equals("R")||process.equals("Y") ){
				anyframe.log.Logger.debug.println("=============== ó���� ��ȸ �ϱ� ==================");	
						
				PlrepaymentsearchManager manager1 = PlrepaymentsearchManager.getInstance();	

				DataSet plrepaymentsearch 	= manager1.findPlrepaymentsearch(inputp1);
				DataSet payment   = Pmanager.Inpayment(inputp2, inputp3);
	
	
				int pl_prin = plrepaymentsearch.getInt("pl_prin"); ////�������� 
				int pl_int = plrepaymentsearch.getInt("pl_int"); //// ��������
			
							
				int realpay1 = pl_prin + pl_int; 
				int realpay2 = payment.getInt("apln_amt");				
				
						
				if(realpay1 < realpay2){
				
					 message = "[ó������ȸ]���Աݾ��� ������������ �ʰ��Ͽ����ϴ�.";
					msg = message;
					url = urlname;
					request.setAttribute("message", msg);
					request.setAttribute("toURL", url);
					return mapping.findForward("alert");	
					
				}	
	

			}			
		
		
		
		
		////���ο�û�κ�-���� or �ǽð� �����Ҷ�
		if(process.equals("Y"))
		{			
			//// (0701875)2007�� 10�� 16�� �Ⱥ��� : �ߺ���û ����. saveToken �̿�
			//// ���ΰ�ħ ������쳪 ����Ŭ��ó�� �ι� ��û �Ǿ������ �ߺ����ο�û�� ���� �κ�.
			if (!isTokenValid(request)) {
				url = urlname;
				Logger.debug.println("saveToken ���ΰ�ħ ������쳪 ����Ŭ��ó�� �ι� ��û �Ǿ������ ����.");
				request.setAttribute("message", "���ο�û �����߿� �� �ٸ� ���ο�û�� �ߺ���û �Ǿ����Ƿ� ������� �ʽ��ϴ�.");
				request.setAttribute("toURL", url);
				return mapping.findForward("alert");
			}
			resetToken(request); //// ���ǿ� �ִ� ��ū���� �ʱ�ȭ �Ѵ�. �ߺ���û�� ���� if���� �ɸ��� �ϱ� ����.

			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//// (0701875)�������� ������ ���� ����ε� ���̰ų� ó������ �� �ɷ���
			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			DataSet inAppv = new DataSet();
			inAppv.put("policy_apln_no", 	policy_apln_no);

			DataSet outAppv1 = manager3.findAppvProcessStatus(inAppv);
			String appv_cnt 	= outAppv1.getText("appv_cnt");////�����ڵ� �Ϸ� 22, 40, 80�� ���� 0�� ���

			if(!appv_cnt.equals("0")){
				////ó�� �޼���
				msg = "����ε� �� �̰ų� ó�����Դϴ�. Ȯ�� �� ó�����ּ���.";
				url = urlname;
				request.setAttribute("message", msg);
				request.setAttribute("toURL", url);
				return mapping.findForward("alert");
			}
			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			//// (0701875)2007�� 10�� 16�� �Ⱥ��� : ���ο�û ���۽� 22�ڵ带 �ִ´�.
			DataSet newSet = new DataSet();
			newSet.put("policy_apln_no", policy_apln_no);
			newSet.put("proc_emp_no", proc_emp_no);
			newSet.put("proc_status", "22");
			newSet.put("err_msg", message);
			DataSet rtnsaveNew = returns.findRtnsave(newSet);

			input11.put("policy_apln_no", policy_apln_no);
			DataSet selPayment = manager3.findRecei(input11);

			input.put("gubun", "C");
			input.put("lvlnum", "21");
			DataSet ksps2000_21c = manager.findKsps2000(input);						
			
			////sp �α׸� ���� ����... ����
			try
			{
	
			  /*���������ڵ�*/
															 /*
															  * �������		1
															  * ��������		4
															  * �޸麸�������	5
															  * ���ݻ��		7
															  * ��������		6
															  * �߰���������	8
															  * ����ȯ		2
															  * APL��ȯ		3 
															  * Ư��ΰ� 1		A
															  * Ư��ΰ� 2 	B
															  * Ư��ΰ� 3		C 
															  * ��й�ȣ ����     I          
															  */
	 					
						
			  DataSet spinputp  = new DataSet();
	
			  spinputp.put("srvc_cd","1"); ////ó�������ڵ�
			  spinputp.put("sp_nm","KSPS2000"); ////sp��
			  spinputp.put("tran_no",emp_no); ////ó����û�� ��ȣ				
			  spinputp.put("tran_nm",emp_nm); ////ó����û�� ����
			  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
			  spinputp.put("sp_out_put",ksps2000_21c.toString()); ////sp_out_put
	
			  returns.findSpLogsave(spinputp);
	
			}catch(Exception e)
			{
	
			  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
			}
	
			////sp �α׸� ���� ����... ��	
			
			errrtn = "";
			errrtn = ksps2000_21c.getText("rtn");				
			
			////KSPS2000���� (1������Ϸ��û 21W)
			if(errrtn.equals("0") || errrtn.equals("6"))			
			{
				input.put("gubun", "W" );
				input.put("lvlnum", "21");
				input.put("cltbk", cltbk);
				input.put("cltact", cltact);
				input.put("cltnum", cltnum);
				input.put("procamt", procamt);

				DataSet ksps2000_21W = manager.findKsps2000(input);			
				
				////sp �α׸� ���� ����... ����
				try
				{
	
				  /*���������ڵ�*/
																 /*
																  * �������		1
																  * ��������		4
																  * �޸麸�������	5
																  * ���ݻ��		7
																  * ��������		6
																  * �߰���������	8
																  * ����ȯ		2
																  * APL��ȯ		3 
																  * Ư��ΰ� 1		A
																  * Ư��ΰ� 2 	B
																  * Ư��ΰ� 3		C 
																  * ��й�ȣ ����     I          
																  */
	 					
						
				  DataSet spinputp  = new DataSet();
	
				  spinputp.put("srvc_cd","2"); ////ó�������ڵ�
				  spinputp.put("sp_nm","KSPS2000"); ////sp��
				  spinputp.put("tran_no",emp_no); ////ó����û�� ��ȣ				
				  spinputp.put("tran_nm",emp_nm); ////ó����û�� ����
				  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
				  spinputp.put("sp_out_put",ksps2000_21W.toString()); ////sp_out_put
	
				  returns.findSpLogsave(spinputp);
	
				}catch(Exception e)
				{
	
				  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
				}
	
				////sp �α׸� ���� ����... ��
						
				errrtn = "";
				errrtn = ksps2000_21c.getText("rtn");
				
				if(errrtn.equals("0"))
				{

					////WEB DB����(1������ ����)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "21");
					input1.put("err_msg", message);						
					DataSet rtnsavek1 = returns.findRtnsave(input1);
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "0");
					input2.put("err_msg", message);
					DataSet rtnsavek1_1 = returns.findRtnsave1(input2);					
					
					input3.put("deptcd", "INT");
					input3.put("init", tproc_emp_no);
					input3.put("opt1", "P3");
					input3.put("opt2", "U");
					input3.put("policy", policy);
					//// [05-B-353] 2005-08-22 ������. regdate�� ���������� �Ѿ���� �ʾƼ� indate�� ��ü
					input3.put("regdate", indate);
					input3.put("paydate", to_year);
					input3.put("cash", cash);
					input3.put("prmsusp", cash);
					input3.put("susp", "00000000000");
					input3.put("plpay", "00000000000");
					input3.put("tax", "00000000000");
					input3.put("sndseq", "      ");
					input3.put("bnkclt", bnkclt);
					input3.put("bnkcode", bnkcode);
					input3.put("bnkacct", bnkacct);						
					input3.put("agency", "   ");						
					
					input4.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);					
					
					anyframe.log.Logger.debug.println("Action M0181SP1  input3==========="+input3);
					DataSet approval = Pmanager.getApproval(input3, input4, input5);////����,policy_apln_no,proc_emp_no
					
					////			sp �α׸� ���� ����... ����
					try
					{
				
					 /*���������ڵ�*/
					/*
					 * �������		1
					 * ��������		4
					 * �޸麸�������	5
					 * ���ݻ��		7
					 * ��������		6
					 * �߰���������	8
					 * ����ȯ		2
					 * APL��ȯ		3 
					 * Ư��ΰ� 1		A
					 * Ư��ΰ� 2 	B
					 * Ư��ΰ� 3		C 
					 * ��й�ȣ ����     I          
					 */
								 					
													
					 DataSet spinputp  = new DataSet();
				
					 spinputp.put("srvc_cd","2"); ////ó�������ڵ�
					 spinputp.put("sp_nm","M0181SP1"); ////sp��
					 spinputp.put("tran_no",emp_no); ////ó����û�� ��ȣ				
					 spinputp.put("tran_nm",emp_nm); ////ó����û�� ����
					 spinputp.put("sp_in_put",input3.toString()); ////sp_in_put
					 spinputp.put("sp_out_put",approval.toString()); ////sp_out_put
				
					 returns.findSpLogsave(spinputp);
				
					}catch(Exception e)
					{
				
					 System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
					}
				
					////sp �α׸� ���� ����... ��					
					
					
					message1 = "";
					message1 = Util.superTrim(approval.getText("errmsg1")) + Util.superTrim(approval.getText("errmsg2")) + Util.superTrim(approval.getText("errmsg3"));
					//// (0701875)2007.10.16 �Ⱥ���
					//// ���� �޼����� AAAA�� ���Ե� ���ڰ� ������� SMS �߼�.
					anyframe.log.Logger.debug.println("���� ��approval.getText(errmsg1)====>"+approval.getText("errmsg1"));
		////			AAAA�׽�Ʈ
		////			approval.put("errmsg1", "DGAAAA�����ϴ�.");
					if(Util.superTrim(approval.getText("errmsg1")).indexOf("AAAA") != -1) {
						System.out.println("########################## CybercenterAction.java AAAA ������ ���� ���� #############################");
	
						String srvc_gubunc = selPayment.getText("srvc_cd");
						String strGubun = "";
						if(srvc_gubunc.equals("1"))////��������û
						{
							strGubun = "��������û";
						}
						else if(srvc_gubunc.equals("2"))////��������ȯ
						{
							strGubun = "��������ȯ";
						}
						else if(srvc_gubunc.equals("3"))////�ڵ����ⳳ�λ�ȯ
						{
							strGubun = "�ڵ����ⳳ�λ�ȯ";
						}
						else if(srvc_gubunc.equals("4"))////����
						{
							strGubun = "����";
						}
						else if(srvc_gubunc.equals("5"))////�޸麸���
						{
							strGubun = "�޸麸���";
						}
						else if(srvc_gubunc.equals("6"))////��������
						{
							strGubun = "��������";
						}
						else if(srvc_gubunc.equals("7"))////���ݻ��
						{
							strGubun = "���ݻ��";
						}
						else if(srvc_gubunc.equals("8"))////�߰���������
						{
							strGubun = "�߰���������";
						}
	
						String payor_nm = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm"))); //// ����
	
						///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						//// SMS �߼�
						///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						//// ���� ��ȸ���� �ڵ��� ������ ���ִ� ��� ����Ʈ�� ������.
						DataSet smsSet = new DataSet();
						smsSet.put("page", "0");
						smsSet.put("where", " and hand_phone_yn = 'Y'");
						smsSet.put("subwhere", "");
	
						AuthManager managerSms = AuthManager.getInstance();
						DataSet authval = managerSms.findAuth(smsSet);
	
						anyframe.log.Logger.debug.println("������ ������ ���� �ʵ� strGubun : "+strGubun);
	
						//// SMS �߼�
						for(int i=0;i<authval.getCount("emp_no");i++) {
	
							//// ex) ���̹� ���߼��� Ȯ�ο�� 100500000 ȫ�浿, ������� (or�ؾ�, �޸�) 00000�� [��Ƽ�����̹�]���ο�û�� AAAA�� �߰ߵǾ����ϴ�.");" +
							String strMsg = "[��Ƽ�����̹�]���߼���Ȯ��" + policy + payor_nm + " " + strGubun + Integer.parseInt(procamt) + "�� AAAA�߰�";
	
							DataSet sendSmsInput = new DataSet();
							sendSmsInput.put("RECEIVER_MOBILE", authval.getText("hand_phone", i));
							sendSmsInput.put("CUS_CALL_BACK",   "15883374");
							sendSmsInput.put("CUS_MSG",         strMsg);
							sendSmsInput.put("TRAN_ETC1",       to_year);
							sendSmsInput.put("TRAN_ETC2",       "");
							sendSmsInput.put("TRAN_ETC3",       "CU");
											
											
							////2007.06.14 �߰�....
							/*���������ڵ�*/
									   /*
										* �������		1
										* ��������		4
										* �޸麸�������	5
										* ���ݻ��		7
										* ��������		6
										* �߰���������	8
										* ����ȯ		2
										* APL��ȯ		3 
										* Ư��ΰ� 1		A
										* Ư��ΰ� 2 	B
										* Ư��ΰ� 3		C 
										* ��й�ȣ ����     I          
										*/
							sendSmsInput.put("srvc_cd", srvc_gubunc);  ////�����ڵ�
	            
							sendSmsInput.put("policy_no", policy); ////���ǹ�ȣ
							sendSmsInput.put("tran_ssn",authval.getText("emp_no", i)); ////ó����û���ֹι׻��
							sendSmsInput.put("tran_nm",authval.getText("emp_nm", i));  ////ó����û�ڼ��� 
	
							manager2.sendSimpleSms(sendSmsInput);
						}
	
						///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						//// �̸��� �߼�
						///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						//// ���� ��ȸ���� �̸��� ������ ���ִ� ��� ����Ʈ�� ������.
						smsSet = new DataSet();
						smsSet.put("page", "0");
						smsSet.put("where", " and email_yn = 'Y'");
						smsSet.put("subwhere", "");
	
						authval = managerSms.findAuth(smsSet);
	
						////�̸��� �߼�
						for(int i=0;i<authval.getCount("emp_no");i++) {
							//// ex) ���̹� ���߼��� Ȯ�ο�� 100500000 ȫ�浿, ������� (or�ؾ�, �޸�) 00000�� [��Ƽ�����̹�]���ο�û�� AAAA�� �߰ߵǾ����ϴ�.");" +
							String strSubject = policy + " " + payor_nm + ", " + strGubun + " " + Integer.parseInt(procamt) + "�� [��Ƽ�����̹�]���ο�û�� AAAA�� �߰ߵǾ����ϴ�.";
							//// ex)
							////	���̹� ���߼��� ���ɼ� ������ Ȯ�� �ٶ��ϴ�.
							////	���� : 100500000
							////	����ڸ� : ȫ�浿
							////	������� (or �ؾ�, �޸�) 00000��
							////	ó���� : OOO
							////	ó���ð� OO:OO:OO
	
							String strContent = strSubject + "|" + "���̹� ���߼��� ���ɼ� ������ Ȯ�� �ٶ��ϴ�. <br>"
														+ "���� : " + policy + "<br>"
														+ "����ڸ� : " + payor_nm + "<br>"
														+ strGubun + " : " + Integer.parseInt(procamt) + "��<br>"
														+ "ó���� : " + authval.getText("emp_nm", i) + "<br>"
														+ "ó���ð� : " + gtone.changeminer.common.utility.Utility.getToday();
	
							DataSet emailSet = new DataSet();
							////���Ϻ�����(��)
							emailSet.put("param1", "05");
							////emailSet.put("param2", "12"); //// ����
							emailSet.put("param2", "01"); //// �Ǽ���
							emailSet.put("param3", "00000029");
							emailSet.put("to_name", authval.getText("emp_nm", i));//// �̸�
							emailSet.put("to_email_addr", authval.getText("email", i));//// �̸���
							emailSet.put("content", strContent); //// ����
	
							anyframe.log.Logger.debug.println("������ ������ ���� �ʵ� CyberAction Input : "+emailSet);
							DataSet mailcu = mailsend.sendSimpleMail(emailSet);
						}
	
						////������ �ݼۻ��� ���� ������ �Ϸ�
					}

					////M0181SP1�� ���� ������ output���� ���۹�ȣ�� ����
					sending_num = approval.getText("sndseq");////���۹�ȣ
					input6.put("policy_apln_no", policy_apln_no);
					input6.put("sending_num", sending_num);
					input6.put("pay_dt", Util.getTodayToYMD().substring(0,8));
					DataSet sending = manager.Sendingsave(input6);////���۹�ȣ ����
					
					
					realpay.put("policy_apln_no", policy_apln_no);
					realpay.put("pay_amt", approval.getText("netpay"));////�����ޱ�
					
					errrtn = approval.getText("rtn");
					
					if(errrtn.equals("0"))////KSPS2000����(����,HOST:80 ó������)
					{
						DataSet netpay = manager3.Realpaysave(realpay);////�����ޱ�����
						
						////KSPS2000 ����(����,HOSTó������ :80)
						input.put("gubun", "W" );
						input.put("lvlnum", "80");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);
						DataSet ksps2000_80 = manager.findKsps2000(input);	
						
						////sp �α׸� ���� ����... ����
						try
						{
	
						  /*���������ڵ�*/
																		 /*
																		  * �������		1
																		  * ��������		4
																		  * �޸麸�������	5
																		  * ���ݻ��		7
																		  * ��������		6
																		  * �߰���������	8
																		  * ����ȯ		2
																		  * APL��ȯ		3 
																		  * Ư��ΰ� 1		A
																		  * Ư��ΰ� 2 	B
																		  * Ư��ΰ� 3		C 
																		  * ��й�ȣ ����     I          
																		  */
	 					
						
						  DataSet spinputp  = new DataSet();
	
						  spinputp.put("srvc_cd","2"); ////ó�������ڵ�
						  spinputp.put("sp_nm","KSPS2000"); ////sp��
						  spinputp.put("tran_no",emp_no); ////ó����û�� ��ȣ				
						  spinputp.put("tran_nm",emp_nm); ////ó����û�� ����
						  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						  spinputp.put("sp_out_put",ksps2000_80.toString()); ////sp_out_put
	
						  returns.findSpLogsave(spinputp);
	
						}catch(Exception e)
						{
	
						  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
						}
	
						////sp �α׸� ���� ����... ��
						
						////WEB DB����(����-HOSTó������ 80)
						input1.put("policy_apln_no", policy_apln_no);
						input1.put("proc_emp_no", proc_emp_no);
						input1.put("proc_status", "80");
						input1.put("err_msg", message1);						
						DataSet rtnsave3 = returns.findRtnsave(input1);
						
						input2.put("policy_apln_no", policy_apln_no);				
						input2.put("proc_status", "0");
						input2.put("err_msg", message1);
						DataSet rtnsave3_1 = returns.findRtnsave1(input2);
						
						
						////WB_PAYMENT���� ������ȣ�� Ű������ �ش� �ڷḦ Search
						String cltnumt = "";
						cltnumt = cltnum.substring(0,6)+"-"+cltnum.substring(6);
						
						String payor_nm = Util.superTrim(selPayment.getText("payor_nm").trim());
						
						String v_to_mail = selPayment.getText("payor_email");
						String mapping1 = "";
						String apln_dt = selPayment.getText("apln_dt").substring(0,10);							
						apln_dt = apln_dt.substring(0,4) +" �� " + StringFormater.removeZero(apln_dt.substring(5,7)) +" �� "+ StringFormater.removeZero(apln_dt.substring(8,10)) +" ��";
						
						to_year = null;
						v_toyear = Util.getTodayToYMD();
						to_year = v_toyear.substring(0,8);
						String pay_dt  = "";
						pay_dt = to_year;
						if(pay_dt.length() == 8)
						{
							pay_dt = pay_dt.substring(0,4) + " �� "+ StringFormater.removeZero(pay_dt.substring(4,6)) +" �� "+ StringFormater.removeZero(pay_dt.substring(6,8)) +" ��";
						}							
						String apln_amt = "";
						apln_amt = selPayment.getText("apln_amt");
						apln_amt = Util.addComma(apln_amt);
						mapping1 = payor_nm +"|"+ selPayment.getText("srvc_name") +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+ apln_dt+"|"+pay_dt+"|"+apln_amt + "��" +"|"+ selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
													
						////���Ϻ�����(��)
						input10.put("v_mail_type", "03");
						input10.put("v_mail_type_seq", Variable.get("email-id.cyber03"));////54
						input10.put("v_channel_code", "00000030");
						input10.put("v_member_id", cltnum);////���ֹι�ȣ
						input10.put("v_to_name", payor_nm);////����
						input10.put("v_to_email",  selPayment.getText("payor_email"));////���̸���
						
						
						input10.put("v_mapping", mapping1);
						input10.put("v_lp_code", selPayment.getText("lp_id"));
						input10.put("v_policy_number", selPayment.getText("policy_no"));
						input10.put("v_channel", "cyber");
						input10.put("v_ilips_client_id", "");
						
						anyframe.log.Logger.debug.println("���� ������ ���� �ʵ�  : "+input10);
						DataSet mailcu = mailsend.sendMail(input10); 
						request.setAttribute("mailcu",mailcu);	
													
						////LP���� ���� ������
						input10.put("v_mail_type", "03");
						input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
						input10.put("v_channel_code", "00000030");
						input10.put("v_member_id", cltnum);
						
						input10.put("v_to_email", selPayment.getText("lp_email"));
						
						mapping1 = "";
						String lpname = "";							
						lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname").trim()));
						
						input10.put("v_to_name", lpname);////LP��
						
						mapping1 = lpname +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "��" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
						input10.put("v_mapping", mapping1);
						
						anyframe.log.Logger.debug.println("LP���� ���� ������ ���� �ʵ�  : "+input10);
						input10.put("v_lp_code", selPayment.getText("lp_id"));		
						DataSet maillp = mailsend.sendMail(input10); 
						request.setAttribute("maillp",maillp);				
						
						////SM���� ���� ������
						/*
						input10.put("v_mail_type", "03");
						input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
						input10.put("v_channel_code", "00000030");
						input10.put("v_member_id", cltnum);
													
						input10.put("v_to_email", selPayment.getText("sm_email"));
						
						mapping1 = "";
						String sm_name = "";
						////sm_name = selPayment.getText("sm_name");
						sm_name = Util.superTrim(ToolString.hanToFull(selPayment.getText("sm_name")));
						
						mapping1 = sm_name +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "��" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
						input10.put("v_mapping", mapping1);
						
						anyframe.log.Logger.debug.println("SM���� ���� ������ ���� �ʵ�  : "+input10);
						input10.put("v_lp_code", selPayment.getText("sm_code"));		
						DataSet mailsm = mailsend.sendMail(input10); 
						request.setAttribute("mailsm",mailsm);								
						*/
						
						////������ SMS������
									
						String owner_mobile  	= selPayment.getText("payor_phone");////�ڵ���
						String lp_code       	= "";////LP���
						String amt           	= Util.addComma(StringFormater.removeZero(selPayment.getText("apln_amt")));////�ݾ�
						String gubun1         	= selPayment.getText("paycd");////��ȯ����					
						String sms_code = "";
						String srvc_gubunc = "";
						String owner = "";
						owner = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm")));
						
						srvc_gubunc = selPayment.getText("srvc_cd");
						if(srvc_gubunc.equals("1"))////��������û
						{
							sms_code = "5";
						}
						else if(srvc_gubunc.equals("2"))////��������ȯ
						{
							sms_code = "9";
						}
						else if(srvc_gubunc.equals("3"))////�ڵ����ⳳ�λ�ȯ
						{
							sms_code = "11";
						}
						else if(srvc_gubunc.equals("4"))////����
						{
							sms_code = "6";
						}
						else if(srvc_gubunc.equals("5"))////�޸麸���
						{
							sms_code = "25";
						}
						else if(srvc_gubunc.equals("6"))////��������
						{
							sms_code = "8";
						}
						else if(srvc_gubunc.equals("7"))////���ݻ��
						{
							sms_code = "7";
						}
/**
						else if(srvc_gubunc.equals("8"))////�߰���������
						{
							sms_code = "22";
						}
**/
						
						String indate1 = "";
						indate1 = selPayment.getText("policy_apln_no").substring(0,8);
						
						smscu.put("v_sms_code",  		sms_code);////SMS �޽��� �����ڵ�
						smscu.put("v_success_yn",  	"0");////0-����,1-����
						smscu.put("v_policy_no",  	selPayment.getText("policy_no"));
						smscu.put("v_name",  			owner);
						smscu.put("v_owner",  		owner);
						smscu.put("v_owner_mobile",  	owner_mobile);
						smscu.put("v_lp_code",  		lp_code);
						smscu.put("v_amt",  			amt);
						smscu.put("v_gubun",  		gubun1);
						
						smscu.put("tran_etc1",  		indate1);////�Է³�¥
						smscu.put("tran_etc2",  		selPayment.getText("policy_apln_no"));////���� ����
						smscu.put("v_pr",  			"CU");					
						DataSet sms_ins_cu = manager2.findClientSms(smscu);////CU��								
						
						////ó�� ���� �޼���
						message = "���������� ���εǾ����ϴ�.";
						msg = message;
		            			url = urlname;
		            			request.setAttribute("message", msg);	
		            			request.setAttribute("toURL", url);	
		            			return mapping.findForward("alert");														
					}
					else if(errrtn.equals("3"))////KSPS2000����-����ó������:50
					{
						input.put("gubun", "W" );
						input.put("lvlnum", "50");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);
						DataSet ksps2000_50 = manager.findKsps2000(input);	
						
						////sp �α׸� ���� ����... ����
						try
						{
	
						  /*���������ڵ�*/
																		 /*
																		  * �������		1
																		  * ��������		4
																		  * �޸麸�������	5
																		  * ���ݻ��		7
																		  * ��������		6
																		  * �߰���������	8
																		  * ����ȯ		2
																		  * APL��ȯ		3 
																		  * Ư��ΰ� 1		A
																		  * Ư��ΰ� 2 	B
																		  * Ư��ΰ� 3		C 
																		  * ��й�ȣ ����     I          
																		  */
	 					
						
						  DataSet spinputp  = new DataSet();
	
						  spinputp.put("srvc_cd","2"); ////ó�������ڵ�
						  spinputp.put("sp_nm","KSPS2000"); ////sp��
						  spinputp.put("tran_no",emp_no); ////ó����û�� ��ȣ				
						  spinputp.put("tran_nm",emp_nm); ////ó����û�� ����
						  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						  spinputp.put("sp_out_put",ksps2000_50.toString()); ////sp_out_put
	
						  returns.findSpLogsave(spinputp);
	
						}catch(Exception e)
						{
	
						  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
						}
	
						////sp �α׸� ���� ����... ��
						
						////WEB DB����(����-HOSTó�� ���� 50)
						input1.put("policy_apln_no", policy_apln_no);
						input1.put("proc_emp_no", proc_emp_no);
						input1.put("proc_status", "50");
						input1.put("err_msg", message1);						
						DataSet rtnsave4 = returns.findRtnsave(input1);
						
						input2.put("policy_apln_no", policy_apln_no);				
						input2.put("proc_status", "3");
						input2.put("err_msg", message1);
						DataSet rtnsave4_1 = returns.findRtnsave1(input2);
						
						////ó�� ���� �޼���
						message = "���� ó�� �����Դϴ�. �����ð��� �ٽ� Ȯ���ϼ���.";
						msg = message;
		            			url = urlname;
		            			request.setAttribute("message", message1);	
		            			request.setAttribute("toURL", url);	
		            			return mapping.findForward("alert");																										
					}
					else if(errrtn.equals("1") || errrtn.equals("2"))////FILE OPEN ERROR, DATA VALID CHECK����, ����ó�� �� CAPSIL����				
					{
						////KSPS2000���� (��Ÿ���� :99) ����ó�� ��,�� �����߻� ������ Ȯ���ʿ�	
						input.put("gubun", "W" );
						input.put("lvlnum", "99");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);
						DataSet ksps2000_99 = manager.findKsps2000(input);	
						
						////sp �α׸� ���� ����... ����
						try
						{
	
						  /*���������ڵ�*/
																		 /*
																		  * �������		1
																		  * ��������		4
																		  * �޸麸�������	5
																		  * ���ݻ��		7
																		  * ��������		6
																		  * �߰���������	8
																		  * ����ȯ		2
																		  * APL��ȯ		3 
																		  * Ư��ΰ� 1		A
																		  * Ư��ΰ� 2 	B
																		  * Ư��ΰ� 3		C 
																		  * ��й�ȣ ����     I          
																		  */
	 					
						
						  DataSet spinputp  = new DataSet();
	
						  spinputp.put("srvc_cd","2"); ////ó�������ڵ�
						  spinputp.put("sp_nm","KSPS2000"); ////sp��
						  spinputp.put("tran_no",emp_no); ////ó����û�� ��ȣ				
						  spinputp.put("tran_nm",emp_nm); ////ó����û�� ����
						  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						  spinputp.put("sp_out_put",ksps2000_99.toString()); ////sp_out_put
	
						  returns.findSpLogsave(spinputp);
	
						}catch(Exception e)
						{
	
						  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
						}
	
						////sp �α׸� ���� ����... ��
						
						////WEB DB����(��Ÿ ���� -99)
						input1.put("policy_apln_no", policy_apln_no);
						input1.put("proc_emp_no", proc_emp_no);
						input1.put("proc_status", "99");
						input1.put("err_msg", message1);						
						DataSet rtnsave5 = returns.findRtnsave(input1);
						
						input2.put("policy_apln_no", policy_apln_no);				
						input2.put("proc_status", "1");
						input2.put("err_msg", message1);
						DataSet rtnsave5_1 = returns.findRtnsave1(input2);
						
						////ó�� ���� �޼���
						message = "����ó�� ��,�� �����Դϴ�. ������ Ȯ�� �ʿ��մϴ�.";
						msg = message;
		            			url = urlname;
		            			request.setAttribute("message", message1);	
		            			request.setAttribute("toURL", url);	
		            			return mapping.findForward("alert");																																		
					}
					else if(errrtn.equals("4"))////�������
					{
						////KSPS2000����(����ó����� ���� & ���������� 61), WB_PAYMENT������ �ݼ����� ó��
						input.put("gubun", "W" );
						input.put("lvlnum", "61");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);
						DataSet ksps2000_61 = manager.findKsps2000(input);	
						
						////sp �α׸� ���� ����... ����
						try
						{
	
						  /*���������ڵ�*/
																		 /*
																		  * �������		1
																		  * ��������		4
																		  * �޸麸�������	5
																		  * ���ݻ��		7
																		  * ��������		6
																		  * �߰���������	8
																		  * ����ȯ		2
																		  * APL��ȯ		3 
																		  * Ư��ΰ� 1		A
																		  * Ư��ΰ� 2 	B
																		  * Ư��ΰ� 3		C 
																		  * ��й�ȣ ����     I          
																		  */
	 					
						
						  DataSet spinputp  = new DataSet();
	
						  spinputp.put("srvc_cd","2"); ////ó�������ڵ�
						  spinputp.put("sp_nm","KSPS2000"); ////sp��
						  spinputp.put("tran_no",emp_no); ////ó����û�� ��ȣ				
						  spinputp.put("tran_nm",emp_nm); ////ó����û�� ����
						  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						  spinputp.put("sp_out_put",ksps2000_61.toString()); ////sp_out_put
	
						  returns.findSpLogsave(spinputp);
	
						}catch(Exception e)
						{
	
						  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
						}
	
						////sp �α׸� ���� ����... ��
						
						////WEB DB����(����ó����� ����-61)
						input1.put("policy_apln_no", policy_apln_no);
						input1.put("proc_emp_no", proc_emp_no);
						input1.put("proc_status", "61");
						input1.put("err_msg", message1);						
						DataSet rtnsave6 = returns.findRtnsave(input1);
						
						input2.put("policy_apln_no", policy_apln_no);				
						input2.put("proc_status", "2");
						input2.put("err_msg", message1);
						DataSet rtnsave6_1 = returns.findRtnsave1(input2);
						
						////ó�� ���� �޼���
						message = "�ش��û�� ����ó�� �����Դϴ�. �ܰ�Ȯ�ι� ������ϼ���.";
						msg = message1;
		            			url = urlname;
		            			request.setAttribute("message", msg);	
		            			request.setAttribute("toURL", url);	
		            			return mapping.findForward("alert");																																									
					}
					else if(errrtn.equals("5"))////HOSTó������ (DISB, PPAY,MODP)
					{
						input.put("gubun", "W" );
						input.put("lvlnum", "70");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);
						DataSet ksps2000_80 = manager.findKsps2000(input);	
						
						////sp �α׸� ���� ����... ����
						try
						{
	
						  /*���������ڵ�*/
																		 /*
																		  * �������		1
																		  * ��������		4
																		  * �޸麸�������	5
																		  * ���ݻ��		7
																		  * ��������		6
																		  * �߰���������	8
																		  * ����ȯ		2
																		  * APL��ȯ		3 
																		  * Ư��ΰ� 1		A
																		  * Ư��ΰ� 2 	B
																		  * Ư��ΰ� 3		C 
																		  * ��й�ȣ ����     I          
																		  */
	 					
						
						  DataSet spinputp  = new DataSet();
	
						  spinputp.put("srvc_cd","2"); ////ó�������ڵ�
						  spinputp.put("sp_nm","KSPS2000"); ////sp��
						  spinputp.put("tran_no",emp_no); ////ó����û�� ��ȣ				
						  spinputp.put("tran_nm",emp_nm); ////ó����û�� ����
						  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						  spinputp.put("sp_out_put",ksps2000_80.toString()); ////sp_out_put
	
						  returns.findSpLogsave(spinputp);
	
						}catch(Exception e)
						{
	
						  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
						}
	
						////sp �α׸� ���� ����... ��
						
						////WEB DB����(���༺��+HOST����)
						input1.put("policy_apln_no", policy_apln_no);
						input1.put("proc_emp_no", proc_emp_no);
						input1.put("proc_status", "70");
						input1.put("err_msg", message1);						
						DataSet rtnsave7 = returns.findRtnsave(input1);
						
						input2.put("policy_apln_no", policy_apln_no);				
						input2.put("proc_status", "3");////�������� ó��
						input2.put("err_msg", message1);
						DataSet rtnsave7_1 = returns.findRtnsave1(input2);
						
						////ó�� ���� �޼���
						message = "HOST ó�� �����Դϴ�. �����ڿ��� �����ϼ���.";
						msg = message1;
		            			url = urlname;
		            			request.setAttribute("message", msg);	
		            			request.setAttribute("toURL", url);	
		            			return mapping.findForward("alert");																																																	
					}					
					
				}////�������� ó��												
			}////0�� 6�϶�
			else if(errrtn.equals("5"))
			{
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "2");
					input1.put("err_msg", message1);						
					DataSet rtnsave2 = returns.findRtnsave(input1);
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "2");
					input2.put("err_msg", message1);
					DataSet rtnsave2_2 = returns.findRtnsave1(input2);						
					////ó�� ���� �޼���
					message = "�������Ǿ� ó�����ΰ��� �����մϴ�..";
					msg = message1;
			       	url = urlname;
			       	request.setAttribute("message", msg);	
			       	request.setAttribute("toURL", url);	
			       	return mapping.findForward("alert");										
			}
			else if(errrtn.equals("1"))
			{
				
					input.put("gubun", "W" );
					input.put("lvlnum", "99");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);
					DataSet ksps2000_80 = manager.findKsps2000(input);	
					
				////sp �α׸� ���� ����... ����
				try
				{
	
				  /*���������ڵ�*/
																 /*
																  * �������		1
																  * ��������		4
																  * �޸麸�������	5
																  * ���ݻ��		7
																  * ��������		6
																  * �߰���������	8
																  * ����ȯ		2
																  * APL��ȯ		3 
																  * Ư��ΰ� 1		A
																  * Ư��ΰ� 2 	B
																  * Ư��ΰ� 3		C 
																  * ��й�ȣ ����     I          
																  */
	 					
						
				  DataSet spinputp  = new DataSet();
	
				  spinputp.put("srvc_cd","2"); ////ó�������ڵ�
				  spinputp.put("sp_nm","KSPS2000"); ////sp��
				  spinputp.put("tran_no",emp_no); ////ó����û�� ��ȣ				
				  spinputp.put("tran_nm",emp_nm); ////ó����û�� ����
				  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
				  spinputp.put("sp_out_put",ksps2000_80.toString()); ////sp_out_put
	
				  returns.findSpLogsave(spinputp);
	
				}catch(Exception e)
				{
	
				  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
				}
	
				////sp �α׸� ���� ����... ��
							
					////WEB DB����(��Ÿ ���� -99)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "99");
					input1.put("err_msg", message1);						
					DataSet rtnsave8 = returns.findRtnsave(input1);
						
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "1");
					input2.put("err_msg", message1);
					DataSet rtnsave8_1 = returns.findRtnsave1(input2);
							
					////ó�� ���� �޼���
					message = "����ó�� ��,�� �����Դϴ�. ������ Ȯ�� �ʿ��մϴ�.";
					msg = message1;
			       	url = urlname;
			            	request.setAttribute("message", msg);	
			            	request.setAttribute("toURL", url);	
			            	return mapping.findForward("alert");																													
				
			}
		}////PROCESS�� Y�ΰ��
		else if(process.equals("R"))////�������ΰ�� �ڵ� PGMó���� �����϶� ����ó��
		{
			DataSet wbprostatus = manager.findProcstatus(policyan);
			proc_status = "";
			proc_status = wbprostatus.getText("proc_status");
			
			////if(proc_status.equals("50") || proc_status.equals("10"))////WB_PROCESS�� ����(50)�ΰ�� ó�� or �����ΰ��(�ǽð��̿��� ���)
			////{	
				////KSPS0450�� ó���ϱ� ���� ó����ƾ			
				DataSet sendall = manager.findSend(policyan);	
				sendingnum = sendall.getText("sending_num");////���۹�ȣ
				date = sendall.getText("date");////��������
				
				//// [05-B-353] 2005-08-22 ������. ��ȸ/�а���� ���� ����. �μ����������
				input7.put("musera", "INTUSER");
				input7.put("snddate", date);
				input7.put("sndseq", sendingnum);
				DataSet ksps0450 = manager.findIsaogong(input7);////KSPS0450����
				
				rtn0450 = ksps0450.getText("rtn");
				rtn0450err = ksps0450.getText("errmsg");
				
				if(rtn0450.equals("1") || rtn0450.equals("3"))
				{
					message = "���α׷������� ������ �������Դϴ�. �����ڿ��� �����ϼ���.";
					msg = rtn0450err;
	            			url = urlname;
	            			request.setAttribute("message", msg);	
	            			request.setAttribute("toURL", url);	
	            			return mapping.findForward("alert");
				}
				else if(rtn0450.equals("4"))////��������� ���
				{
					input.put("gubun", "W" );
					input.put("lvlnum", "60");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);
	
					DataSet ksps2000_61 = manager.findKsps2000(input);		
					
					////sp �α׸� ���� ����... ����
					try
					{
	
					  /*���������ڵ�*/
																	 /*
																	  * �������		1
																	  * ��������		4
																	  * �޸麸�������	5
																	  * ���ݻ��		7
																	  * ��������		6
																	  * �߰���������	8
																	  * ����ȯ		2
																	  * APL��ȯ		3 
																	  * Ư��ΰ� 1		A
																	  * Ư��ΰ� 2 	B
																	  * Ư��ΰ� 3		C 
																	  * ��й�ȣ ����     I          
																	  */
	 					
						
					  DataSet spinputp  = new DataSet();
	
					  spinputp.put("srvc_cd","2"); ////ó�������ڵ�
					  spinputp.put("sp_nm","KSPS2000"); ////sp��
					  spinputp.put("tran_no",emp_no); ////ó����û�� ��ȣ				
					  spinputp.put("tran_nm",emp_nm); ////ó����û�� ����
					  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
					  spinputp.put("sp_out_put",ksps2000_61.toString()); ////sp_out_put
	
					  returns.findSpLogsave(spinputp);
	
					}catch(Exception e)
					{
	
					  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
					}
	
					////sp �α׸� ���� ����... ��			
					
					errrtn = "";
					errrtn = ksps2000_61.getText("rtn");				
					if(errrtn.equals("0"))
					{
						input1.put("policy_apln_no", policy_apln_no);
						input1.put("proc_emp_no", proc_emp_no);
						input1.put("proc_status", "60");
						input1.put("err_msg", rtn0450err);						
						DataSet rtnsavek9 = returns.findRtnsave(input1);
						
						input2.put("policy_apln_no", policy_apln_no);				
						input2.put("proc_status", "2");
						input2.put("err_msg", rtn0450err);
						DataSet rtnsavek9_1 = returns.findRtnsave1(input2);					
					}////WEB DB����(����ó����� ����-61									
				}else if(rtn0450.equals("0"))////KSPS0450������ ���ϰ��� 0�ΰ��(��������ó��)
				{
					input3.put("deptcd", "INT");
					input3.put("init", tproc_emp_no);
					input3.put("opt1", "P3");
					input3.put("opt2", "H");
					input3.put("policy", policy);
					//// [05-B-353] 2005-08-22 ������. regdate�� ���������� �Ѿ���� �ʾƼ� indate�� ��ü
					input3.put("regdate", indate);
					input3.put("paydate", to_year);
					input3.put("cash", cash);
					input3.put("prmsusp", cash);
					input3.put("susp", "00000000000");
					input3.put("plpay", "00000000000");
					input3.put("tax", "00000000000");
					input3.put("sndseq", "      ");
					input3.put("bnkclt", bnkclt);
					input3.put("bnkcode", bnkcode);
					input3.put("bnkacct", bnkacct);						
					input3.put("agency", "   ");						
										
					input5.put("proc_emp_no", proc_emp_no);
					
					anyframe.log.Logger.debug.println("�����ΰ�� M0181SP1  input3==========="+input3);
					DataSet approval3 = Pmanager.getApproval(input3, policyan, input5);////����,policy_apln_no,proc_emp_no
					
					
					////			sp �α׸� ���� ����... ����
					try
					{
				
					 /*���������ڵ�*/
					/*
					 * �������		1
					 * ��������		4
					 * �޸麸�������	5
					 * ���ݻ��		7
					 * ��������		6
					 * �߰���������	8
					 * ����ȯ		2
					 * APL��ȯ		3 
					 * Ư��ΰ� 1		A
					 * Ư��ΰ� 2 	B
					 * Ư��ΰ� 3		C 
					 * ��й�ȣ ����     I          
					 */
								 					
													
					 DataSet spinputp  = new DataSet();
				
					 spinputp.put("srvc_cd","2"); ////ó�������ڵ�
					 spinputp.put("sp_nm","M0181SP1"); ////sp��
					 spinputp.put("tran_no",emp_no); ////ó����û�� ��ȣ				
					 spinputp.put("tran_nm",emp_nm); ////ó����û�� ����
					 spinputp.put("sp_in_put",input3.toString()); ////sp_in_put
					 spinputp.put("sp_out_put",approval3.toString()); ////sp_out_put
				
					 returns.findSpLogsave(spinputp);
				
					}catch(Exception e)
					{
				
					 System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
					}
				
					////sp �α׸� ���� ����... ��					
					
					
					
					message1 = "";
					message1 = Util.superTrim(approval3.getText("errmsg1")) + Util.superTrim(approval3.getText("errmsg2")) + Util.superTrim(approval3.getText("errmsg3"));
					
					////M0181SP1�� ���� ������ output���� ���۹�ȣ�� ����
					sending_num = approval3.getText("sndseq");////���۹�ȣ
					input6.put("policy_apln_no", policy_apln_no);
					input6.put("sending_num", sending_num);
					input6.put("pay_dt", Util.getTodayToYMD().substring(0,8));
					DataSet sending = manager.Sendingsave(input6);////���۹�ȣ ����
					
					realpay.put("policy_apln_no", policy_apln_no);
					realpay.put("pay_amt", approval3.getText("netpay"));////�����ޱ�
					
					errrtn = approval3.getText("rtn");
					
					if(errrtn.equals("0"))////�������� ó���Ȱ��
					{
						DataSet netpay = manager3.Realpaysave(realpay);////�����ޱ�����
						
						////KSPS2000 ����(����,HOSTó������ :80)
						input.put("gubun", "W" );
						input.put("lvlnum", "80");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);
						DataSet ksps2000_80 = manager.findKsps2000(input);	
						
						////sp �α׸� ���� ����... ����
						try
						{
	
						  /*���������ڵ�*/
																		 /*
																		  * �������		1
																		  * ��������		4
																		  * �޸麸�������	5
																		  * ���ݻ��		7
																		  * ��������		6
																		  * �߰���������	8
																		  * ����ȯ		2
																		  * APL��ȯ		3 
																		  * Ư��ΰ� 1		A
																		  * Ư��ΰ� 2 	B
																		  * Ư��ΰ� 3		C 
																		  * ��й�ȣ ����     I          
																		  */
	 					
						
						  DataSet spinputp  = new DataSet();
	
						  spinputp.put("srvc_cd","2"); ////ó�������ڵ�
						  spinputp.put("sp_nm","KSPS2000"); ////sp��
						  spinputp.put("tran_no",emp_no); ////ó����û�� ��ȣ				
						  spinputp.put("tran_nm",emp_nm); ////ó����û�� ����
						  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						  spinputp.put("sp_out_put",ksps2000_80.toString()); ////sp_out_put
	
						  returns.findSpLogsave(spinputp);
	
						}catch(Exception e)
						{
	
						  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
						}
	
						////sp �α׸� ���� ����... ��
						
						////WEB DB����(����-HOSTó������ 80)
						input1.put("policy_apln_no", policy_apln_no);
						input1.put("proc_emp_no", proc_emp_no);
						input1.put("proc_status", "80");
						input1.put("err_msg", message1);						
						DataSet rtnsavek10 = returns.findRtnsave(input1);
						
						input2.put("policy_apln_no", policy_apln_no);				
						input2.put("proc_status", "0");
						input2.put("err_msg", message1);
						DataSet rtnsavek10_1 = returns.findRtnsave1(input2);
						
						////WB_PAYMENT���� ������ȣ�� Ű������ �ش� �ڷḦ Search
						String cltnumt = "";
						cltnumt = cltnum.substring(0,6)+"-"+cltnum.substring(6);
						input11.put("policy_apln_no", policy_apln_no);
						
						DataSet selPayment = manager3.findRecei(input11);
						
						String payor_nm = Util.superTrim(selPayment.getText("payor_nm").trim());
						String v_to_mail = selPayment.getText("payor_email");
						String mapping1 = "";
						String apln_dt = selPayment.getText("apln_dt").substring(0,10);							
						apln_dt = apln_dt.substring(0,4) +" �� " + apln_dt.substring(5,7) +" �� "+ apln_dt.substring(8,10) +" ��";
						
						to_year = null;
						v_toyear = Util.getTodayToYMD();
						to_year = v_toyear.substring(0,8);
						String pay_dt  = "";
						pay_dt = to_year;
						if(pay_dt.length() == 8)
						{
							pay_dt = pay_dt.substring(0,4) + " �� "+ pay_dt.substring(4,6) +" �� "+ pay_dt.substring(6,8) +" ��";
						}							
						String apln_amt = "";
						apln_amt = selPayment.getText("apln_amt");
						apln_amt = Util.addComma(apln_amt);
						mapping1 = payor_nm +"|"+ selPayment.getText("srvc_name") +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+ apln_dt+"|"+pay_dt+"|"+apln_amt + "��" +"|"+ selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
													
						////���Ϻ�����(��)
						input10.put("v_mail_type", "03");
						input10.put("v_mail_type_seq", Variable.get("email-id.cyber03"));////54
						input10.put("v_channel_code", "00000030");
						input10.put("v_member_id", cltnum);////���ֹι�ȣ
						input10.put("v_to_name", payor_nm);////����
						input10.put("v_to_email",  selPayment.getText("payor_email"));////���̸���
						
						
						input10.put("v_mapping", mapping1);
						input10.put("v_lp_code", selPayment.getText("lp_id"));
						input10.put("v_policy_number", selPayment.getText("policy_no"));
						input10.put("v_channel", "cyber");
						input10.put("v_ilips_client_id", "");
						
						anyframe.log.Logger.debug.println("���� ������ ���� �ʵ�  : "+input10);
						DataSet mailcu = mailsend.sendMail(input10); 
						request.setAttribute("mailcu",mailcu);	
													
						////LP���� ���� ������
						
						input10.put("v_mail_type", "03");
						input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
						input10.put("v_channel_code", "00000030");
						input10.put("v_member_id", cltnum);
						
						input10.put("v_to_email", selPayment.getText("lp_email"));
						
						mapping1 = "";
						String lpname = "";							
						lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname").trim()));
						input10.put("v_to_name", lpname);////lp��
						
						mapping1 = lpname +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "��" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
						input10.put("v_mapping", mapping1);
						
						anyframe.log.Logger.debug.println("LP���� ���� ������ ���� �ʵ�  : "+input10);
						input10.put("v_lp_code", selPayment.getText("lp_id"));		
						DataSet maillp = mailsend.sendMail(input10); 
						request.setAttribute("maillp",maillp);				
						
						////SM���� ���� ������
						/*
						input10.put("v_mail_type", "03");
						input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
						input10.put("v_channel_code", "00000030");
						input10.put("v_member_id", cltnum);
													
						input10.put("v_to_email", selPayment.getText("sm_email"));
						
						mapping1 = "";
						String sm_name = "";
						////sm_name = selPayment.getText("sm_name");
						sm_name = Util.superTrim(ToolString.hanToFull(selPayment.getText("sm_name")));
						
						mapping1 = sm_name +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "��" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
						input10.put("v_mapping", mapping1);
						
						anyframe.log.Logger.debug.println("SM���� ���� ������ ���� �ʵ�  : "+input10);
						input10.put("v_lp_code", selPayment.getText("sm_code"));		
						DataSet mailsm = mailsend.sendMail(input10); 
						request.setAttribute("mailsm",mailsm);								
						*/
						
						////������ SMS������
									
						String owner_mobile  	= selPayment.getText("payor_phone");////�ڵ���
						String lp_code       	= "";////LP���
						String amt           	= Util.addComma(StringFormater.removeZero(selPayment.getText("apln_amt")));////�ݾ�
						String gubun1         	= selPayment.getText("paycd");////��ȯ����					
						String sms_code = "";
						String srvc_gubunc = "";
						String owner = "";
						owner = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm")));
						
						srvc_gubunc = selPayment.getText("srvc_cd");
						if(srvc_gubunc.equals("1"))////��������û
						{
							sms_code = "5";
						}
						else if(srvc_gubunc.equals("2"))////��������ȯ 
						{
							sms_code = "9";
						}
						else if(srvc_gubunc.equals("3"))////�ڵ����ⳳ�λ�ȯ
						{
							sms_code = "10";
						}
						else if(srvc_gubunc.equals("4"))////����
						{
							sms_code = "6";
						}
						else if(srvc_gubunc.equals("5"))////�޸麸���
						{
							sms_code = "25";
						}
						else if(srvc_gubunc.equals("6"))////��������
						{
							sms_code = "8";
						}
						else if(srvc_gubunc.equals("7"))////���ݻ��
						{
							sms_code = "7";
						}
/**
						else if(srvc_gubunc.equals("8"))////�߰���������
						{
							sms_code = "22";
						}
**/
						
						String indate1 = "";
						indate1 = selPayment.getText("policy_apln_no").substring(0,8);
						
						smscu.put("v_sms_code",  		sms_code);////SMS �޽��� �����ڵ�
						smscu.put("v_success_yn",  	"0");////0-����,1-����
						smscu.put("v_policy_no",  	selPayment.getText("policy_no"));
						smscu.put("v_name",  			owner);
						smscu.put("v_owner",  		owner);
						smscu.put("v_owner_mobile",  	owner_mobile);
						smscu.put("v_lp_code",  		lp_code);
						smscu.put("v_amt",  			amt);
						smscu.put("v_gubun",  		gubun1);
						
						smscu.put("tran_etc1",  		indate1);////�Է³�¥
						smscu.put("tran_etc2",  		selPayment.getText("policy_apln_no"));////���� ����
						smscu.put("v_pr",  			"CU");					
						DataSet sms_ins_cu = manager2.findClientSms(smscu);////CU��								
						
						////ó�� ���� �޼���
						message = "���������� ���εǾ����ϴ�.";
						msg = message1;
		            			url = urlname;
		            			request.setAttribute("message", msg);	
		            			request.setAttribute("toURL", url);	
		            			return mapping.findForward("alert");																									
					}
					else if(errrtn.equals("1") || errrtn.equals("2") || errrtn.equals("5"))
					{
						input.put("gubun", "W" );
						input.put("lvlnum", "70");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);
						DataSet ksps2000_70 = manager.findKsps2000(input);	
						
						////sp �α׸� ���� ����... ����
						try
						{
	
						  /*���������ڵ�*/
																		 /*
																		  * �������		1
																		  * ��������		4
																		  * �޸麸�������	5
																		  * ���ݻ��		7
																		  * ��������		6
																		  * �߰���������	8
																		  * ����ȯ		2
																		  * APL��ȯ		3 
																		  * Ư��ΰ� 1		A
																		  * Ư��ΰ� 2 	B
																		  * Ư��ΰ� 3		C 
																		  * ��й�ȣ ����     I          
																		  */
	 					
						
						  DataSet spinputp  = new DataSet();
	
						  spinputp.put("srvc_cd","2"); ////ó�������ڵ�
						  spinputp.put("sp_nm","KSPS2000"); ////sp��
						  spinputp.put("tran_no",emp_no); ////ó����û�� ��ȣ				
						  spinputp.put("tran_nm",emp_nm); ////ó����û�� ����
						  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						  spinputp.put("sp_out_put",ksps2000_70.toString()); ////sp_out_put
	
						  returns.findSpLogsave(spinputp);
	
						}catch(Exception e)
						{
	
						  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
						}
	
						////sp �α׸� ���� ����... ��
						
						////WEB DB����(���� 70)
						input1.put("policy_apln_no", policy_apln_no);
						input1.put("proc_emp_no", proc_emp_no);
						input1.put("proc_status", "70");
						input1.put("err_msg", message1);						
						DataSet rtnsavek11 = returns.findRtnsave(input1);
						
						input2.put("policy_apln_no", policy_apln_no);				
						input2.put("proc_status", "2");
						input2.put("err_msg", message1);
						DataSet rtnsavek11_1 = returns.findRtnsave1(input2);
						
						////ó�� ���� �޼���
						message = "�����Ͽ����ϴ�. �����ڿ��� �����ϼ���.";
						msg = message1;
		            			url = urlname;
		            			request.setAttribute("message", msg);	
		            			request.setAttribute("toURL", url);	
		            			return mapping.findForward("alert");																				
					}////M0181SP1�� ������ �����ڵ尡 1,2,5�ΰ��					
				}////KSPS0450�� 0�ΰ��
			////}////����(50)���ΰ�� �� ����(10)�ΰ��
		}////�������ΰ�� �ڵ� PGMó���� �����϶� ����ó��		////�����ΰ�� �ڵ� PGMó���� �����϶� ����ó��
		
		/**************************************
		 * ����� ksps2000 �˻� - E
	 	 ***************************************/

		saveToken(request);

		return doExecute(mapping, form, request, response);
	}

	/**
	 * CybercenterActionŬ������ ����ϴ� Ŭ�������� �����ؾ��� �޽��. 
	 */
	protected abstract ActionForward doExecute(ActionMapping mapping, ActionForm form,	HttpServletRequest request,	HttpServletResponse response)throws Exception;
}

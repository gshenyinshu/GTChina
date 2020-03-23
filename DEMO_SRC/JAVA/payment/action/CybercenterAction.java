// modified by wihyuk yi 2005.08.22
//package gtone.home.common.action;
package gtone.changeminer.payment.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.*;


////comment
import anyframe.data.DataSet;
import anyframe.log.*;
import gtone.changeminer.common.utility.*;

import java.util.*;////StringTokenizer�� ���
import anyframe.util.*;////StringFormater

////ksps2000
import gtone.changeminer.payment.manager.CybercenterManager;
import gtone.changeminer.payment.manager.ReturnManager;
import gtone.changeminer.payment.manager.PlpaymentManager;

////SMS message
import gtone.changeminer.payment.manager.CyberSmsManager;

////comment
import gtone.changeminer.receipt.manager.AuthManager;
import gtone.changeminer.receipt.manager.PolicychangeManager;
import gtone.changeminer.common.utility.Variable;////prumail.xml

////comment
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

public abstract class CybercenterAction extends Action
{


	/**
	 * action forward
	 * action forward
	 * action forward
	 */

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)throws Exception
	{

		/**************************************
		 * ksps2000 - S
		 ***************************************/

		DataSet input = new DataSet();
		DataSet input1 = new DataSet();
		DataSet input2 = new DataSet();
		DataSet input3 = new DataSet();
		DataSet input4 = new DataSet();
		DataSet input5 = new DataSet();
		DataSet input7 = new DataSet();
		DataSet input8 = new DataSet();////KSPS0450
		DataSet input9 = new DataSet();
		DataSet input10 = new DataSet();
		DataSet input11 = new DataSet();
		DataSet smscu    = new DataSet();
		DataSet realpay  = new DataSet();
		DataSet inAppv   = new DataSet();
		DataSet	outAppv1 = new DataSet();
		DataSet	outAppv2 = new DataSet();

		String errrtn = "-1";
		String message = "";
		String message1 = "";
		String bankerr = "-1";

		String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");////ó������
		String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");
		String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");

		////���ǻ���ϱ�
		SessionManager sessionManager = new SessionManager(request);
		String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
		String emp_no = sessionManager.getString(Constant.SESSION_USERID);
		String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);

		String proc_emp_no = emp_no;////ó���ڻ��

		String deptcd  		= "INT";
		String init	   		= "     ";
		String gubun    	= "";////ó������(C,W)
		String reqnum  	= "   ";////��û�Ǽ�
		String fromdt 		=    request.getParameter("indate")	== null ? "" : request.getParameter("indate");////��ȸ��������
		String policy	 	=    request.getParameter("policy")	== null ? "" : request.getParameter("policy");////���ǹ�ȣ
		String procdt   		= "        ";////����ó������
		String proctm   	= "      ";////����ó���ð�
		String inout 		= "OUT";////����(IN), ����(OUT)
		String procgb  		= "L1";////�������
		String lvlnum  		= "";////ó������
		String lvlbef   		= "  ";////ó��������
		String mbkcd    	= "  ";////����� �����ڵ�
		String mbkact   	= "               ";////����� ���¹�ȣ
		String cltbk    		=  request.getParameter("bnkcode")	== null ? "" : request.getParameter("bnkcode");////�����ڵ�
		String cltact   		= request.getParameter("bnkacct")	== null ? "" : request.getParameter("bnkacct");////�� ���¹�ȣ
		String cltnum   	= request.getParameter("bnkclt")	== null ? "" : request.getParameter("bnkclt");////�� �ֹι�ȣ
		String procamt  	= request.getParameter("cash")	== null ? "" : request.getParameter("cash");////��ü�ݾ�
		String procno   	= "      ";////��ü������ȣ
		String brltcd   		= "    ";////������

		String returnurl = request.getParameter("returnurl")	== null ? "" : request.getParameter("returnurl");
		String urlname =  returnurl + "?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy;
		anyframe.log.Logger.debug.println("���� url�� ��===================>"+urlname);

		////���ν� M0181SP1�� �����Ұ���
		String opt1 =  request.getParameter("opt1")	== null ? "" : request.getParameter("opt1");
		String regdate  = request.getParameter("regdate")	== null ? "" : request.getParameter("regdate");
		String cash =  request.getParameter("cash")	== null ? "" : request.getParameter("cash");
		String bnkclt =  request.getParameter("bnkclt")	== null ? "" : request.getParameter("bnkclt");
		String bnkcode  = request.getParameter("bnkcode")	== null ? "" : request.getParameter("bnkcode");
		String bnkacct = request.getParameter("bnkacct")	== null ? "" : request.getParameter("bnkacct");
		String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");
		String tproc_emp_no = proc_emp_no.toUpperCase();
		String v_toyear = Util.getTodayToYMD();
		String  to_year = v_toyear.substring(0,8);

		//// 0800133 �Ⱥ��� : �����ϰ�� ����ó���� �Ҽ� �ֵ��� ó�� M018SP1 -> M018SP5 �� �����Ҽ��ֵ��� ������.	
		String variable_div = request.getParameter("variable_div")	== null ? "" : request.getParameter("variable_div");

		String sending_num = "";
		String msg = "";
		String url  = "";
		String sendingnum = "";
		String date = "";
		String rtn0450 = "";

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

		int procamt1 	      = 0;////��ü�ݾ�(1000����)

		CybercenterManager manager = CybercenterManager.getInstance();
		ReturnManager returns = ReturnManager.getInstance();                 ////�ݼ�
		PlpaymentManager Pmanager = PlpaymentManager.getInstance();////M0181SP1�� ����(������üó��)
		PolicychangeManager mailsend = PolicychangeManager.getInstance();////���Ϲ߼�
		CyberSmsManager manager2 = CyberSmsManager.getInstance(); ////��������

		anyframe.log.Logger.debug.println("PROCESS*****************====>"+process);
		
		DataSet inputp1  = new DataSet();
		DataSet inputp2  = new DataSet();
		DataSet inputp3  = new DataSet();	

		String cnvdate	= to_year;
		cnvdate = "        ";

		inputp1.put("policy", policy);
		inputp1.put("cnvdate",   cnvdate);

		anyframe.log.Logger.debug.println("ó�� ���μ���.... �ڵ� ==========="+process);	
		inputp2.put("policy_apln_no", policy_apln_no);
		inputp2.put("recon_id", proc_emp_no);
		inputp3.put("proc_emp_no", proc_emp_no);


		////ó���� ��ȸ ��� �߰�.. (��ü���� �������� )...
		////�����û(R) , ����(Y)
		if(process.equals("R")||process.equals("Y")){
			anyframe.log.Logger.debug.println("=============== ó���� ��ȸ �ϱ� ==================");	
			
				
			PlpaymentManager manager1 = PlpaymentManager.getInstance();		
			DataSet plpayment 	= manager1.findPlpayment(inputp1); ////ysg123 m0161sp1
	
			DataSet  payment   = manager1.Inpayment(inputp2, inputp3); ////ysg123 CYBER_TBL_wb_payment��ȸ
	
			int loanval  = 0;////�����Ⱑ�ɾ�
			int cntno = plpayment.getCount("rid_nam");////������
	
			for(int i=0;i<cntno;i++)
			{
				loanval   = loanval  + Integer.parseInt(plpayment.getText("loanval",i).trim());		
			}
			int amt1 = loanval;////�����Ⱑ�ɱݾ�
			int amt2 = payment.getInt("apln_amt");////��û�ݾ�
			anyframe.log.Logger.debug.println("PlpaymentAction --- amt1:"+amt1);	
			anyframe.log.Logger.debug.println("PlpaymentAction --- amt2:"+amt2);	
			String strPlnCode = plpayment.getText("plancd");
			if("".equals(strPlnCode) == false || strPlnCode != null) strPlnCode = strPlnCode.substring(0,2);
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!! �����ڵ� : [" + strPlnCode + "]");
			//// ���״����ϰ��� ó������ȸ�� ���� ����.
			if( amt1 < amt2 && ("51".equals(strPlnCode) || "53".equals(strPlnCode) || "54".equals(strPlnCode) || "55".equals(strPlnCode) || "56".equals(strPlnCode)) == false)
			{
	
				 message = "[ó������ȸ]��û�ݾ��� �����Ⱑ�ɱݾ׺��� �����ϴ�.";
				msg = message;
				url = urlname;
				request.setAttribute("message", msg);
				request.setAttribute("toURL", url);
				return mapping.findForward("alert");	
	
			}
			
		}	
		
		
		
		
		
		////�����û
		if(process.equals("R"))
		{
			input.put("gubun", "C"); ////       I - ��ȸ / W - �ű��ۼ� / C - CHECK (����,���� ó���� üũ)
			input.put("lvlnum", "21");

			DataSet ksps2000_10 = manager.findKsps2000(input);
			
			
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
				spinputp.put("sp_out_put",ksps2000_10.toString()); ////sp_out_put
				
				returns.findSpLogsave(spinputp);
						
			}catch(Exception e)
			{
			
				System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
			}
			
			////sp �α׸� ���� ����... ��
			

			errrtn = "";
			errrtn = ksps2000_10.getText("rtn",0);

////�����û����
			if(errrtn.equals("0") || errrtn.equals("6"))
			{
				/* 2007�� 5�� 16�� �Ⱥ��� 1���ѵ� 1000�������� ����
								int cnt = ksps2000_10.getCount("procamt");
								if(cnt > 0)
								{
									for(int i =0; i<cnt; i++)
									{
										procamt1 = procamt1 + Integer.parseInt(ksps2000_10.getText("procamt",i));
									}
								}
				*/

				//// WB_PAYMENT���� ������ȣ�� �� ROW �˻�
				DataSet nameSet = new DataSet();
				nameSet.put("policy_apln_no", policy_apln_no);

				DataSet selPayment = manager.findRecei(nameSet);

				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				////[20070220] 1. webdb���� ���� ���ڷ� �� �ֹι�ȣ�� ���ؼ� ������� ���� ��ȸ�ϴ� �� �߰�
				////- ���� ó���� �� ����Ϸ� ����0�� ���� mode:1(����)/srvc_cd:1(�������)�� �� ��ȸ
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////S/
				DataSet procamt_input 	= new DataSet();
				procamt_input.put("mode", 		"1"); ////����
				procamt_input.put("srvc_cd", 	selPayment.getText("srvc_cd")); ////�������, ���
				////procamt_input.put("rslt", 		"0"); ////����
				procamt_input.put("ssn", 		ssn);
				DataSet procamt_info 	= manager.getProcamtInfo(procamt_input);
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////E/

				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				////[20070220] 2. procamt_sum ���
				////- ���� ���̹����� ������� �� + ���� ��û�ݾ� = procamt_sum
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				int procamt_sum = 0;////��ü�ݾ�(1000����)
				int cnt = procamt_info.getCount("payor_ssn");

				if(cnt > 0){
					for(int i =0; i<cnt; i++){
						procamt_sum = procamt_sum + Integer.parseInt(procamt_info.getText("apln_amt",i));
					}
				}
				anyframe.log.Logger.debug.println(" (procamt_info - ��ȸ)----  applymoney  : "+Integer.parseInt(procamt) );
				anyframe.log.Logger.debug.println(" (procamt_info - ��ȸ)----  pay_amt  : "+procamt_sum );
				////ocamt_sum = procamt_sum + Integer.parseInt(procamt);
				anyframe.log.Logger.debug.println(" (procamt_info - ��ȸ)----  procamt_sum  : "+procamt_sum );

				////procamt1 = 10000001;
////				if(procamt1 >10000000)
				if(procamt_sum > 10000000)
				{
					message =  "1�� �����ѵ� 1000������ �ʰ��Ͽ�  �Ұ����մϴ�.";
					input.put("gubun", "W" );
					input.put("lvlnum", "30");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);

					DataSet ksps2000_30 = manager.findKsps2000(input);
					////request.setAttribute("ksps2000_30", ksps2000_30);


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
						spinputp.put("sp_out_put",ksps2000_30.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
					}
			
					////sp �α׸� ���� ����... ��
					
					errrtn = "";
					errrtn = ksps2000_30.getText("rtn",0);

					////WEB ��� �ݼ� ����
					if(errrtn.equals("0"))
					{
						input1.put("policy_apln_no", policy_apln_no);
						input1.put("proc_emp_no", proc_emp_no);
						input1.put("proc_status", "30");
						input1.put("err_msg", message);
						DataSet rtnsave = returns.findRtnsave(input1);

						input2.put("policy_apln_no", policy_apln_no);
						input2.put("proc_status", "1");
						input2.put("err_msg", message);
						input2.put("recon_id", proc_emp_no);
						DataSet rtnsave1 = returns.findRtnsave1(input2);

					}////WEB ��� �ݼ� ����

							msg = message;
							url = urlname;
							request.setAttribute("message", msg);
							request.setAttribute("toURL", url);
							return mapping.findForward("alert");

				}////1000��������
				else
				{
					
					anyframe.log.Logger.debug.println("KSPS2000 ���� 1������Ϸ� ó������(C)=======================================>");
					////KSPS2000���� 1������Ϸ�:21(��ȸ)
					input.put("gubun", "C");
					input.put("lvlnum", "21");

					DataSet ksps2000_21C = manager.findKsps2000(input);////����
					
					
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
						spinputp.put("sp_out_put",ksps2000_21C.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
					}
			
					////sp �α׸� ���� ����... ��
					
					
					String rtn21 = ksps2000_21C.getText("rtn").trim();
					anyframe.log.Logger.debug.println("�����û������ �����°� ���� �Ƕ�=======================================>"+rtn21);
					int success = Integer.parseInt(rtn21);

						switch(success)
						{
							case(0) :
									message =  "�����û�� ó���Ǿ����ϴ�..";
									break;
							case(5) :
									message = "�������Ǿ� ó�����ΰ��� �����մϴ�.";
									break;
							case(6) :
									message =  "�����û�� ó���Ǿ����ϴ�..";
									break;
							default :
									message =  "��Ÿ������ �߻��Ͽ����ϴ�. �ý��۰����ڿ��� �����ϼ���..";
									break;
						}
						////KSPS2000���� 1������Ϸ� 21(����)
						if(rtn21.equals("0") || rtn21.equals("6"))
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
				
							spinputp.put("srvc_cd","1"); ////ó�������ڵ�
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
						
						
						
						////request.setAttribute("ksps2000_21W", ksps2000_21W);
					
							errrtn = "";
							errrtn = ksps2000_21W.getText("rtn",0);
							if(errrtn.equals("0"))
							{
								input1.put("policy_apln_no", policy_apln_no);
								input1.put("proc_emp_no", proc_emp_no);
								input1.put("proc_status", "21");
								input1.put("err_msg", message);
								DataSet rtnsave2 = returns.findRtnsave(input1);
	
								input2.put("policy_apln_no", policy_apln_no);
								input2.put("proc_status", "A");
								input2.put("err_msg", message);
								input2.put("recon_id", proc_emp_no);
								DataSet rtnsave3 = returns.findRtnsave1(input2);
							}
						}
						else if(rtn21.equals("5"))	////�������Ǿ��ִ°�
						{
							input1.put("policy_apln_no", policy_apln_no);
							input1.put("proc_emp_no", proc_emp_no);
							input1.put("proc_status", "1");
							input1.put("err_msg", message);
							DataSet rtnsave4 = returns.findRtnsave(input1);

							input2.put("policy_apln_no", policy_apln_no);
							input2.put("proc_status", "1");
							input2.put("err_msg", message);
							input2.put("recon_id", proc_emp_no);
							DataSet rtnsave5 = returns.findRtnsave1(input2);
						}
					
					msg = message;
							url = urlname;
							request.setAttribute("message", msg);
							request.setAttribute("toURL", url);
							return mapping.findForward("alert");

				}////KSPS2000���� 1������ �Ϸ�:21
			}
		}////�����û END
		////���ο�û�κ�-����
		else if(process.equals("Y"))
		{
			//// 2007�� 5�� 15�� �Ⱥ��� : �ߺ���û ����. saveToken �̿�
			//// ���ΰ�ħ ������쳪 ����Ŭ��ó�� �ι� ��û �Ǿ������ �ߺ����ο�û�� ���� �κ�.
			if (!isTokenValid(request)) {
				url = urlname;
				Logger.debug.println("saveToken ���ΰ�ħ ������쳪 ����Ŭ��ó�� �ι� ��û �Ǿ������ ����.");
				request.setAttribute("message", "���ο�û �����߿� �� �ٸ� ���ο�û�� �ߺ���û �Ǿ����Ƿ� ������� �ʽ��ϴ�.");
				request.setAttribute("toURL", url);
				return mapping.findForward("alert");
			}
			resetToken(request); //// ���ǿ� �ִ� ��ū���� �ʱ�ȭ �Ѵ�. �ߺ���û�� ���� if���� �ɸ��� �ϱ� ����.

			input.put("gubun", "C");
			input.put("lvlnum", "22");
			DataSet ksps2000_10 = manager.findKsps2000(input);
			
			
			
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
				spinputp.put("sp_out_put",ksps2000_10.toString()); ////sp_out_put
				
				returns.findSpLogsave(spinputp);
						
			}catch(Exception e)
			{
			
				System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
			}
			
			////sp �α׸� ���� ����... ��
			
			
			

			errrtn = "";
			errrtn = ksps2000_10.getText("rtn",0);
			/*
			 * KSPS2000 errrtn ����� ����
			 *  �ɼ� I �Ǵ� W �� ���� ��� ***
				0 - ����
				1 - ��Ÿ����
			  ** �ɼ� C �� ���� ��� **********
				0 - ����
				1 - ��Ÿ����
				5 - �������Ǿ� ó������ ���� �����Ѵ�.
				6 - ���ó�¥�� �Ϸ�ó�� �� ���� �����Ѵ�.
			 * */
			 
			message = "";

			////2006-09-07:�躸��:0601914:���� �ÿ� WEBDB���� �̹� ���� �� ���� ������ üũ�ϴ� �κ� �߰�
			inAppv.put("policy_apln_no", 	policy_apln_no);

			outAppv1 = manager.findAppvProcessStatus(inAppv);
			outAppv2 = manager.findAppvPaymentStatus(inAppv);

			String appv_cnt 	= outAppv1.getText("appv_cnt");////�����ڵ� �Ϸ� 80�� ���� 0�� ���
			String appv_rslt	= outAppv2.getText("rslt");////����ڵ� �Ϸ� 0�� ���� 0 �� ��� , ���� �ҽ������� ����ϴ� �κ��� ����...

			
			if(errrtn.equals("0") || errrtn.equals("6")){  ////�����ΰ��

////				������ ��쿡 WEBDB ���� �� �� ���� üũ �߰�
////				������ ���°� �����û �ܰ��� ���μ��� �϶� ����ó�� �ǵ��� ��.
				if(!appv_cnt.equals("0")){
					////ó�� �޼���

					message = "����ε� �� �̰ų� ó�����Դϴ�. Ȯ�� �� ó�����ּ���.";
					url = urlname;
					request.setAttribute("message", message);
					request.setAttribute("toURL", url);
					return mapping.findForward("alert");

				}else{

					//// 2007�� 5�� 23�� �Ⱥ��� : ���ο�û ���۽� 22�ڵ带 �ִ´�.
					DataSet newSet = new DataSet();
					newSet.put("policy_apln_no", policy_apln_no);
					newSet.put("proc_emp_no", proc_emp_no);
					newSet.put("proc_status", "22");
					newSet.put("err_msg", message);
					DataSet rtnsave10 = returns.findRtnsave(newSet);

/* 2007�� 5�� 16�� �Ⱥ��� 1���ѵ� 1000�������� ����
					int cnt = ksps2000_10.getCount("procamt");
					if(cnt > 0)
					{
						for(int i =0; i<cnt; i++)
						{
							procamt1 = procamt1 + Integer.parseInt(ksps2000_10.getText("procamt",i));
						}
					}
*/
					//// WB_PAYMENT���� ������ȣ�� �� ROW �˻�
					DataSet nameSet = new DataSet();
					nameSet.put("policy_apln_no", policy_apln_no);
					
					DataSet selPayment = manager.findRecei(nameSet);
					
					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					////[20070220] 1. webdb���� ���� ���ڷ� �� �ֹι�ȣ�� ���ؼ� ������� ���� ��ȸ�ϴ� �� �߰�
					////- ���� ó���� �� ����Ϸ� ����0�� ���� mode:1(����)/srvc_cd:1(�������)�� �� ��ȸ
					///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////S/
					DataSet procamt_input 	= new DataSet();
					procamt_input.put("mode", 		"1"); ////����
					procamt_input.put("srvc_cd", 	selPayment.getText("srvc_cd")); ////�������, ���
					
					procamt_input.put("ssn", 		ssn);
					DataSet procamt_info 	= manager.getProcamtInfo(procamt_input);
					///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////E/

					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					////[20070220] 2. procamt_sum ���
					////- ���� ���̹����� ������� �� + ���� ��û�ݾ� = procamt_sum
					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					int procamt_sum = 0;////��ü�ݾ�(1000����)
					int cnt = procamt_info.getCount("payor_ssn");

					if(cnt > 0){
						for(int i =0; i<cnt; i++){
							procamt_sum = procamt_sum + Integer.parseInt(procamt_info.getText("apln_amt",i));
						}
					}
					anyframe.log.Logger.debug.println(" (procamt_info - ��ȸ)----  applymoney  : "+Integer.parseInt(procamt) );
					anyframe.log.Logger.debug.println(" (procamt_info - ��ȸ)----  pay_amt  : "+procamt_sum );
					anyframe.log.Logger.debug.println(" (procamt_info - ��ȸ)----  procamt_sum  : "+procamt_sum );


					if(procamt_sum > 10000000)
					{
						message =  "1�� �����ѵ� 1000������ �ʰ��Ͽ�  �Ұ����մϴ�.";
						input.put("gubun", "W" );
						input.put("lvlnum", "30");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);

						DataSet ksps2000_30 = manager.findKsps2000(input);
						
						
						
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
							spinputp.put("sp_out_put",ksps2000_30.toString()); ////sp_out_put
				
							returns.findSpLogsave(spinputp);
						
						}catch(Exception e)
						{
			
							System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
						}
			
						////sp �α׸� ���� ����... ��
						
						
						
						
						////request.setAttribute("ksps2000_30", ksps2000_30);

						errrtn = "";
						errrtn = ksps2000_30.getText("rtn",0);

						////WEB ��� �ݼ� ����
						if(errrtn.equals("0"))
						{
							input1.put("policy_apln_no", policy_apln_no);
							input1.put("proc_emp_no", proc_emp_no);
							input1.put("proc_status", "30");
							input1.put("err_msg", message);
							DataSet rtnsave8 = returns.findRtnsave(input1);

							input2.put("policy_apln_no", policy_apln_no);
							input2.put("proc_status", "1");
							input2.put("err_msg", message);
							input2.put("recon_id", proc_emp_no);
							DataSet rtnsave9 = returns.findRtnsave1(input2);

						}////WEB ��� �ݼ� ����

								msg = message;
								url = urlname;
								request.setAttribute("message", msg);
								request.setAttribute("toURL", url);
								return mapping.findForward("alert");
					}
					else
					{
						////KSPS2000���� 2������Ϸ�:22(����)
						input.put("gubun", "W" );
						input.put("lvlnum", "22");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);

						DataSet ksps2000_22W = manager.findKsps2000(input);////����
						
						
						
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
							spinputp.put("sp_out_put",ksps2000_22W.toString()); ////sp_out_put
				
							returns.findSpLogsave(spinputp);
						
						}catch(Exception e)
						{
			
							System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
						}
			
						////sp �α׸� ���� ����... ��
						
						
						
						String rtn22 = ksps2000_22W.getText("rtn").trim();

						errrtn = "";
						errrtn = ksps2000_22W.getText("rtn",0);
						if(errrtn.equals("0"))
						{
							/*
							 *		2007�� 5�� 23 �Ⱥ��� : ���ο�û ���۽� 22�� �ٲ��ֹǷ� insert ���� ����. WEBDB.CYBER�� PROCESS ���̺�.. 
							
														input1.put("policy_apln_no", policy_apln_no);
														input1.put("proc_emp_no", proc_emp_no);
														input1.put("proc_status", "21");
														input1.put("err_msg", message);
														DataSet rtnsave10 = returns.findRtnsave(input1);
							*/
							input2.put("policy_apln_no", policy_apln_no);
							input2.put("proc_status", "A");
							input2.put("err_msg", message);
							input2.put("recon_id", proc_emp_no);
							DataSet rtnsave11 = returns.findRtnsave1(input2);

							////2006-12-27 �躸�� : M0181SP1�� ó���ϱ� ���� ����ó�� ���´ٴ� 40�� CODE�� �������ش�.
							////KSPS2000���� ����ó�����ۻ���:40(����)
							input.put("gubun", "W" );
							input.put("lvlnum", "40");
							input.put("cltbk", cltbk);
							input.put("cltact", cltact);
							input.put("cltnum", cltnum);
							input.put("procamt", procamt);

							////KSPS2000����(���������۽�:40)
							DataSet ksps2000_40 = manager.findKsps2000(input);
							
							
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
								spinputp.put("sp_out_put",ksps2000_40.toString()); ////sp_out_put
				
								returns.findSpLogsave(spinputp);
						
							}catch(Exception e)
							{
			
								System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
							}
			
							////sp �α׸� ���� ����... ��
							
							
							
							
							errrtn = "";
							errrtn = ksps2000_40.getText("rtn");

							////WEBDB ����(���������۽�:40)
							if(errrtn.equals("0")){
								input1.put("policy_apln_no", policy_apln_no);
								input1.put("proc_emp_no", proc_emp_no);
								input1.put("proc_status", "40");
								input1.put("err_msg", message);
								DataSet rtnsave10_40 = returns.findRtnsave(input1);  ////CYBER_TBL_wb_process ���°� �Է�.

								////���⿡�� ���� ������ �޾����� �������� M0181SP1�� �����Ѵ�.
								input3.put("deptcd", "INT");
								input3.put("init", tproc_emp_no);
								input3.put("opt1", opt1);
								input3.put("opt2", "U");
								input3.put("policy", policy);

								//// [05-B-353] 2005-08-22 ������. regdate ���������� �Ѿ�����ʾ� indate�� ��ü
								input3.put("regdate", indate);
								input3.put("paydate", to_year);
								input3.put("cash", cash);
								input3.put("prmsusp", "00000000000");
								input3.put("susp", "00000000000");
								input3.put("plpay", cash);
								input3.put("tax", "00000000000");
								input3.put("sndseq", "      ");
								input3.put("bnkclt", bnkclt);
								input3.put("bnkcode", bnkcode);
								input3.put("bnkacct", bnkacct);
								input3.put("agency", "   ");

								input4.put("policy_apln_no", policy_apln_no);
								input5.put("proc_emp_no", proc_emp_no);
								input5.put("variable_div", variable_div);
								System.out.println("���״����� ����ó�� �ϰ�� �� : [" + variable_div + "]");

								anyframe.log.Logger.debug.println("Action M0181SP1  input3==========="+input3);
								DataSet approval = Pmanager.getApproval(input3, input4, input5);////����,policy_apln_no,proc_emp_no




////								sp �α׸� ���� ����... ����
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
										  
										  
										  
								sending_num = approval.getText("sndseq");////���۹�ȣ
								input9.put("policy_apln_no", policy_apln_no);
								input9.put("sending_num", sending_num);
								input9.put("pay_dt", Util.getTodayToYMD().substring(0,8));
								anyframe.log.Logger.debug.println("������ �������� input����==========="+input9);
								DataSet sending = manager.Sendingsave(input9);////���۹�ȣ ����

								realpay.put("policy_apln_no", policy_apln_no);////���۹�ȣ
								////realpay.put("pay_amt", approval.getText("netpay"));////�����ޱ�
								realpay.put("pay_amt", cash);

								errrtn = approval.getText("rtn");

								message1 = Util.superTrim(approval.getText("errmsg1")) + Util.superTrim(approval.getText("errmsg2")) + Util.superTrim(approval.getText("errmsg3"));

								//// 2007.5.15 �Ⱥ���
								//// ���� �޼����� AAAA�� ���Ե� ���ڰ� ������� SMS �߼�.
								anyframe.log.Logger.debug.println("���� ��approval.getText(errmsg1)====>"+approval.getText("errmsg1"));
////								AAAA�׽�Ʈ
////								approval.put("errmsg1", "DGAAAA�����ϴ�.");
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

										//// ex) ���̹� �������� Ȯ�ο�� 100500000 ȫ�浿, ������� (or�ؾ�, �޸�) 00000�� [��Ƽ�����̹�]���ο�û�� AAAA�� �߰ߵǾ����ϴ�.");" +
										String strMsg = "[��Ƽ�����̹�]��������Ȯ��" + policy + payor_nm + " " + strGubun + Integer.parseInt(procamt) + "�� AAAA�߰�";

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
										//// ex) ���̹� �������� Ȯ�ο�� 100500000 ȫ�浿, ������� (or�ؾ�, �޸�) 00000�� [��Ƽ�����̹�]���ο�û�� AAAA�� �߰ߵǾ����ϴ�.");" +
										String strSubject = policy + " " + payor_nm + ", " + strGubun + " " + Integer.parseInt(procamt) + "�� [��Ƽ�����̹�]���ο�û�� AAAA�� �߰ߵǾ����ϴ�.";
										//// ex)
										////	���̹� �������� ���ɼ� ������ Ȯ�� �ٶ��ϴ�.
										////	���� : 100500000
										////	����ڸ� : ȫ�浿
										////	������� (or �ؾ�, �޸�) 00000��
										////	ó���� : OOO
										////	ó���ð� OO:OO:OO

										String strContent = strSubject + "|" + "���̹� �������� ���ɼ� ������ Ȯ�� �ٶ��ϴ�. <br>"
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

								if(errrtn.equals("0"))
								{
									DataSet netpay = manager.Realpaysave(realpay);////�����ޱ�����

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
				
										spinputp.put("srvc_cd","1"); ////ó�������ڵ�
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
									
									
									
									message = "���������� ���εǾ����ϴ�.";

									////WEB DB����(����-HOSTó������ 80)
									input1.put("policy_apln_no", policy_apln_no);
									input1.put("proc_emp_no", proc_emp_no);
									input1.put("proc_status", "80");
									input1.put("err_msg", message1);
									DataSet rtnsave12 = returns.findRtnsave(input1);

									input2.put("policy_apln_no", policy_apln_no);
									input2.put("proc_status", "0");
									input2.put("err_msg", message1);
									input2.put("recon_id", proc_emp_no);
									DataSet rtnsave13 = returns.findRtnsave1(input2);

									////WB_PAYMENT���� ������ȣ�� Ű������ �ش� �ڷḦ Search
									input11.put("policy_apln_no", policy_apln_no);

									selPayment = manager.findRecei(input11);

									String payor_nm = Util.superTrim(selPayment.getText("payor_nm").trim());
									String v_to_mail = selPayment.getText("payor_email");
									String mapping1 = "";
									String apln_dt = selPayment.getText("apln_dt").substring(0,10);
									apln_dt = StringFormater.removeZero(apln_dt.substring(0,4)) +" �� " + StringFormater.removeZero(apln_dt.substring(5,7)) +" �� "+ StringFormater.removeZero(apln_dt.substring(8,10)) +" ��";

									to_year = null;
									v_toyear = Util.getTodayToYMD();
									to_year = v_toyear.substring(0,8);
									String pay_dt  = "";
									pay_dt = to_year;
									if(pay_dt.length() == 8)
									{
										pay_dt = StringFormater.removeZero(pay_dt.substring(0,4)) + " �� "+ StringFormater.removeZero(pay_dt.substring(4,6)) +" �� "+ StringFormater.removeZero(pay_dt.substring(6,8)) +" ��";
									}
									String apln_amt = "";
									apln_amt = selPayment.getText("apln_amt");
									apln_amt = selPayment.getText("apln_amt");
									apln_amt = Util.addComma(apln_amt);
									mapping1 = payor_nm +"|"+ selPayment.getText("srvc_name") +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+ apln_dt+"|"+pay_dt+"|"+apln_amt + "��" +"|"+ selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";

									anyframe.log.Logger.debug.println("������ ���Ϻ����� ���� CyberAction��");
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

									anyframe.log.Logger.debug.println("������ ������ ���� �ʵ� CyberAction Input : "+input10);
									DataSet mailcu = mailsend.sendMail(input10);
									request.setAttribute("mailcu",mailcu);
									anyframe.log.Logger.debug.println("������ ������ ���� �ʵ� CyberAction output : "+mailcu);



									////LP���� ���� ������
									anyframe.log.Logger.debug.println("LP���� ���Ϻ����� ���� CyberAction��");
									input10.put("v_mail_type", "03");
									input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
									input10.put("v_channel_code", "00000030");
									input10.put("v_member_id", cltnum);

									input10.put("v_to_email", selPayment.getText("lp_email"));
									mapping1 = "";
									String lpname = "";
									lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname").trim()));
									mapping1 = lpname +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnum +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "��" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
									input10.put("v_mapping", mapping1);

									anyframe.log.Logger.debug.println("LP���� ������ ���� �ʵ� CyberAction Input : "+input10);
									input10.put("v_lp_code", selPayment.getText("lp_id"));
									DataSet maillp = mailsend.sendMail(input10);
									request.setAttribute("maillp",maillp);
									anyframe.log.Logger.debug.println("LP���� ������ ���� �ʵ� CyberAction output : "+maillp);



									anyframe.log.Logger.debug.println("������ SMS ������ ���� �ʵ�1 CyberAction");
									////������ SMS������
									String owner_mobile  	= selPayment.getText("payor_phone");////�ڵ���
									String lp_code       	= "";////LP���
									String amt           	= Util.addComma(StringFormater.removeZero(selPayment.getText("apln_amt")));////�ݾ�
									String gubun1         = selPayment.getText("pay_cd");////��ȯ����
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


////									/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////SMS�߼�
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
									anyframe.log.Logger.debug.println("������ SMS ������ ���� �ʵ� CyberAction input==>"+smscu);
									
									
									
									
									
									
									
									
									DataSet sms_ins_cu = manager2.findClientSms(smscu);////CU��
									anyframe.log.Logger.debug.println("������ SMS ������ ���� �ʵ� CyberAction output==>"+sms_ins_cu);

									////ó�� ���� �޼���
									message = "���������� ���εǾ����ϴ�.";
									msg = message;
											url = urlname;
											request.setAttribute("message", msg);
											request.setAttribute("toURL", url);
											return mapping.findForward("alert");

								}
								else if(errrtn.equals("3"))
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
				
										spinputp.put("srvc_cd","1"); ////ó�������ڵ�
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
									
									
									
									message = "����ó�� �����Դϴ�. �����ð��� �ٽ� Ȯ���ϼ���.";

									////WEB DB����(����-HOSTó�� ���� 50)
									input1.put("policy_apln_no", policy_apln_no);
									input1.put("proc_emp_no", proc_emp_no);
									input1.put("proc_status", "50");
									input1.put("err_msg", message1);
									DataSet rtnsave14 = returns.findRtnsave(input1);

									input2.put("policy_apln_no", policy_apln_no);
									input2.put("proc_status", "3");
									input2.put("err_msg", message1);
									input2.put("recon_id", proc_emp_no);
									DataSet rtnsave15 = returns.findRtnsave1(input2);

									////ó�� ���� �޼���
									message = "����ó�� �����Դϴ�. �����ð��� �ٽ� Ȯ���ϼ���.";
									msg = message;
											url = urlname;
											request.setAttribute("message", message1);
											request.setAttribute("toURL", url);
											return mapping.findForward("alert");
								}
								else if(errrtn.equals("1") || errrtn.equals("2"))
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
				
										spinputp.put("srvc_cd","1"); ////ó�������ڵ�
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
									
									
									
									
									message = "����ó�� ��,�� �����Դϴ�. ������ Ȯ�� �ʿ��մϴ�.";
									////WEB DB����(��Ÿ ���� -99)
									input1.put("policy_apln_no", policy_apln_no);
									input1.put("proc_emp_no", proc_emp_no);
									input1.put("proc_status", "99");
									input1.put("err_msg", message1);
									DataSet rtnsave16 = returns.findRtnsave(input1);

									input2.put("policy_apln_no", policy_apln_no);
									input2.put("proc_status", "2");
									input2.put("err_msg", message1);
									input2.put("recon_id", proc_emp_no);
									DataSet rtnsave17 = returns.findRtnsave1(input2);

									////ó�� ���� �޼���
									message = "����ó�� ��,�� �����Դϴ�. ������ Ȯ�� �ʿ��մϴ�.";
									msg = message;
											url = urlname;
											request.setAttribute("message", message1);
											request.setAttribute("toURL", url);
											return mapping.findForward("alert");
								}
								else if(errrtn.equals("4"))
								{
									input.put("gubun", "W" );
									input.put("lvlnum", "61");
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
				
										spinputp.put("srvc_cd","1"); ////ó�������ڵ�
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
									
									
									
									
									
									
									
									
									message = "�ش��û�� ����ó�� �����Դϴ�. �ܰ�Ȯ�ι� ������ϼ���.";

									////WEB DB����(����ó����� ����-61)
									input1.put("policy_apln_no", policy_apln_no);
									input1.put("proc_emp_no", proc_emp_no);
									input1.put("proc_status", "61");
									input1.put("err_msg", message1);
									DataSet rtnsave18 = returns.findRtnsave(input1);

									input2.put("policy_apln_no", policy_apln_no);
									input2.put("proc_status", "1");
									input2.put("err_msg", message1);
									input2.put("recon_id", proc_emp_no);
									DataSet rtnsave19 = returns.findRtnsave1(input2);

									////ó�� ���� �޼���

									msg = message;
											url = urlname;
											request.setAttribute("message", message1);
											request.setAttribute("toURL", url);
											return mapping.findForward("alert");
								}
								else if(errrtn.equals("5"))
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
				
										spinputp.put("srvc_cd","1"); ////ó�������ڵ�
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
									
									
									
									
									message = "HOST ó�� �����Դϴ�. �����ڿ��� �����ϼ���.";

									////WEB DB����(���༺��+HOST����)
									input1.put("policy_apln_no", policy_apln_no);
									input1.put("proc_emp_no", proc_emp_no);
									input1.put("proc_status", "70");
									input1.put("err_msg", message1);
									DataSet rtnsave20 = returns.findRtnsave(input1);

									input2.put("policy_apln_no", policy_apln_no);
									input2.put("proc_status", "2");
									input2.put("err_msg", message1);
									input2.put("recon_id", proc_emp_no);
									DataSet rtnsave21 = returns.findRtnsave1(input2);

									////ó�� ���� �޼���

									msg = message;
											url = urlname;
											request.setAttribute("message", message1);
											request.setAttribute("toURL", url);
											return mapping.findForward("alert");
								}


							}////KSPS2000���� (���������۽�:40)��� üũ
						
						}////KSPS2000���� 22�� �����Ҷ� ���ϰ��� 0�̿��� ���
					
					}////�������ݾ��� 1000�������� �������
				
				}////�̹� ���ε� ����� �ִ� ���
			
			}////RTN�� 0�� 6�ΰ��
			else if(errrtn.equals("5") || errrtn.equals("1"))
			{
				if(errrtn.equals("5"))
					message = "�������Ǿ� ó������ ���� �����մϴ�. Ȯ���� ������û�ϼ���. ";
				else if(errrtn.equals("1"))
					message =  "��Ÿ������ �߻��Ͽ����ϴ�. �ý��� �����ڿ��� �����ϼ���.";
				input1.put("policy_apln_no", policy_apln_no);
				input1.put("proc_emp_no", proc_emp_no);
				input1.put("proc_status", "1");
				input1.put("err_msg", message);
				DataSet rtnsave30 = returns.findRtnsave(input1);

				input2.put("policy_apln_no", policy_apln_no);
				input2.put("proc_status", "1");
				input2.put("err_msg", message);
				input2.put("recon_id", proc_emp_no);
				DataSet rtnsave31 = returns.findRtnsave1(input2);
				msg = message;
						url = urlname;
						request.setAttribute("message", msg);
						request.setAttribute("toURL", url);
						return mapping.findForward("alert");
			}
		}
		else if(process.equals("K"))////�������� ��� ó��
		{
			input8.put("policy_apln_no", policy_apln_no);
			DataSet sendall = manager.findSend(input8);
			sendingnum = sendall.getText("sending_num");////���۹�ȣ
			date = sendall.getText("date");////��������

			//// [05-B-353] 2005-08-22 ������. �μ��� ���� ����
			input7.put("musera", "INTUSER");
			input7.put("snddate", date);
			input7.put("sndseq", sendingnum);

			anyframe.log.Logger.debug.println("�����϶� KSPS0450�϶� INPUT������1111111====>"+input7);

			DataSet ksps0450 = manager.findIsaogong(input7);////KSPS0450����

			rtn0450 = ksps0450.getText("rtn");
			message = ksps0450.getText("errmsg");
			if(rtn0450.equals("1") || rtn0450.equals("3"))
			{
				////message = "���α׷������� ������ �������Դϴ�. �����ڿ��� �����ϼ���.";
				msg = message;
						url = urlname;
						request.setAttribute("message", msg);
						request.setAttribute("toURL", url);
						return mapping.findForward("alert");
			}
			else if(rtn0450.equals("4"))
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
				
					spinputp.put("srvc_cd","1"); ////ó�������ڵ�
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
				errrtn = ksps2000_61.getText("rtn",0);
				message = ksps2000_61.getText("errmsg");
				if(errrtn.equals("0"))
				{
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "60");
					input1.put("err_msg", message);
					DataSet rtnsavek0 = returns.findRtnsave(input1);  ////process ���̺� ����

					input2.put("policy_apln_no", policy_apln_no);
					input2.put("proc_status", "2");
					input2.put("err_msg", message);
					input2.put("recon_id", proc_emp_no);
					DataSet rtnsavek1 = returns.findRtnsave1(input2); ////payment ���̺� ����
				}////WEB DB����(����ó����� ����-61
			}////������п� ���ѱ�
			else if(rtn0450.equals("0"))
			{
				////���⿡�� ���� ������ �޾����� �������� M0181SP1�� �����Ѵ�.
				input3.put("deptcd", "INT");
				input3.put("init", tproc_emp_no);
				input3.put("opt1", opt1);
				input3.put("opt2", "H");
				input3.put("policy", policy);
				//// [05-B-353] 2005-08-22 ������. regdate ���������� �Ѿ�����ʾ� indate�� ��ü
				input3.put("regdate", indate);
				input3.put("paydate", to_year);
				input3.put("cash", cash);
				input3.put("prmsusp", "00000000000");
				input3.put("susp", "00000000000");
				input3.put("plpay",cash);
				input3.put("tax", "00000000000");
				input3.put("sndseq", sendingnum);
				input3.put("bnkclt", bnkclt);
				input3.put("bnkcode", bnkcode);
				input3.put("bnkacct", bnkacct);
				input3.put("agency", "   ");

				input4.put("policy_apln_no", policy_apln_no);
				input5.put("proc_emp_no", proc_emp_no);

				anyframe.log.Logger.debug.println("�����ǿ� ���� M0181SP1  input3==========="+input3);
				DataSet approval5 = Pmanager.getApproval(input3, input4, input5);////����,policy_apln_no,proc_emp_no


////				sp �α׸� ���� ����... ����
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
							  spinputp.put("sp_nm","M0181SP1"); ////sp��
							  spinputp.put("tran_no",emp_no); ////ó����û�� ��ȣ				
							  spinputp.put("tran_nm",emp_nm); ////ó����û�� ����
							  spinputp.put("sp_in_put",input3.toString()); ////sp_in_put
							  spinputp.put("sp_out_put",approval5.toString()); ////sp_out_put
				
							  returns.findSpLogsave(spinputp);
						
						  }catch(Exception e)
						  {
			
							  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
						  }
			
						  ////sp �α׸� ���� ����... ��


				realpay.put("policy_apln_no", policy_apln_no);////���۹�ȣ
				////realpay.put("pay_amt", approval5.getText("netpay"));////�����ޱ�
				realpay.put("pay_amt", cash);

				errrtn = approval5.getText("rtn");
				message1 = Util.superTrim(approval5.getText("errmsg1")) + Util.superTrim(approval5.getText("errmsg2")) + Util.superTrim(approval5.getText("errmsg3"));

				if(errrtn.equals("0"))
				{
					DataSet netpay = manager.Realpaysave(realpay);////�����ޱ�����

					////KSPS2000 ����(����,HOSTó������ :80)
					input.put("gubun", "W" );
					input.put("lvlnum", "80");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);
					DataSet ksps2000_801 = manager.findKsps2000(input);
					
					
					
					
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
						spinputp.put("sp_out_put",ksps2000_801.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
					}
			
					////sp �α׸� ���� ����... ��
					

					

					////WEB DB����(����-HOSTó������ 80)
					message = "���������� ���εǾ����ϴ�.";
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "80");
					input1.put("err_msg", message1);
					DataSet rtnsavek4 = returns.findRtnsave(input1);

					input2.put("policy_apln_no", policy_apln_no);
					input2.put("proc_status", "0");
					input2.put("err_msg", message1);
					input2.put("recon_id", proc_emp_no);
					DataSet rtnsavek5 = returns.findRtnsave1(input2);


					////WB_PAYMENT���� ������ȣ�� Ű������ �ش� �ڷḦ Search
					input11.put("policy_apln_no", policy_apln_no);

					DataSet selPayment = manager.findRecei(input11);

					String payor_nm = selPayment.getText("payor_nm");
					String v_to_mail = selPayment.getText("payor_email");
					String mapping1 = "";
					String apln_dt = selPayment.getText("apln_dt").substring(0,10);
					apln_dt = StringFormater.removeZero(apln_dt.substring(0,4)) +" �� " + StringFormater.removeZero(apln_dt.substring(5,7)) +" �� "+ StringFormater.removeZero(apln_dt.substring(8,10)) +" ��";

					to_year = null;
					v_toyear = Util.getTodayToYMD();
					to_year = v_toyear.substring(0,8);
					String pay_dt  = "";
					pay_dt = to_year;
					if(pay_dt.length() == 8)
					{
						pay_dt = StringFormater.removeZero(pay_dt.substring(0,4)) + " �� "+ StringFormater.removeZero(pay_dt.substring(4,6)) +" �� "+ StringFormater.removeZero(pay_dt.substring(6,8)) +" ��";
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
					lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname")));
					mapping1 = lpname +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnum +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "��" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
					input10.put("v_mapping", mapping1);

					anyframe.log.Logger.debug.println("LP���� ���� ������ ���� �ʵ�  : "+input10);
					input10.put("v_lp_code", selPayment.getText("lp_id"));
					DataSet maillp = mailsend.sendMail(input10);
					request.setAttribute("maillp",maillp);

					/*
					////SM���� ���� ������
					input10.put("v_mail_type", "03");
					input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
					input10.put("v_channel_code", "00000030");
					input10.put("v_member_id", cltnum);

					input10.put("v_to_email", selPayment.getText("sm_email"));

					mapping1 = "";
					String sm_name = "";
					////sm_name = selPayment.getText("sm_name");
					sm_name = Util.superTrim(ToolString.hanToFull(selPayment.getText("sm_name")));

					mapping1 = sm_name +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnum +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "��" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
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
					String gubun1         	= selPayment.getText("pay_cd");////��ȯ����
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


////					/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////SMS�߼�

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
				else
				{
					////KSPS2000 ����(���� :80)
					input.put("gubun", "W" );
					input.put("lvlnum", "70");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);
					DataSet ksps2000_801 = manager.findKsps2000(input);
					
					
					
					
					
					
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
						spinputp.put("sp_out_put",ksps2000_801.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�α׸� �ִٰ� ������ �߻��ÿ��� �ٸ�ó���� ����... �α׸� ��´�. 
					}
			
					////sp �α׸� ���� ����... ��
					
					
					
					
					
					
					
					message = ksps2000_801.getText("err_msg");

					////WEB DB����(���� 70)
					message = "�����Ͽ����ϴ�. �����ڿ��� �����ϼ���.";
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "70");
					input1.put("err_msg", message1);
					DataSet rtnsavek4 = returns.findRtnsave(input1);

					input2.put("policy_apln_no", policy_apln_no);
					input2.put("proc_status", "2");
					input2.put("err_msg", message1);
					input2.put("recon_id", proc_emp_no);
					DataSet rtnsavek5 = returns.findRtnsave1(input2);

					////ó�� ���� �޼���
					message = "�����Ͽ����ϴ�. �����ڿ��� �����ϼ���.";
					msg = message;
							url = urlname;
							request.setAttribute("message", message1);
							request.setAttribute("toURL", url);
							return mapping.findForward("alert");

				}
			}
		}
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

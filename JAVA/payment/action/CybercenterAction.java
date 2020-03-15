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

import java.util.*;////StringTokenizer에 사용
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

		String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");////처리구분
		String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");
		String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");

		////세션사용하기
		SessionManager sessionManager = new SessionManager(request);
		String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
		String emp_no = sessionManager.getString(Constant.SESSION_USERID);
		String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);

		String proc_emp_no = emp_no;////처리자사번

		String deptcd  		= "INT";
		String init	   		= "     ";
		String gubun    	= "";////처리구분(C,W)
		String reqnum  	= "   ";////요청건수
		String fromdt 		=    request.getParameter("indate")	== null ? "" : request.getParameter("indate");////조회기준일자
		String policy	 	=    request.getParameter("policy")	== null ? "" : request.getParameter("policy");////증권번호
		String procdt   		= "        ";////실제처리일자
		String proctm   	= "      ";////실제처리시간
		String inout 		= "OUT";////수납(IN), 지급(OUT)
		String procgb  		= "L1";////약대지급
		String lvlnum  		= "";////처리상태
		String lvlbef   		= "  ";////처리전상태
		String mbkcd    	= "  ";////모계좌 은행코드
		String mbkact   	= "               ";////모계좌 계좌번호
		String cltbk    		=  request.getParameter("bnkcode")	== null ? "" : request.getParameter("bnkcode");////은행코드
		String cltact   		= request.getParameter("bnkacct")	== null ? "" : request.getParameter("bnkacct");////고객 계좌번호
		String cltnum   	= request.getParameter("bnkclt")	== null ? "" : request.getParameter("bnkclt");////고객 주민번호
		String procamt  	= request.getParameter("cash")	== null ? "" : request.getParameter("cash");////이체금액
		String procno   	= "      ";////이체전문번호
		String brltcd   		= "    ";////은행결과

		String returnurl = request.getParameter("returnurl")	== null ? "" : request.getParameter("returnurl");
		String urlname =  returnurl + "?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy;
		anyframe.log.Logger.debug.println("리턴 url의 값===================>"+urlname);

		////승인시 M0181SP1에 세팅할값들
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

		//// 0800133 안병훈 : 변액일경우 강제처리를 할수 있도록 처리 M018SP1 -> M018SP5 로 실행할수있도록 수정함.	
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

		int procamt1 	      = 0;////이체금액(1000만원)

		CybercenterManager manager = CybercenterManager.getInstance();
		ReturnManager returns = ReturnManager.getInstance();                 ////반송
		PlpaymentManager Pmanager = PlpaymentManager.getInstance();////M0181SP1을 실행(은행이체처리)
		PolicychangeManager mailsend = PolicychangeManager.getInstance();////메일발송
		CyberSmsManager manager2 = CyberSmsManager.getInstance(); ////문자전송

		anyframe.log.Logger.debug.println("PROCESS*****************====>"+process);
		
		DataSet inputp1  = new DataSet();
		DataSet inputp2  = new DataSet();
		DataSet inputp3  = new DataSet();	

		String cnvdate	= to_year;
		cnvdate = "        ";

		inputp1.put("policy", policy);
		inputp1.put("cnvdate",   cnvdate);

		anyframe.log.Logger.debug.println("처리 프로세스.... 코드 ==========="+process);	
		inputp2.put("policy_apln_no", policy_apln_no);
		inputp2.put("recon_id", proc_emp_no);
		inputp3.put("proc_emp_no", proc_emp_no);


		////처리전 조회 기능 추가.. (업체에서 수정했음 )...
		////결재요청(R) , 승인(Y)
		if(process.equals("R")||process.equals("Y")){
			anyframe.log.Logger.debug.println("=============== 처리전 조회 하기 ==================");	
			
				
			PlpaymentManager manager1 = PlpaymentManager.getInstance();		
			DataSet plpayment 	= manager1.findPlpayment(inputp1); ////ysg123 m0161sp1
	
			DataSet  payment   = manager1.Inpayment(inputp2, inputp3); ////ysg123 CYBER_TBL_wb_payment조회
	
			int loanval  = 0;////현대출가능액
			int cntno = plpayment.getCount("rid_nam");////보종명
	
			for(int i=0;i<cntno;i++)
			{
				loanval   = loanval  + Integer.parseInt(plpayment.getText("loanval",i).trim());		
			}
			int amt1 = loanval;////현대출가능금액
			int amt2 = payment.getInt("apln_amt");////신청금액
			anyframe.log.Logger.debug.println("PlpaymentAction --- amt1:"+amt1);	
			anyframe.log.Logger.debug.println("PlpaymentAction --- amt2:"+amt2);	
			String strPlnCode = plpayment.getText("plancd");
			if("".equals(strPlnCode) == false || strPlnCode != null) strPlnCode = strPlnCode.substring(0,2);
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!! 보증코드 : [" + strPlnCode + "]");
			//// 변액대출일경우는 처리전조회를 하지 않음.
			if( amt1 < amt2 && ("51".equals(strPlnCode) || "53".equals(strPlnCode) || "54".equals(strPlnCode) || "55".equals(strPlnCode) || "56".equals(strPlnCode)) == false)
			{
	
				 message = "[처리전조회]신청금액이 현대출가능금액보다 많습니다.";
				msg = message;
				url = urlname;
				request.setAttribute("message", msg);
				request.setAttribute("toURL", url);
				return mapping.findForward("alert");	
	
			}
			
		}	
		
		
		
		
		
		////결재요청
		if(process.equals("R"))
		{
			input.put("gubun", "C"); ////       I - 조회 / W - 신규작성 / C - CHECK (지급,수납 처리시 체크)
			input.put("lvlnum", "21");

			DataSet ksps2000_10 = manager.findKsps2000(input);
			
			
			////sp 로그를 위한 로직... 시작
			try
			{
				
				/*업무구분코드*/
															   /*
																* 약대지급		1
																* 배당금지급		4
																* 휴면보험금지급	5
																* 배당금상계		7
																* 보험료수납		6
																* 추가보험료수납	8
																* 약대상환		2
																* APL상환		3 
																* 특약부가 1		A
																* 특약부가 2 	B
																* 특약부가 3		C 
																* 비밀번호 변경     I          
																*/
																
																
				DataSet spinputp  = new DataSet();
				
				spinputp.put("srvc_cd","1"); ////처리업무코드
				spinputp.put("sp_nm","KSPS2000"); ////sp명
				spinputp.put("tran_no",emp_no); ////처리요청자 번호				
				spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
				spinputp.put("sp_in_put",input.toString()); ////sp_in_put
				spinputp.put("sp_out_put",ksps2000_10.toString()); ////sp_out_put
				
				returns.findSpLogsave(spinputp);
						
			}catch(Exception e)
			{
			
				System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
			}
			
			////sp 로그를 위한 로직... 끝
			

			errrtn = "";
			errrtn = ksps2000_10.getText("rtn",0);

////결재요청시작
			if(errrtn.equals("0") || errrtn.equals("6"))
			{
				/* 2007년 5월 16일 안병훈 1일한도 1000만원으로 수정
								int cnt = ksps2000_10.getCount("procamt");
								if(cnt > 0)
								{
									for(int i =0; i<cnt; i++)
									{
										procamt1 = procamt1 + Integer.parseInt(ksps2000_10.getText("procamt",i));
									}
								}
				*/

				//// WB_PAYMENT에서 접수번호로 한 ROW 검색
				DataSet nameSet = new DataSet();
				nameSet.put("policy_apln_no", policy_apln_no);

				DataSet selPayment = manager.findRecei(nameSet);

				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				////[20070220] 1. webdb에서 오늘 일자로 그 주민번호에 대해서 대출받은 내역 조회하는 것 추가
				////- 오늘 처리건 중 결재완료 성공0인 것의 mode:1(지급)/srvc_cd:1(약대지급)인 것 조회
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////S/
				DataSet procamt_input 	= new DataSet();
				procamt_input.put("mode", 		"1"); ////지급
				procamt_input.put("srvc_cd", 	selPayment.getText("srvc_cd")); ////약관대출, 등등
				////procamt_input.put("rslt", 		"0"); ////성공
				procamt_input.put("ssn", 		ssn);
				DataSet procamt_info 	= manager.getProcamtInfo(procamt_input);
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////E/

				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				////[20070220] 2. procamt_sum 계산
				////- 금일 사이버센터 약관대출 합 + 현재 신청금액 = procamt_sum
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				int procamt_sum = 0;////이체금액(1000만원)
				int cnt = procamt_info.getCount("payor_ssn");

				if(cnt > 0){
					for(int i =0; i<cnt; i++){
						procamt_sum = procamt_sum + Integer.parseInt(procamt_info.getText("apln_amt",i));
					}
				}
				anyframe.log.Logger.debug.println(" (procamt_info - 조회)----  applymoney  : "+Integer.parseInt(procamt) );
				anyframe.log.Logger.debug.println(" (procamt_info - 조회)----  pay_amt  : "+procamt_sum );
				////ocamt_sum = procamt_sum + Integer.parseInt(procamt);
				anyframe.log.Logger.debug.println(" (procamt_info - 조회)----  procamt_sum  : "+procamt_sum );

				////procamt1 = 10000001;
////				if(procamt1 >10000000)
				if(procamt_sum > 10000000)
				{
					message =  "1일 지급한도 1000만원을 초과하여  불가능합니다.";
					input.put("gubun", "W" );
					input.put("lvlnum", "30");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);

					DataSet ksps2000_30 = manager.findKsps2000(input);
					////request.setAttribute("ksps2000_30", ksps2000_30);


					////sp 로그를 위한 로직... 시작
					try
					{
				
						/*업무구분코드*/
																	   /*
																		* 약대지급		1
																		* 배당금지급		4
																		* 휴면보험금지급	5
																		* 배당금상계		7
																		* 보험료수납		6
																		* 추가보험료수납	8
																		* 약대상환		2
																		* APL상환		3 
																		* 특약부가 1		A
																		* 특약부가 2 	B
																		* 특약부가 3		C 
																		* 비밀번호 변경     I          
																		*/
																
																
						DataSet spinputp  = new DataSet();
				
						spinputp.put("srvc_cd","1"); ////처리업무코드
						spinputp.put("sp_nm","KSPS2000"); ////sp명
						spinputp.put("tran_no",emp_no); ////처리요청자 번호				
						spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
						spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						spinputp.put("sp_out_put",ksps2000_30.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
					}
			
					////sp 로그를 위한 로직... 끝
					
					errrtn = "";
					errrtn = ksps2000_30.getText("rtn",0);

					////WEB 디비에 반송 저장
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

					}////WEB 디비에 반송 저장

							msg = message;
							url = urlname;
							request.setAttribute("message", msg);
							request.setAttribute("toURL", url);
							return mapping.findForward("alert");

				}////1000만원에러
				else
				{
					
					anyframe.log.Logger.debug.println("KSPS2000 실행 1차결재완료 처리구분(C)=======================================>");
					////KSPS2000실행 1차결재완료:21(조회)
					input.put("gubun", "C");
					input.put("lvlnum", "21");

					DataSet ksps2000_21C = manager.findKsps2000(input);////저장
					
					
					////sp 로그를 위한 로직... 시작
					try
					{
				
						/*업무구분코드*/
																	   /*
																		* 약대지급		1
																		* 배당금지급		4
																		* 휴면보험금지급	5
																		* 배당금상계		7
																		* 보험료수납		6
																		* 추가보험료수납	8
																		* 약대상환		2
																		* APL상환		3 
																		* 특약부가 1		A
																		* 특약부가 2 	B
																		* 특약부가 3		C 
																		* 비밀번호 변경     I          
																		*/
																
																
						DataSet spinputp  = new DataSet();
				
						spinputp.put("srvc_cd","1"); ////처리업무코드
						spinputp.put("sp_nm","KSPS2000"); ////sp명
						spinputp.put("tran_no",emp_no); ////처리요청자 번호				
						spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
						spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						spinputp.put("sp_out_put",ksps2000_21C.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
					}
			
					////sp 로그를 위한 로직... 끝
					
					
					String rtn21 = ksps2000_21C.getText("rtn").trim();
					anyframe.log.Logger.debug.println("결재요청했을때 나오는값 제발 되라=======================================>"+rtn21);
					int success = Integer.parseInt(rtn21);

						switch(success)
						{
							case(0) :
									message =  "결재요청이 처리되었습니다..";
									break;
							case(5) :
									message = "기접수되어 처리중인건이 존재합니다.";
									break;
							case(6) :
									message =  "결재요청이 처리되었습니다..";
									break;
							default :
									message =  "기타오류가 발생하였습니다. 시스템개발자에게 문의하세요..";
									break;
						}
						////KSPS2000실행 1차결재완료 21(저장)
						if(rtn21.equals("0") || rtn21.equals("6"))
						{
						input.put("gubun", "W" );
						input.put("lvlnum", "21");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);
						
						DataSet ksps2000_21W = manager.findKsps2000(input);
						
						
						////sp 로그를 위한 로직... 시작
						try
						{
				
							/*업무구분코드*/
																		   /*
																			* 약대지급		1
																			* 배당금지급		4
																			* 휴면보험금지급	5
																			* 배당금상계		7
																			* 보험료수납		6
																			* 추가보험료수납	8
																			* 약대상환		2
																			* APL상환		3 
																			* 특약부가 1		A
																			* 특약부가 2 	B
																			* 특약부가 3		C 
																			* 비밀번호 변경     I          
																			*/
																
																
							DataSet spinputp  = new DataSet();
				
							spinputp.put("srvc_cd","1"); ////처리업무코드
							spinputp.put("sp_nm","KSPS2000"); ////sp명
							spinputp.put("tran_no",emp_no); ////처리요청자 번호				
							spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
							spinputp.put("sp_in_put",input.toString()); ////sp_in_put
							spinputp.put("sp_out_put",ksps2000_21W.toString()); ////sp_out_put
				
							returns.findSpLogsave(spinputp);
						
						}catch(Exception e)
						{
			
							System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
						}
			
						////sp 로그를 위한 로직... 끝
						
						
						
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
						else if(rtn21.equals("5"))	////기접수되어있는건
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

				}////KSPS2000실행 1차결재 완료:21
			}
		}////결재요청 END
		////승인요청부분-시작
		else if(process.equals("Y"))
		{
			//// 2007년 5월 15일 안병훈 : 중복요청 막음. saveToken 이용
			//// 새로고침 했을경우나 더블클릭처럼 두번 요청 되었을경우 중복승인요청을 막는 부분.
			if (!isTokenValid(request)) {
				url = urlname;
				Logger.debug.println("saveToken 새로고침 했을경우나 더블클릭처럼 두번 요청 되었을경우 막힘.");
				request.setAttribute("message", "승인요청 진행중에 또 다른 승인요청이 중복신청 되었으므로 진행되지 않습니다.");
				request.setAttribute("toURL", url);
				return mapping.findForward("alert");
			}
			resetToken(request); //// 세션에 있는 토큰값을 초기화 한다. 중복요청시 위의 if문에 걸리게 하기 위함.

			input.put("gubun", "C");
			input.put("lvlnum", "22");
			DataSet ksps2000_10 = manager.findKsps2000(input);
			
			
			
			////sp 로그를 위한 로직... 시작
			try
			{
				
				/*업무구분코드*/
															   /*
																* 약대지급		1
																* 배당금지급		4
																* 휴면보험금지급	5
																* 배당금상계		7
																* 보험료수납		6
																* 추가보험료수납	8
																* 약대상환		2
																* APL상환		3 
																* 특약부가 1		A
																* 특약부가 2 	B
																* 특약부가 3		C 
																* 비밀번호 변경     I          
																*/
																
																
				DataSet spinputp  = new DataSet();
				
				spinputp.put("srvc_cd","1"); ////처리업무코드
				spinputp.put("sp_nm","KSPS2000"); ////sp명
				spinputp.put("tran_no",emp_no); ////처리요청자 번호				
				spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
				spinputp.put("sp_in_put",input.toString()); ////sp_in_put
				spinputp.put("sp_out_put",ksps2000_10.toString()); ////sp_out_put
				
				returns.findSpLogsave(spinputp);
						
			}catch(Exception e)
			{
			
				System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
			}
			
			////sp 로그를 위한 로직... 끝
			
			
			

			errrtn = "";
			errrtn = ksps2000_10.getText("rtn",0);
			/*
			 * KSPS2000 errrtn 결과값 설명
			 *  옵션 I 또는 W 에 대한 결과 ***
				0 - 정상
				1 - 기타오류
			  ** 옵션 C 에 대한 결과 **********
				0 - 정상
				1 - 기타오류
				5 - 기접수되어 처리중인 건이 존재한다.
				6 - 오늘날짜로 완료처리 된 건이 존재한다.
			 * */
			 
			message = "";

			////2006-09-07:김보영:0601914:승인 시에 WEBDB에서 이미 승인 된 건이 없는지 체크하는 부분 추가
			inAppv.put("policy_apln_no", 	policy_apln_no);

			outAppv1 = manager.findAppvProcessStatus(inAppv);
			outAppv2 = manager.findAppvPaymentStatus(inAppv);

			String appv_cnt 	= outAppv1.getText("appv_cnt");////상태코드 완료 80인 건이 0일 경우
			String appv_rslt	= outAppv2.getText("rslt");////결과코드 완료 0인 건이 0 일 경우 , 현재 소스에서는 사용하는 부분이 없음...

			
			if(errrtn.equals("0") || errrtn.equals("6")){  ////정상인경우

////				정상인 경우에 WEBDB 승인 된 건 유무 체크 추가
////				마지막 상태가 결재신청 단계의 프로세스 일때 에러처리 되도록 함.
				if(!appv_cnt.equals("0")){
					////처리 메세지

					message = "기승인된 건 이거나 처리중입니다. 확인 후 처리해주세요.";
					url = urlname;
					request.setAttribute("message", message);
					request.setAttribute("toURL", url);
					return mapping.findForward("alert");

				}else{

					//// 2007년 5월 23일 안병훈 : 승인요청 시작시 22코드를 넣는다.
					DataSet newSet = new DataSet();
					newSet.put("policy_apln_no", policy_apln_no);
					newSet.put("proc_emp_no", proc_emp_no);
					newSet.put("proc_status", "22");
					newSet.put("err_msg", message);
					DataSet rtnsave10 = returns.findRtnsave(newSet);

/* 2007년 5월 16일 안병훈 1일한도 1000만원으로 수정
					int cnt = ksps2000_10.getCount("procamt");
					if(cnt > 0)
					{
						for(int i =0; i<cnt; i++)
						{
							procamt1 = procamt1 + Integer.parseInt(ksps2000_10.getText("procamt",i));
						}
					}
*/
					//// WB_PAYMENT에서 접수번호로 한 ROW 검색
					DataSet nameSet = new DataSet();
					nameSet.put("policy_apln_no", policy_apln_no);
					
					DataSet selPayment = manager.findRecei(nameSet);
					
					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					////[20070220] 1. webdb에서 오늘 일자로 그 주민번호에 대해서 대출받은 내역 조회하는 것 추가
					////- 오늘 처리건 중 결재완료 성공0인 것의 mode:1(지급)/srvc_cd:1(약대지급)인 것 조회
					///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////S/
					DataSet procamt_input 	= new DataSet();
					procamt_input.put("mode", 		"1"); ////지급
					procamt_input.put("srvc_cd", 	selPayment.getText("srvc_cd")); ////약관대출, 등등
					
					procamt_input.put("ssn", 		ssn);
					DataSet procamt_info 	= manager.getProcamtInfo(procamt_input);
					///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////E/

					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					////[20070220] 2. procamt_sum 계산
					////- 금일 사이버센터 약관대출 합 + 현재 신청금액 = procamt_sum
					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					int procamt_sum = 0;////이체금액(1000만원)
					int cnt = procamt_info.getCount("payor_ssn");

					if(cnt > 0){
						for(int i =0; i<cnt; i++){
							procamt_sum = procamt_sum + Integer.parseInt(procamt_info.getText("apln_amt",i));
						}
					}
					anyframe.log.Logger.debug.println(" (procamt_info - 조회)----  applymoney  : "+Integer.parseInt(procamt) );
					anyframe.log.Logger.debug.println(" (procamt_info - 조회)----  pay_amt  : "+procamt_sum );
					anyframe.log.Logger.debug.println(" (procamt_info - 조회)----  procamt_sum  : "+procamt_sum );


					if(procamt_sum > 10000000)
					{
						message =  "1일 지급한도 1000만원을 초과하여  불가능합니다.";
						input.put("gubun", "W" );
						input.put("lvlnum", "30");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);

						DataSet ksps2000_30 = manager.findKsps2000(input);
						
						
						
						////sp 로그를 위한 로직... 시작
						try
						{
				
							/*업무구분코드*/
																		   /*
																			* 약대지급		1
																			* 배당금지급		4
																			* 휴면보험금지급	5
																			* 배당금상계		7
																			* 보험료수납		6
																			* 추가보험료수납	8
																			* 약대상환		2
																			* APL상환		3 
																			* 특약부가 1		A
																			* 특약부가 2 	B
																			* 특약부가 3		C 
																			* 비밀번호 변경     I          
																			*/
																
																
							DataSet spinputp  = new DataSet();
				
							spinputp.put("srvc_cd","1"); ////처리업무코드
							spinputp.put("sp_nm","KSPS2000"); ////sp명
							spinputp.put("tran_no",emp_no); ////처리요청자 번호				
							spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
							spinputp.put("sp_in_put",input.toString()); ////sp_in_put
							spinputp.put("sp_out_put",ksps2000_30.toString()); ////sp_out_put
				
							returns.findSpLogsave(spinputp);
						
						}catch(Exception e)
						{
			
							System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
						}
			
						////sp 로그를 위한 로직... 끝
						
						
						
						
						////request.setAttribute("ksps2000_30", ksps2000_30);

						errrtn = "";
						errrtn = ksps2000_30.getText("rtn",0);

						////WEB 디비에 반송 저장
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

						}////WEB 디비에 반송 저장

								msg = message;
								url = urlname;
								request.setAttribute("message", msg);
								request.setAttribute("toURL", url);
								return mapping.findForward("alert");
					}
					else
					{
						////KSPS2000실행 2차결재완료:22(저장)
						input.put("gubun", "W" );
						input.put("lvlnum", "22");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);

						DataSet ksps2000_22W = manager.findKsps2000(input);////저장
						
						
						
						////sp 로그를 위한 로직... 시작
						try
						{
				
							/*업무구분코드*/
																		   /*
																			* 약대지급		1
																			* 배당금지급		4
																			* 휴면보험금지급	5
																			* 배당금상계		7
																			* 보험료수납		6
																			* 추가보험료수납	8
																			* 약대상환		2
																			* APL상환		3 
																			* 특약부가 1		A
																			* 특약부가 2 	B
																			* 특약부가 3		C 
																			* 비밀번호 변경     I          
																			*/
																
																
							DataSet spinputp  = new DataSet();
				
							spinputp.put("srvc_cd","1"); ////처리업무코드
							spinputp.put("sp_nm","KSPS2000"); ////sp명
							spinputp.put("tran_no",emp_no); ////처리요청자 번호				
							spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
							spinputp.put("sp_in_put",input.toString()); ////sp_in_put
							spinputp.put("sp_out_put",ksps2000_22W.toString()); ////sp_out_put
				
							returns.findSpLogsave(spinputp);
						
						}catch(Exception e)
						{
			
							System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
						}
			
						////sp 로그를 위한 로직... 끝
						
						
						
						String rtn22 = ksps2000_22W.getText("rtn").trim();

						errrtn = "";
						errrtn = ksps2000_22W.getText("rtn",0);
						if(errrtn.equals("0"))
						{
							/*
							 *		2007년 5월 23 안병훈 : 승인요청 시작시 22로 바꿔주므로 insert 하지 않음. WEBDB.CYBER의 PROCESS 테이블.. 
							
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

							////2006-12-27 김보영 : M0181SP1을 처리하기 전에 은행처리 보냈다는 40번 CODE를 셋팅해준다.
							////KSPS2000실행 은행처리전송상태:40(저장)
							input.put("gubun", "W" );
							input.put("lvlnum", "40");
							input.put("cltbk", cltbk);
							input.put("cltact", cltact);
							input.put("cltnum", cltnum);
							input.put("procamt", procamt);

							////KSPS2000실행(은행전문송신:40)
							DataSet ksps2000_40 = manager.findKsps2000(input);
							
							
							////sp 로그를 위한 로직... 시작
							try
							{
				
								/*업무구분코드*/
																			   /*
																				* 약대지급		1
																				* 배당금지급		4
																				* 휴면보험금지급	5
																				* 배당금상계		7
																				* 보험료수납		6
																				* 추가보험료수납	8
																				* 약대상환		2
																				* APL상환		3 
																				* 특약부가 1		A
																				* 특약부가 2 	B
																				* 특약부가 3		C 
																				* 비밀번호 변경     I          
																				*/
																
																
								DataSet spinputp  = new DataSet();
				
								spinputp.put("srvc_cd","1"); ////처리업무코드
								spinputp.put("sp_nm","KSPS2000"); ////sp명
								spinputp.put("tran_no",emp_no); ////처리요청자 번호				
								spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
								spinputp.put("sp_in_put",input.toString()); ////sp_in_put
								spinputp.put("sp_out_put",ksps2000_40.toString()); ////sp_out_put
				
								returns.findSpLogsave(spinputp);
						
							}catch(Exception e)
							{
			
								System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
							}
			
							////sp 로그를 위한 로직... 끝
							
							
							
							
							errrtn = "";
							errrtn = ksps2000_40.getText("rtn");

							////WEBDB 저장(은행전문송신:40)
							if(errrtn.equals("0")){
								input1.put("policy_apln_no", policy_apln_no);
								input1.put("proc_emp_no", proc_emp_no);
								input1.put("proc_status", "40");
								input1.put("err_msg", message);
								DataSet rtnsave10_40 = returns.findRtnsave(input1);  ////CYBER_TBL_wb_process 상태값 입력.

								////여기에서 부터 승인을 받았을때 본격적인 M0181SP1을 실행한다.
								input3.put("deptcd", "INT");
								input3.put("init", tproc_emp_no);
								input3.put("opt1", opt1);
								input3.put("opt2", "U");
								input3.put("policy", policy);

								//// [05-B-353] 2005-08-22 이위혁. regdate 정상적으로 넘어오지않아 indate로 대체
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
								System.out.println("변액대출중 강제처리 일경우 값 : [" + variable_div + "]");

								anyframe.log.Logger.debug.println("Action M0181SP1  input3==========="+input3);
								DataSet approval = Pmanager.getApproval(input3, input4, input5);////결재,policy_apln_no,proc_emp_no




////								sp 로그를 위한 로직... 시작
										  try
										  {
				
											  /*업무구분코드*/
																							 /*
																							  * 약대지급		1
																							  * 배당금지급		4
																							  * 휴면보험금지급	5
																							  * 배당금상계		7
																							  * 보험료수납		6
																							  * 추가보험료수납	8
																							  * 약대상환		2
																							  * APL상환		3 
																							  * 특약부가 1		A
																							  * 특약부가 2 	B
																							  * 특약부가 3		C 
																							  * 비밀번호 변경     I          
																							  */
											 					
																
											  DataSet spinputp  = new DataSet();
				
											  spinputp.put("srvc_cd","1"); ////처리업무코드
											  spinputp.put("sp_nm","M0181SP1"); ////sp명
											  spinputp.put("tran_no",emp_no); ////처리요청자 번호				
											  spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
											  spinputp.put("sp_in_put",input3.toString()); ////sp_in_put
											  spinputp.put("sp_out_put",approval.toString()); ////sp_out_put
				
											  returns.findSpLogsave(spinputp);
						
										  }catch(Exception e)
										  {
			
											  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
										  }
			
										  ////sp 로그를 위한 로직... 끝
										  
										  
										  
								sending_num = approval.getText("sndseq");////전송번호
								input9.put("policy_apln_no", policy_apln_no);
								input9.put("sending_num", sending_num);
								input9.put("pay_dt", Util.getTodayToYMD().substring(0,8));
								anyframe.log.Logger.debug.println("지연이 떨어질때 input값들==========="+input9);
								DataSet sending = manager.Sendingsave(input9);////전송번호 저장

								realpay.put("policy_apln_no", policy_apln_no);////전송번호
								////realpay.put("pay_amt", approval.getText("netpay"));////실지급금
								realpay.put("pay_amt", cash);

								errrtn = approval.getText("rtn");

								message1 = Util.superTrim(approval.getText("errmsg1")) + Util.superTrim(approval.getText("errmsg2")) + Util.superTrim(approval.getText("errmsg3"));

								//// 2007.5.15 안병훈
								//// 에러 메세지중 AAAA가 포함된 문자가 있을경우 SMS 발송.
								anyframe.log.Logger.debug.println("리턴 코approval.getText(errmsg1)====>"+approval.getText("errmsg1"));
////								AAAA테스트
////								approval.put("errmsg1", "DGAAAA있읍니다.");
								if(Util.superTrim(approval.getText("errmsg1")).indexOf("AAAA") != -1) {
									System.out.println("########################## CybercenterAction.java AAAA 에러시 로직 수행 #############################");

									String srvc_gubunc = selPayment.getText("srvc_cd");
									String strGubun = "";
									if(srvc_gubunc.equals("1"))////약관대출신청
									{
										strGubun = "약관대출신청";
									}
									else if(srvc_gubunc.equals("2"))////약관대출상환
									{
										strGubun = "약관대출상환";
									}
									else if(srvc_gubunc.equals("3"))////자동대출납부상환
									{
										strGubun = "자동대출납부상환";
									}
									else if(srvc_gubunc.equals("4"))////배당금
									{
										strGubun = "배당금";
									}
									else if(srvc_gubunc.equals("5"))////휴면보험금
									{
										strGubun = "휴면보험금";
									}
									else if(srvc_gubunc.equals("6"))////보험료수납
									{
										strGubun = "보험료수납";
									}
									else if(srvc_gubunc.equals("7"))////배당금상계
									{
										strGubun = "배당금상계";
									}

									String payor_nm = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm"))); //// 고객명

									///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
									//// SMS 발송
									///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
									//// 권한 조회에서 핸드폰 수신이 되있는 모든 리스트를 가져옴.
									DataSet smsSet = new DataSet();
									smsSet.put("page", "0");
									smsSet.put("where", " and hand_phone_yn = 'Y'");
									smsSet.put("subwhere", "");

									AuthManager managerSms = AuthManager.getInstance();
									DataSet authval = managerSms.findAuth(smsSet);

									anyframe.log.Logger.debug.println("고객메일 보내기 위한 필드 strGubun : "+strGubun);

									//// SMS 발송
									for(int i=0;i<authval.getCount("emp_no");i++) {

										//// ex) 사이버 이중지급 확인요망 100500000 홍길동, 약관대출 (or해약, 휴면) 00000원 [지티원사이버]승인요청중 AAAA가 발견되었습니다.");" +
										String strMsg = "[지티원사이버]이중지급확인" + policy + payor_nm + " " + strGubun + Integer.parseInt(procamt) + "원 AAAA발견";

										DataSet sendSmsInput = new DataSet();
										sendSmsInput.put("RECEIVER_MOBILE", authval.getText("hand_phone", i));
										sendSmsInput.put("CUS_CALL_BACK",   "15883374");
										sendSmsInput.put("CUS_MSG",         strMsg);
										sendSmsInput.put("TRAN_ETC1",       to_year);
										sendSmsInput.put("TRAN_ETC2",       "");
										sendSmsInput.put("TRAN_ETC3",       "CU");
										
										
										////2007.06.14 추가....
										/*업무구분코드*/
												   /*
													* 약대지급		1
													* 배당금지급		4
													* 휴면보험금지급	5
													* 배당금상계		7
													* 보험료수납		6
													* 추가보험료수납	8
													* 약대상환		2
													* APL상환		3 
													* 특약부가 1		A
													* 특약부가 2 	B
													* 특약부가 3		C 
													* 비밀번호 변경     I          
													*/
										sendSmsInput.put("srvc_cd", srvc_gubunc);  ////업무코드
            
										sendSmsInput.put("policy_no", policy); ////증권번호
										sendSmsInput.put("tran_ssn",authval.getText("emp_no", i)); ////처리신청자주민및사번
										sendSmsInput.put("tran_nm",authval.getText("emp_nm", i));  ////처리신청자성명 

										manager2.sendSimpleSms(sendSmsInput);
									}

									///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
									//// 이메일 발송
									///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
									//// 권한 조회에서 이메일 수신이 되있는 모든 리스트를 가져옴.
									smsSet = new DataSet();
									smsSet.put("page", "0");
									smsSet.put("where", " and email_yn = 'Y'");
									smsSet.put("subwhere", "");

									authval = managerSms.findAuth(smsSet);

									////이메일 발송
									for(int i=0;i<authval.getCount("emp_no");i++) {
										//// ex) 사이버 이중지급 확인요망 100500000 홍길동, 약관대출 (or해약, 휴면) 00000원 [지티원사이버]승인요청중 AAAA가 발견되었습니다.");" +
										String strSubject = policy + " " + payor_nm + ", " + strGubun + " " + Integer.parseInt(procamt) + "원 [지티원사이버]승인요청중 AAAA가 발견되었습니다.";
										//// ex)
										////	사이버 이중지급 가능성 있으니 확인 바랍니다.
										////	증번 : 100500000
										////	계약자명 : 홍길동
										////	약관대출 (or 해약, 휴면) 00000원
										////	처리자 : OOO
										////	처리시간 OO:OO:OO

										String strContent = strSubject + "|" + "사이버 이중지급 가능성 있으니 확인 바랍니다. <br>"
																	+ "증번 : " + policy + "<br>"
																	+ "계약자명 : " + payor_nm + "<br>"
																	+ strGubun + " : " + Integer.parseInt(procamt) + "원<br>"
																	+ "처리자 : " + authval.getText("emp_nm", i) + "<br>"
																	+ "처리시간 : " + gtone.changeminer.common.utility.Utility.getToday();

										DataSet emailSet = new DataSet();
										////메일보내기(고객)
										emailSet.put("param1", "05");
										////emailSet.put("param2", "12"); //// 개발
										emailSet.put("param2", "01"); //// 실서버
										emailSet.put("param3", "00000029");
										emailSet.put("to_name", authval.getText("emp_nm", i));//// 이름
										emailSet.put("to_email_addr", authval.getText("email", i));//// 이메일
										emailSet.put("content", strContent); //// 내용





										anyframe.log.Logger.debug.println("고객메일 보내기 위한 필드 CyberAction Input : "+emailSet);
										DataSet mailcu = mailsend.sendSimpleMail(emailSet);
									}

									////고객에게 반송사유 문자 보내기 완료
								}

								if(errrtn.equals("0"))
								{
									DataSet netpay = manager.Realpaysave(realpay);////실지급금저장

									////KSPS2000 실행(은행,HOST처리성공 :80)
									input.put("gubun", "W" );
									input.put("lvlnum", "80");
									input.put("cltbk", cltbk);
									input.put("cltact", cltact);
									input.put("cltnum", cltnum);
									input.put("procamt", procamt);
									DataSet ksps2000_80 = manager.findKsps2000(input);
									
									
									////sp 로그를 위한 로직... 시작
									try
									{
				
										/*업무구분코드*/
																					   /*
																						* 약대지급		1
																						* 배당금지급		4
																						* 휴면보험금지급	5
																						* 배당금상계		7
																						* 보험료수납		6
																						* 추가보험료수납	8
																						* 약대상환		2
																						* APL상환		3 
																						* 특약부가 1		A
																						* 특약부가 2 	B
																						* 특약부가 3		C 
																						* 비밀번호 변경     I          
																						*/
																
																
										DataSet spinputp  = new DataSet();
				
										spinputp.put("srvc_cd","1"); ////처리업무코드
										spinputp.put("sp_nm","KSPS2000"); ////sp명
										spinputp.put("tran_no",emp_no); ////처리요청자 번호				
										spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
										spinputp.put("sp_in_put",input.toString()); ////sp_in_put
										spinputp.put("sp_out_put",ksps2000_80.toString()); ////sp_out_put
				
										returns.findSpLogsave(spinputp);
						
									}catch(Exception e)
									{
			
										System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
									}
			
									////sp 로그를 위한 로직... 끝
									
									
									
									message = "정상적으로 승인되었습니다.";

									////WEB DB저장(은행-HOST처리성공 80)
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

									////WB_PAYMENT에서 접수번호를 키값으로 해당 자료를 Search
									input11.put("policy_apln_no", policy_apln_no);

									selPayment = manager.findRecei(input11);

									String payor_nm = Util.superTrim(selPayment.getText("payor_nm").trim());
									String v_to_mail = selPayment.getText("payor_email");
									String mapping1 = "";
									String apln_dt = selPayment.getText("apln_dt").substring(0,10);
									apln_dt = StringFormater.removeZero(apln_dt.substring(0,4)) +" 년 " + StringFormater.removeZero(apln_dt.substring(5,7)) +" 월 "+ StringFormater.removeZero(apln_dt.substring(8,10)) +" 일";

									to_year = null;
									v_toyear = Util.getTodayToYMD();
									to_year = v_toyear.substring(0,8);
									String pay_dt  = "";
									pay_dt = to_year;
									if(pay_dt.length() == 8)
									{
										pay_dt = StringFormater.removeZero(pay_dt.substring(0,4)) + " 년 "+ StringFormater.removeZero(pay_dt.substring(4,6)) +" 월 "+ StringFormater.removeZero(pay_dt.substring(6,8)) +" 일";
									}
									String apln_amt = "";
									apln_amt = selPayment.getText("apln_amt");
									apln_amt = selPayment.getText("apln_amt");
									apln_amt = Util.addComma(apln_amt);
									mapping1 = payor_nm +"|"+ selPayment.getText("srvc_name") +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+ apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+ selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";

									anyframe.log.Logger.debug.println("고객에게 메일보내기 위한 CyberAction임");
									////메일보내기(고객)
									input10.put("v_mail_type", "03");
									input10.put("v_mail_type_seq", Variable.get("email-id.cyber03"));////54
									input10.put("v_channel_code", "00000030");
									input10.put("v_member_id", cltnum);////고객주민번호
									input10.put("v_to_name", payor_nm);////고객명
									input10.put("v_to_email",  selPayment.getText("payor_email"));////고객이메일

									input10.put("v_mapping", mapping1);
									input10.put("v_lp_code", selPayment.getText("lp_id"));
									input10.put("v_policy_number", selPayment.getText("policy_no"));
									input10.put("v_channel", "cyber");
									input10.put("v_ilips_client_id", "");

									anyframe.log.Logger.debug.println("고객메일 보내기 위한 필드 CyberAction Input : "+input10);
									DataSet mailcu = mailsend.sendMail(input10);
									request.setAttribute("mailcu",mailcu);
									anyframe.log.Logger.debug.println("고객메일 보내기 위한 필드 CyberAction output : "+mailcu);



									////LP에게 메일 보내기
									anyframe.log.Logger.debug.println("LP에게 메일보내기 위한 CyberAction임");
									input10.put("v_mail_type", "03");
									input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
									input10.put("v_channel_code", "00000030");
									input10.put("v_member_id", cltnum);

									input10.put("v_to_email", selPayment.getText("lp_email"));
									mapping1 = "";
									String lpname = "";
									lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname").trim()));
									mapping1 = lpname +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnum +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
									input10.put("v_mapping", mapping1);

									anyframe.log.Logger.debug.println("LP메일 보내기 위한 필드 CyberAction Input : "+input10);
									input10.put("v_lp_code", selPayment.getText("lp_id"));
									DataSet maillp = mailsend.sendMail(input10);
									request.setAttribute("maillp",maillp);
									anyframe.log.Logger.debug.println("LP메일 보내기 위한 필드 CyberAction output : "+maillp);



									anyframe.log.Logger.debug.println("고객에게 SMS 보내기 위한 필드1 CyberAction");
									////고객에게 SMS보내기
									String owner_mobile  	= selPayment.getText("payor_phone");////핸드폰
									String lp_code       	= "";////LP사번
									String amt           	= Util.addComma(StringFormater.removeZero(selPayment.getText("apln_amt")));////금액
									String gubun1         = selPayment.getText("pay_cd");////상환구분
									String sms_code = "";
									String srvc_gubunc = "";
									String owner = "";
									owner = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm")));

									srvc_gubunc = selPayment.getText("srvc_cd");
									if(srvc_gubunc.equals("1"))////약관대출신청
									{
										sms_code = "5";
									}
									else if(srvc_gubunc.equals("2"))////약관대출상환
									{
										sms_code = "9";
									}
									else if(srvc_gubunc.equals("3"))////자동대출납부상환
									{
										sms_code = "11";
									}
									else if(srvc_gubunc.equals("4"))////배당금
									{
										sms_code = "6";
									}
									else if(srvc_gubunc.equals("5"))////휴면보험금
									{
										sms_code = "25";
									}
									else if(srvc_gubunc.equals("6"))////보험료수납
									{
										sms_code = "8";
									}
									else if(srvc_gubunc.equals("7"))////배당금상계
									{
										sms_code = "7";
									}


////									/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////SMS발송
									String indate1 = "";
									indate1 = selPayment.getText("policy_apln_no").substring(0,8);

									smscu.put("v_sms_code",  		sms_code);////SMS 메시지 업무코드
									smscu.put("v_success_yn",  	"0");////0-성공,1-실패
									smscu.put("v_policy_no",  	selPayment.getText("policy_no"));
									smscu.put("v_name",  			owner);
									smscu.put("v_owner",  		owner);
									smscu.put("v_owner_mobile",  	owner_mobile);
									smscu.put("v_lp_code",  		lp_code);
									smscu.put("v_amt",  			amt);
									smscu.put("v_gubun",  		gubun1);

									smscu.put("tran_etc1",  		indate1);////입력날짜
									smscu.put("tran_etc2",  		selPayment.getText("policy_apln_no"));////실질 순번
									smscu.put("v_pr",  			"CU");
									anyframe.log.Logger.debug.println("고객에게 SMS 보내기 위한 필드 CyberAction input==>"+smscu);
									
									
									
									
									
									
									
									
									DataSet sms_ins_cu = manager2.findClientSms(smscu);////CU만
									anyframe.log.Logger.debug.println("고객에게 SMS 보내기 위한 필드 CyberAction output==>"+sms_ins_cu);

									////처리 성공 메세지
									message = "정상적으로 승인되었습니다.";
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
									
									
									////sp 로그를 위한 로직... 시작
									try
									{
				
										/*업무구분코드*/
																					   /*
																						* 약대지급		1
																						* 배당금지급		4
																						* 휴면보험금지급	5
																						* 배당금상계		7
																						* 보험료수납		6
																						* 추가보험료수납	8
																						* 약대상환		2
																						* APL상환		3 
																						* 특약부가 1		A
																						* 특약부가 2 	B
																						* 특약부가 3		C 
																						* 비밀번호 변경     I          
																						*/
																
																
										DataSet spinputp  = new DataSet();
				
										spinputp.put("srvc_cd","1"); ////처리업무코드
										spinputp.put("sp_nm","KSPS2000"); ////sp명
										spinputp.put("tran_no",emp_no); ////처리요청자 번호				
										spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
										spinputp.put("sp_in_put",input.toString()); ////sp_in_put
										spinputp.put("sp_out_put",ksps2000_50.toString()); ////sp_out_put
				
										returns.findSpLogsave(spinputp);
						
									}catch(Exception e)
									{
			
										System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
									}
			
									////sp 로그를 위한 로직... 끝
									
									
									
									message = "은행처리 지연입니다. 일정시간후 다시 확인하세요.";

									////WEB DB저장(은행-HOST처리 지연 50)
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

									////처리 성공 메세지
									message = "은행처리 지연입니다. 일정시간후 다시 확인하세요.";
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
									
									
									////sp 로그를 위한 로직... 시작
									try
									{
				
										/*업무구분코드*/
																					   /*
																						* 약대지급		1
																						* 배당금지급		4
																						* 휴면보험금지급	5
																						* 배당금상계		7
																						* 보험료수납		6
																						* 추가보험료수납	8
																						* 약대상환		2
																						* APL상환		3 
																						* 특약부가 1		A
																						* 특약부가 2 	B
																						* 특약부가 3		C 
																						* 비밀번호 변경     I          
																						*/
																
																
										DataSet spinputp  = new DataSet();
				
										spinputp.put("srvc_cd","1"); ////처리업무코드
										spinputp.put("sp_nm","KSPS2000"); ////sp명
										spinputp.put("tran_no",emp_no); ////처리요청자 번호				
										spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
										spinputp.put("sp_in_put",input.toString()); ////sp_in_put
										spinputp.put("sp_out_put",ksps2000_80.toString()); ////sp_out_put
				
										returns.findSpLogsave(spinputp);
						
									}catch(Exception e)
									{
			
										System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
									}
			
									////sp 로그를 위한 로직... 끝
									
									
									
									
									message = "은행처리 전,후 에러입니다. 관리자 확인 필요합니다.";
									////WEB DB저장(기타 오류 -99)
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

									////처리 성공 메세지
									message = "은행처리 전,후 에러입니다. 관리자 확인 필요합니다.";
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
									
									
									
									
									////sp 로그를 위한 로직... 시작
									try
									{
				
										/*업무구분코드*/
																					   /*
																						* 약대지급		1
																						* 배당금지급		4
																						* 휴면보험금지급	5
																						* 배당금상계		7
																						* 보험료수납		6
																						* 추가보험료수납	8
																						* 약대상환		2
																						* APL상환		3 
																						* 특약부가 1		A
																						* 특약부가 2 	B
																						* 특약부가 3		C 
																						* 비밀번호 변경     I          
																						*/
																
																
										DataSet spinputp  = new DataSet();
				
										spinputp.put("srvc_cd","1"); ////처리업무코드
										spinputp.put("sp_nm","KSPS2000"); ////sp명
										spinputp.put("tran_no",emp_no); ////처리요청자 번호				
										spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
										spinputp.put("sp_in_put",input.toString()); ////sp_in_put
										spinputp.put("sp_out_put",ksps2000_80.toString()); ////sp_out_put
				
										returns.findSpLogsave(spinputp);
						
									}catch(Exception e)
									{
			
										System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
									}
			
									////sp 로그를 위한 로직... 끝
									
									
									
									
									
									
									
									
									message = "해당요청의 은행처리 실패입니다. 잔고확인및 재실행하세요.";

									////WEB DB저장(은행처리결과 실패-61)
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

									////처리 성공 메세지

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
									
									
									
									
									
									
									////sp 로그를 위한 로직... 시작
									try
									{
				
										/*업무구분코드*/
																					   /*
																						* 약대지급		1
																						* 배당금지급		4
																						* 휴면보험금지급	5
																						* 배당금상계		7
																						* 보험료수납		6
																						* 추가보험료수납	8
																						* 약대상환		2
																						* APL상환		3 
																						* 특약부가 1		A
																						* 특약부가 2 	B
																						* 특약부가 3		C 
																						* 비밀번호 변경     I          
																						*/
																
																
										DataSet spinputp  = new DataSet();
				
										spinputp.put("srvc_cd","1"); ////처리업무코드
										spinputp.put("sp_nm","KSPS2000"); ////sp명
										spinputp.put("tran_no",emp_no); ////처리요청자 번호				
										spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
										spinputp.put("sp_in_put",input.toString()); ////sp_in_put
										spinputp.put("sp_out_put",ksps2000_70.toString()); ////sp_out_put
				
										returns.findSpLogsave(spinputp);
						
									}catch(Exception e)
									{
			
										System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
									}
			
									////sp 로그를 위한 로직... 끝
									
									
									
									
									message = "HOST 처리 실패입니다. 관리자에게 문의하세요.";

									////WEB DB저장(은행성공+HOST실패)
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

									////처리 성공 메세지

									msg = message;
											url = urlname;
											request.setAttribute("message", message1);
											request.setAttribute("toURL", url);
											return mapping.findForward("alert");
								}


							}////KSPS2000에서 (은행전문송신:40)결과 체크
						
						}////KSPS2000에서 22로 저장할때 리턴값이 0이외의 경우
					
					}////약관대출금액이 1000만원보다 적을경우
				
				}////이미 승인된 결과가 있는 경우
			
			}////RTN이 0과 6인경우
			else if(errrtn.equals("5") || errrtn.equals("1"))
			{
				if(errrtn.equals("5"))
					message = "기접수되어 처리중인 건이 존재합니다. 확인후 결제요청하세요. ";
				else if(errrtn.equals("1"))
					message =  "기타오류가 발생하였습니다. 시스템 개발자에게 문의하세요.";
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
		else if(process.equals("K"))////지연건인 경우 처리
		{
			input8.put("policy_apln_no", policy_apln_no);
			DataSet sendall = manager.findSend(input8);
			sendingnum = sendall.getText("sending_num");////전송번호
			date = sendall.getText("date");////전송일자

			//// [05-B-353] 2005-08-22 이위혁. 인수명 오류 수정
			input7.put("musera", "INTUSER");
			input7.put("snddate", date);
			input7.put("sndseq", sendingnum);

			anyframe.log.Logger.debug.println("지연일때 KSPS0450일때 INPUT값들은1111111====>"+input7);

			DataSet ksps0450 = manager.findIsaogong(input7);////KSPS0450실행

			rtn0450 = ksps0450.getText("rtn");
			message = ksps0450.getText("errmsg");
			if(rtn0450.equals("1") || rtn0450.equals("3"))
			{
				////message = "프로그램실행중 에러및 지연건입니다. 관리자에게 문의하세요.";
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
				
				
				
				
				
				////sp 로그를 위한 로직... 시작
				try
				{
				
					/*업무구분코드*/
																   /*
																	* 약대지급		1
																	* 배당금지급		4
																	* 휴면보험금지급	5
																	* 배당금상계		7
																	* 보험료수납		6
																	* 추가보험료수납	8
																	* 약대상환		2
																	* APL상환		3 
																	* 특약부가 1		A
																	* 특약부가 2 	B
																	* 특약부가 3		C 
																	* 비밀번호 변경     I          
																	*/
																
																
					DataSet spinputp  = new DataSet();
				
					spinputp.put("srvc_cd","1"); ////처리업무코드
					spinputp.put("sp_nm","KSPS2000"); ////sp명
					spinputp.put("tran_no",emp_no); ////처리요청자 번호				
					spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
					spinputp.put("sp_in_put",input.toString()); ////sp_in_put
					spinputp.put("sp_out_put",ksps2000_61.toString()); ////sp_out_put
				
					returns.findSpLogsave(spinputp);
						
				}catch(Exception e)
				{
			
					System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
				}
			
				////sp 로그를 위한 로직... 끝
				
				
				
				
				
				
				
				
				
				

				errrtn = "";
				errrtn = ksps2000_61.getText("rtn",0);
				message = ksps2000_61.getText("errmsg");
				if(errrtn.equals("0"))
				{
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "60");
					input1.put("err_msg", message);
					DataSet rtnsavek0 = returns.findRtnsave(input1);  ////process 테이블 저장

					input2.put("policy_apln_no", policy_apln_no);
					input2.put("proc_status", "2");
					input2.put("err_msg", message);
					input2.put("recon_id", proc_emp_no);
					DataSet rtnsavek1 = returns.findRtnsave1(input2); ////payment 테이블 저장
				}////WEB DB저장(은행처리결과 실패-61
			}////은행실패에 관한권
			else if(rtn0450.equals("0"))
			{
				////여기에서 부터 승인을 받았을때 본격적인 M0181SP1을 실행한다.
				input3.put("deptcd", "INT");
				input3.put("init", tproc_emp_no);
				input3.put("opt1", opt1);
				input3.put("opt2", "H");
				input3.put("policy", policy);
				//// [05-B-353] 2005-08-22 이위혁. regdate 정상적으로 넘어오지않아 indate로 대체
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

				anyframe.log.Logger.debug.println("지연건에 대한 M0181SP1  input3==========="+input3);
				DataSet approval5 = Pmanager.getApproval(input3, input4, input5);////결재,policy_apln_no,proc_emp_no


////				sp 로그를 위한 로직... 시작
						  try
						  {
				
							  /*업무구분코드*/
																			 /*
																			  * 약대지급		1
																			  * 배당금지급		4
																			  * 휴면보험금지급	5
																			  * 배당금상계		7
																			  * 보험료수납		6
																			  * 추가보험료수납	8
																			  * 약대상환		2
																			  * APL상환		3 
																			  * 특약부가 1		A
																			  * 특약부가 2 	B
																			  * 특약부가 3		C 
																			  * 비밀번호 변경     I          
																			  */
											 					
																
							  DataSet spinputp  = new DataSet();
				
							  spinputp.put("srvc_cd","1"); ////처리업무코드
							  spinputp.put("sp_nm","M0181SP1"); ////sp명
							  spinputp.put("tran_no",emp_no); ////처리요청자 번호				
							  spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
							  spinputp.put("sp_in_put",input3.toString()); ////sp_in_put
							  spinputp.put("sp_out_put",approval5.toString()); ////sp_out_put
				
							  returns.findSpLogsave(spinputp);
						
						  }catch(Exception e)
						  {
			
							  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
						  }
			
						  ////sp 로그를 위한 로직... 끝


				realpay.put("policy_apln_no", policy_apln_no);////전송번호
				////realpay.put("pay_amt", approval5.getText("netpay"));////실지급금
				realpay.put("pay_amt", cash);

				errrtn = approval5.getText("rtn");
				message1 = Util.superTrim(approval5.getText("errmsg1")) + Util.superTrim(approval5.getText("errmsg2")) + Util.superTrim(approval5.getText("errmsg3"));

				if(errrtn.equals("0"))
				{
					DataSet netpay = manager.Realpaysave(realpay);////실지급금저장

					////KSPS2000 실행(은행,HOST처리성공 :80)
					input.put("gubun", "W" );
					input.put("lvlnum", "80");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);
					DataSet ksps2000_801 = manager.findKsps2000(input);
					
					
					
					
					////sp 로그를 위한 로직... 시작
					try
					{
				
						/*업무구분코드*/
																	   /*
																		* 약대지급		1
																		* 배당금지급		4
																		* 휴면보험금지급	5
																		* 배당금상계		7
																		* 보험료수납		6
																		* 추가보험료수납	8
																		* 약대상환		2
																		* APL상환		3 
																		* 특약부가 1		A
																		* 특약부가 2 	B
																		* 특약부가 3		C 
																		* 비밀번호 변경     I          
																		*/
																
																
						DataSet spinputp  = new DataSet();
				
						spinputp.put("srvc_cd","1"); ////처리업무코드
						spinputp.put("sp_nm","KSPS2000"); ////sp명
						spinputp.put("tran_no",emp_no); ////처리요청자 번호				
						spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
						spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						spinputp.put("sp_out_put",ksps2000_801.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
					}
			
					////sp 로그를 위한 로직... 끝
					

					

					////WEB DB저장(은행-HOST처리성공 80)
					message = "정상적으로 승인되었습니다.";
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


					////WB_PAYMENT에서 접수번호를 키값으로 해당 자료를 Search
					input11.put("policy_apln_no", policy_apln_no);

					DataSet selPayment = manager.findRecei(input11);

					String payor_nm = selPayment.getText("payor_nm");
					String v_to_mail = selPayment.getText("payor_email");
					String mapping1 = "";
					String apln_dt = selPayment.getText("apln_dt").substring(0,10);
					apln_dt = StringFormater.removeZero(apln_dt.substring(0,4)) +" 년 " + StringFormater.removeZero(apln_dt.substring(5,7)) +" 월 "+ StringFormater.removeZero(apln_dt.substring(8,10)) +" 일";

					to_year = null;
					v_toyear = Util.getTodayToYMD();
					to_year = v_toyear.substring(0,8);
					String pay_dt  = "";
					pay_dt = to_year;
					if(pay_dt.length() == 8)
					{
						pay_dt = StringFormater.removeZero(pay_dt.substring(0,4)) + " 년 "+ StringFormater.removeZero(pay_dt.substring(4,6)) +" 월 "+ StringFormater.removeZero(pay_dt.substring(6,8)) +" 일";
					}
					String apln_amt = "";
					apln_amt = selPayment.getText("apln_amt");
					apln_amt = Util.addComma(apln_amt);
					mapping1 = payor_nm +"|"+ selPayment.getText("srvc_name") +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+ apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+ selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";

					////메일보내기(고객)
					input10.put("v_mail_type", "03");
					input10.put("v_mail_type_seq", Variable.get("email-id.cyber03"));////54
					input10.put("v_channel_code", "00000030");
					input10.put("v_member_id", cltnum);////고객주민번호
					input10.put("v_to_name", payor_nm);////고객명
					input10.put("v_to_email",  selPayment.getText("payor_email"));////고객이메일

					input10.put("v_mapping", mapping1);
					input10.put("v_lp_code", selPayment.getText("lp_id"));
					input10.put("v_policy_number", selPayment.getText("policy_no"));
					input10.put("v_channel", "cyber");
					input10.put("v_ilips_client_id", "");

					anyframe.log.Logger.debug.println("메일 보내기 위한 필드  : "+input10);
					DataSet mailcu = mailsend.sendMail(input10);
					request.setAttribute("mailcu",mailcu);

					////LP에게 메일 보내기

					input10.put("v_mail_type", "03");
					input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
					input10.put("v_channel_code", "00000030");
					input10.put("v_member_id", cltnum);

					input10.put("v_to_email", selPayment.getText("lp_email"));
					mapping1 = "";
					String lpname = "";
					lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname")));
					mapping1 = lpname +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnum +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
					input10.put("v_mapping", mapping1);

					anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 필드  : "+input10);
					input10.put("v_lp_code", selPayment.getText("lp_id"));
					DataSet maillp = mailsend.sendMail(input10);
					request.setAttribute("maillp",maillp);

					/*
					////SM에게 메일 보내기
					input10.put("v_mail_type", "03");
					input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
					input10.put("v_channel_code", "00000030");
					input10.put("v_member_id", cltnum);

					input10.put("v_to_email", selPayment.getText("sm_email"));

					mapping1 = "";
					String sm_name = "";
					////sm_name = selPayment.getText("sm_name");
					sm_name = Util.superTrim(ToolString.hanToFull(selPayment.getText("sm_name")));

					mapping1 = sm_name +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnum +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
					input10.put("v_mapping", mapping1);

					anyframe.log.Logger.debug.println("SM에게 메일 보내기 위한 필드  : "+input10);
					input10.put("v_lp_code", selPayment.getText("sm_code"));
					DataSet mailsm = mailsend.sendMail(input10);
					request.setAttribute("mailsm",mailsm);
					*/

					////고객에게 SMS보내기

					String owner_mobile  	= selPayment.getText("payor_phone");////핸드폰
					String lp_code       	= "";////LP사번
					String amt           	= Util.addComma(StringFormater.removeZero(selPayment.getText("apln_amt")));////금액
					String gubun1         	= selPayment.getText("pay_cd");////상환구분
					String sms_code = "";
					String srvc_gubunc = "";
					String owner = "";
					owner = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm")));

					srvc_gubunc = selPayment.getText("srvc_cd");
					if(srvc_gubunc.equals("1"))////약관대출신청
					{
						sms_code = "5";
					}
					else if(srvc_gubunc.equals("2"))////약관대출상환
					{
						sms_code = "9";
					}
					else if(srvc_gubunc.equals("3"))////자동대출납부상환
					{
						sms_code = "11";
					}
					else if(srvc_gubunc.equals("4"))////배당금
					{
						sms_code = "6";
					}
					else if(srvc_gubunc.equals("5"))////휴면보험금
					{
						sms_code = "25";
					}
					else if(srvc_gubunc.equals("6"))////보험료수납
					{
						sms_code = "8";
					}
					else if(srvc_gubunc.equals("7"))////배당금상계
					{
						sms_code = "7";
					}


////					/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////SMS발송

					String indate1 = "";
					indate1 = selPayment.getText("policy_apln_no").substring(0,8);

					smscu.put("v_sms_code",  		sms_code);////SMS 메시지 업무코드
					smscu.put("v_success_yn",  	"0");////0-성공,1-실패
					smscu.put("v_policy_no",  	selPayment.getText("policy_no"));
					smscu.put("v_name",  			owner);
					smscu.put("v_owner",  		owner);
					smscu.put("v_owner_mobile",  	owner_mobile);
					smscu.put("v_lp_code",  		lp_code);
					smscu.put("v_amt",  			amt);
					smscu.put("v_gubun",  		gubun1);

					smscu.put("tran_etc1",  		indate1);////입력날짜
					smscu.put("tran_etc2",  		selPayment.getText("policy_apln_no"));////실질 순번
					smscu.put("v_pr",  			"CU");
					
					
					
					
					
					
					DataSet sms_ins_cu = manager2.findClientSms(smscu);////CU만


					////처리 성공 메세지
					message = "정상적으로 승인되었습니다.";
					msg = message;
							url = urlname;
							request.setAttribute("message", msg);
							request.setAttribute("toURL", url);
							return mapping.findForward("alert");
				}
				else
				{
					////KSPS2000 실행(실패 :80)
					input.put("gubun", "W" );
					input.put("lvlnum", "70");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);
					DataSet ksps2000_801 = manager.findKsps2000(input);
					
					
					
					
					
					
					////sp 로그를 위한 로직... 시작
					try
					{
				
						/*업무구분코드*/
																	   /*
																		* 약대지급		1
																		* 배당금지급		4
																		* 휴면보험금지급	5
																		* 배당금상계		7
																		* 보험료수납		6
																		* 추가보험료수납	8
																		* 약대상환		2
																		* APL상환		3 
																		* 특약부가 1		A
																		* 특약부가 2 	B
																		* 특약부가 3		C 
																		* 비밀번호 변경     I          
																		*/
											 					
																
						DataSet spinputp  = new DataSet();
				
						spinputp.put("srvc_cd","1"); ////처리업무코드
						spinputp.put("sp_nm","KSPS2000"); ////sp명
						spinputp.put("tran_no",emp_no); ////처리요청자 번호				
						spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
						spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						spinputp.put("sp_out_put",ksps2000_801.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
					}
			
					////sp 로그를 위한 로직... 끝
					
					
					
					
					
					
					
					message = ksps2000_801.getText("err_msg");

					////WEB DB저장(실패 70)
					message = "실패하였습니다. 관리자에게 문의하세요.";
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

					////처리 성공 메세지
					message = "실패하였습니다. 관리자에게 문의하세요.";
					msg = message;
							url = urlname;
							request.setAttribute("message", message1);
							request.setAttribute("toURL", url);
							return mapping.findForward("alert");

				}
			}
		}
		/**************************************
		 * 저장시 ksps2000 검색 - E
		 ***************************************/

		saveToken(request);
		return doExecute(mapping, form, request, response);
	}

	/**
	 * CybercenterAction클래스를 상속하는 클래스들이 구현해야할 메써드.
	 */
	protected abstract ActionForward doExecute(ActionMapping mapping, ActionForm form,	HttpServletRequest request,	HttpServletResponse response)throws Exception;
}

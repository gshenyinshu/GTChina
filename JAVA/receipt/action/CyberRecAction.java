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

////추가사항
import anyframe.data.DataSet;
import anyframe.log.*;
import gtone.changeminer.common.utility.*;

import java.util.*;////StringTokenizer에 사용
import anyframe.util.*;////StringFormater
import anyframe.*;

////ksps2000
import gtone.changeminer.receipt.manager.AuthManager;
import gtone.changeminer.receipt.manager.CyberRecManager;
import gtone.changeminer.receipt.manager.PremiumsearchManager;
import gtone.changeminer.payment.manager.ReturnManager;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.CybercenterManager;

////세션
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

////SMS보내기
import gtone.changeminer.payment.manager.CyberSmsManager;

////메일보내기
import gtone.changeminer.receipt.manager.PolicychangeManager;
import gtone.changeminer.common.utility.Variable;////prumail.xml에서 메일경로



public abstract class CyberRecAction extends Action 
{


	/**
	 * 로그인 되었는지의 여부를 판단하는 메써드.
	 * 로그인되지 않은 상태일 경우 로그인 페이지로 이동.
	 * 로그인된 상태일 경우 doExecute() 메써드 호출. 
	 */

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)throws Exception 
	{

		/**************************************
		 * 저장시 ksps2000 검색 - S
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
		DataSet ksps0340 = new DataSet();////예금주확인
		DataSet policyan = new DataSet();		
		
		DataSet input10 = new DataSet();
		DataSet input11 = new DataSet();
		DataSet smscu = new DataSet();
		DataSet realpay = new DataSet();
		
		CybercenterManager manager3 = CybercenterManager.getInstance();	
		CyberRecManager manager = CyberRecManager.getInstance();		
		ReturnManager returns = ReturnManager.getInstance();////반송
		PlpaymentManager Pmanager = PlpaymentManager.getInstance();////M0181SP1을 실행
		PolicychangeManager mailsend = PolicychangeManager.getInstance();////메일
		CyberSmsManager manager2 = CyberSmsManager.getInstance();
		
		String errrtn = "-1";
		String message = "";
		String bankerr = "-1";
		String proc_status = "";
		
		String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");////처리구분	
		String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");			
		String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");	
		
              ////세션사용하기
              SessionManager sessionManager = new SessionManager(request);
              String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
              String emp_no = sessionManager.getString(Constant.SESSION_USERID);
	       String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
		
		String proc_emp_no = emp_no;////처리자사번
		
		policyan.put("policy_apln_no", policy_apln_no);
		
		////KSPS2000에 저장할때 사용
		String deptcd  		= "INT";
		String init	   		= "     ";		
		String gubun    	= "";////처리구분(C,W)
		String reqnum  	= "   ";////요청건수
		String fromdt 		=    request.getParameter("indate")	== null ? "" : request.getParameter("indate");////조회기준일자			
		String policy	 	=    request.getParameter("policy")	== null ? "" : request.getParameter("policy");////증권번호		
		String procdt   		= "        ";////실제처리일자
		String proctm   	= "      ";////실제처리시간
		String inout 		= "IN";////수납(IN), 지급(OUT)
		String procgb  		= "L1";////약대지급
		String lvlnum  		= "";////처리상태
		String lvlbef   		= "  ";////처리전상태
		String mbkcd    	= "  ";////모계좌 은행코드
		String mbkact   	= "               ";////모계좌 계좌번호
		String cltbk    		=  request.getParameter("bnkcode")	== null ? "" : request.getParameter("bnkcode");////은행코드
		String cltact   		= request.getParameter("bnkacct")	== null ? "" : request.getParameter("bnkacct");////고객 계좌번호
		String cltnum   	= request.getParameter("bnkclt")	== null ? "" : request.getParameter("bnkclt");////고객 주민번호
		String procamt  	= request.getParameter("cash")	== null ? "" : request.getParameter("cash");////이체금액
			  procamt       = StringFormater.fillZero(StringFormater.replaceStr(procamt,",",""),13);
		String procno   	= "      ";////이체전문번호 
		String brltcd   		= "    ";////은행결과
		
		////alert창을 띄우고 다시 해당페이지로 되돌아갈 url
		String returnurl = request.getParameter("returnurl")	== null ? "" : request.getParameter("returnurl");	
		String urlname =  returnurl + "?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy;		
		anyframe.log.Logger.debug.println("리턴 url의 값===================>"+urlname);					

		////예금주확인 프로세스
		String musera = "INTUSER";
		String sbkcda = request.getParameter("sbkcda")	== null ? "" : request.getParameter("sbkcda");	
		String sbknoa = request.getParameter("sbknoa")	== null ? "" : request.getParameter("sbknoa");	
		String amount = request.getParameter("amount")	== null ? "" : request.getParameter("amount");	
		String pyrna = request.getParameter("pyrna")	== null ? "" : request.getParameter("pyrna");	
		
		////승인시 M0181SP1에 세팅할값들
		String opt1 =  request.getParameter("opt1")	== null ? "P2" : request.getParameter("opt1");	
		String regdate  = request.getParameter("regdate")	== null ? "" : request.getParameter("regdate");	
		String cash =  request.getParameter("cash")	== null ? "" : request.getParameter("cash");	
			  cash       = StringFormater.fillZero(StringFormater.replaceStr(cash,",",""),11);
			  
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
		String errmsg1  = "";
		String ksps0450err = "";
		
		////승인시 M0181SP1에 세팅
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
				
				
				
		////처리전 조회
		
		DataSet inputp1  = new DataSet();
		DataSet inputp2  = new DataSet();
		DataSet inputp3  = new DataSet();	


		anyframe.log.Logger.debug.println("처리 프로세스.... 코드 ==========="+process);	

		
		inputp1.put("policy", policy);					
		inputp2.put("policy_apln_no", policy_apln_no);
		inputp3.put("proc_emp_no", proc_emp_no);
		
		
		
		String seladvcnt =  request.getParameter("seladvcnt")	== null ? "0" : request.getParameter("seladvcnt");	
		
		
			if(process.equals("R")||process.equals("Y") ){
				anyframe.log.Logger.debug.println("=============== 처리전 조회 하기 ==================");	
			
				
				
				PremiumsearchManager manager1 = PremiumsearchManager.getInstance();

				DataSet premiumsearch 	= manager1.findPremiumsearch(inputp1);	
				DataSet payment   		= Pmanager.Inpayment(inputp2, inputp3);
								
				int realpay1 = premiumsearch.getInt("modp");
				int realpay2 = payment.getInt("apln_amt");				
								
								
								
								
				if(realpay1 != realpay2){
				
					 message = "[처리전조회]실입금액이 현보험료와 다릅니다.";
					msg = message;
					url = urlname;
					request.setAttribute("message", msg);
					request.setAttribute("toURL", url);
					return mapping.findForward("alert");	
					
				}	
	

	
						}	
			
							
				
		////승인요청부분-시작 or 실시간 저장할때
		if(process.equals("Y"))
		{			
			//// (0701875)2007년 10월 16일 안병훈 : 중복요청 막음. saveToken 이용
			//// 새로고침 했을경우나 더블클릭처럼 두번 요청 되었을경우 중복승인요청을 막는 부분.
			if (!isTokenValid(request)) {
				url = urlname;
				Logger.debug.println("saveToken 새로고침 했을경우나 더블클릭처럼 두번 요청 되었을경우 막힘.");
				request.setAttribute("message", "승인요청 진행중에 또 다른 승인요청이 중복신청 되었으므로 진행되지 않습니다.");
				request.setAttribute("toURL", url);
				return mapping.findForward("alert");
			}
			resetToken(request); //// 세션에 있는 토큰값을 초기화 한다. 중복요청시 위의 if문에 걸리게 하기 위함.

			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//// (0701875)이중지급 방지를 위해 기승인된 건이거나 처리중인 건 걸러냄
			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			DataSet inAppv = new DataSet();
			inAppv.put("policy_apln_no", 	policy_apln_no);

			DataSet outAppv1 = manager3.findAppvProcessStatus(inAppv);
			String appv_cnt 	= outAppv1.getText("appv_cnt");////상태코드 완료 22, 40, 80인 건이 0일 경우

			if(!appv_cnt.equals("0")){
				////처리 메세지
				msg = "기승인된 건 이거나 처리중입니다. 확인 후 처리해주세요.";
				url = urlname;
				request.setAttribute("message", msg);
				request.setAttribute("toURL", url);
				return mapping.findForward("alert");
			}
			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			//// (0701875)2007년 10월 16일 안병훈 : 승인요청 시작시 22코드를 넣는다.
			DataSet newSet = new DataSet();
			newSet.put("policy_apln_no", policy_apln_no);
			newSet.put("proc_emp_no", proc_emp_no);
			newSet.put("proc_status", "22");
			newSet.put("err_msg", message);
			DataSet rtnsaveNew = returns.findRtnsave(newSet);

			input11.put("policy_apln_no", policy_apln_no);
			DataSet selPayment = manager3.findRecei(input11);

			////KSPS0340(예금주확인 프로세스			
			ksps0340.put("musera", "INTUSER");
			ksps0340.put("sbkcda", sbkcda);
			ksps0340.put("sbknoa", sbknoa);
			ksps0340.put("amount", "00000000001");
			ksps0340.put("pyrna", pyrna);
			ksps0340.put("procgb", "I");
			
			DataSet bankconf = manager.confBank(ksps0340);
			request.setAttribute("bankconf", bankconf);
			
			String ksps0340_rtn = bankconf.getText("rtn");
			message = bankconf.getText("errmsg");

				input.put("gubun", "W" );
				input.put("lvlnum", "40");
				input.put("cltbk", cltbk);
				input.put("cltact", cltact);
				input.put("cltnum", cltnum);
				input.put("procamt", procamt);
			
				////KSPS2000실행(은행전문송신:40)	
				DataSet ksps2000_40 = manager.findKsps2000(input);	


			DataSet spinputp_  = new DataSet();
				
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
						
	
				spinputp_.put("srvc_cd","6"); ////처리업무코드
				spinputp_.put("sp_nm","KSPS2000"); ////sp명
				spinputp_.put("tran_no",emp_no); ////처리요청자 번호				
				spinputp_.put("tran_nm",emp_nm); ////처리요청자 네임
				spinputp_.put("sp_in_put",input.toString()); ////sp_in_put
				spinputp_.put("sp_out_put",ksps2000_40.toString()); ////sp_out_put
	
			  returns.findSpLogsave(spinputp_);
	
			}catch(Exception e)
			{
	
			  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
			}
	
			////sp 로그를 위한 로직... 끝
													
				errrtn = "";
				errrtn = ksps2000_40.getText("rtn");				
				
				////WEBDB 저장(은행전문송신:40)
				if(errrtn.equals("0"))
				{
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "40");
					input1.put("err_msg", message);						
					DataSet rtnsave2 = returns.findRtnsave(input1);					
				}
				
				////유효일자를 가져옴(현재일이 월처음영업일전인지 후인지... 판단하여 일자를 가져옴)
				DataSet inputval = new DataSet();
				DataSet findValidDay = Pmanager.findValidDay(inputval);
													
				String validday = findValidDay.getText("validday"); //// 유효일자 
													
				anyframe.log.Logger.debug.println("유효일자 ====  :"+validday);	
							
				////M0181SP1에 들어갈 PARAMETER
				input3.put("deptcd", "INT");
				input3.put("init", tproc_emp_no);
				input3.put("opt1", opt1);
				input3.put("opt2", "U");
				input3.put("policy", policy);
				input3.put("regdate", indate);
				input3.put("paydate", validday);
				input3.put("cash", cash);
				input3.put("prmsusp", "00000000000");
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
				DataSet approval = Pmanager.getApproval(input3, input4, input5);////결재,policy_apln_no,proc_emp_no
				
				////			sp 로그를 위한 로직... 시작
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
				
				 spinputp.put("srvc_cd","6"); ////처리업무코드
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
				
				errmsg1 = Util.superTrim(approval.getText("errmsg1")) + Util.superTrim(approval.getText("errmsg2")) + Util.superTrim(approval.getText("errmsg3"));

			//// (0701875)2007.10.16 안병훈
			//// 에러 메세지중 AAAA가 포함된 문자가 있을경우 SMS 발송.
			anyframe.log.Logger.debug.println("리턴 코approval.getText(errmsg1)====>"+approval.getText("errmsg1"));
////			AAAA테스트
////			approval.put("errmsg1", "DGAAAA있읍니다.");
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
				else if(srvc_gubunc.equals("8"))////추가보험료수납
				{
					strGubun = "추가보험료수납";
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
	
					//// ex) 사이버 이중수납 확인요망 100500000 홍길동, 약관대출 (or해약, 휴면) 00000원 [지티원사이버]승인요청중 AAAA가 발견되었습니다.");" +
					String strMsg = "[지티원사이버]이중수납확인" + policy + payor_nm + " " + strGubun + Integer.parseInt(procamt) + "원 AAAA발견";
	
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
					//// ex) 사이버 이중수납 확인요망 100500000 홍길동, 약관대출 (or해약, 휴면) 00000원 [지티원사이버]승인요청중 AAAA가 발견되었습니다.");" +
					String strSubject = policy + " " + payor_nm + ", " + strGubun + " " + Integer.parseInt(procamt) + "원 [지티원사이버]승인요청중 AAAA가 발견되었습니다.";
					//// ex)
					////	사이버 이중수납 가능성 있으니 확인 바랍니다.
					////	증번 : 100500000
					////	계약자명 : 홍길동
					////	약관대출 (or 해약, 휴면) 00000원
					////	처리자 : OOO
					////	처리시간 OO:OO:OO
	
					String strContent = strSubject + "|" + "사이버 이중수납 가능성 있으니 확인 바랍니다. <br>"
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

				////M0181SP1을 돌고난 다음에 output으로 전송번호를 받음
				sending_num = approval.getText("sndseq");////전송번호
				input6.put("policy_apln_no", policy_apln_no);
				input6.put("sending_num", sending_num);
				input6.put("pay_dt", Util.getTodayToYMD().substring(0,8));
				////전송번호를 WB_PAYMENT에 Sending_num(전송번호)에 SAVE
				DataSet sending = manager.Sendingsave(input6);////전송번호 저장
				
				realpay.put("policy_apln_no", policy_apln_no);
				////realpay.put("pay_amt", approval.getText("netpay"));////실지급금
				realpay.put("pay_amt", cash);////실지급금
				
				errrtn = approval.getText("rtn");
								
				if(errrtn.equals("0"))////KSPS2000실행(은행,HOST:80 처리성공)
				{
					DataSet netpay = manager3.Realpaysave(realpay);////실지급금저장
					
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
	
					  spinputp.put("srvc_cd","6"); ////처리업무코드
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
					
					////WEB DB저장(은행-HOST처리성공 80)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "80");
					input1.put("err_msg", errmsg1);						
					DataSet rtnsave3 = returns.findRtnsave(input1);
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "0");
					input2.put("err_msg", errmsg1);
					DataSet rtnsave4 = returns.findRtnsave1(input2);
					
					
						////WB_PAYMENT에서 접수번호를 키값으로 해당 자료를 Search
						String cltnumt = "";
						cltnumt = cltnum.substring(0,6)+"-"+cltnum.substring(6);
						
						String payor_nm = Util.superTrim(selPayment.getText("payor_nm"));
						String v_to_mail = selPayment.getText("payor_email");
						String mapping1 = "";
						String apln_dt = selPayment.getText("apln_dt").substring(0,10);							
						apln_dt = apln_dt.substring(0,4) +" 년 " + apln_dt.substring(5,7) +" 월 "+ apln_dt.substring(8,10) +" 일";
						
						to_year = null;
						v_toyear = Util.getTodayToYMD();
						to_year = v_toyear.substring(0,8);
						String pay_dt  = "";
						pay_dt = to_year;
						if(pay_dt.length() == 8)
						{
							pay_dt = pay_dt.substring(0,4) + " 년 "+ pay_dt.substring(4,6) +" 월 "+ pay_dt.substring(6,8) +" 일";
						}							
						String apln_amt = "";
						////apln_amt = selPayment.getText("pay_amt");
						apln_amt = selPayment.getText("apln_amt");
						
						////apln_amt = approval.getText("netpay");////실지급금
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
										
						if(selPayment.getText("srvc_cd").equals("6"))
						{
							////LP에게 메일 보내기					
							input10.put("v_mail_type", "03");
							input10.put("v_mail_type_seq", Variable.get("email-id.cyber10"));////67
							input10.put("v_channel_code", "00000030");
							input10.put("v_member_id", cltnum);
							
							input10.put("v_to_email", selPayment.getText("lp_email"));
							
							mapping1 = "";
							String lpname = "";							
							lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname")));
							mapping1 = lpname +"|"+payor_nm+"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+ selPayment.getText("acct_nm") + "|"+selPayment.getText("payor_ssn") +"|" + selPayment.getText("lstpdat").substring(0,4) + "년 " + selPayment.getText("lstpdat").substring(4) + "월" ;
							input10.put("v_mapping", mapping1);
							
							anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 필드  : "+input10);
							input10.put("v_lp_code", selPayment.getText("lp_id"));		
							DataSet maillp = mailsend.sendMail(input10); 
							request.setAttribute("maillp",maillp);	
							
							/*
							////SM에게 메일 보내기					
							input10.put("v_mail_type", "03");
							input10.put("v_mail_type_seq", Variable.get("email-id.cyber10"));////67
							input10.put("v_channel_code", "00000030");
							input10.put("v_member_id", cltnum);
							
							input10.put("v_to_email", selPayment.getText("sm_email"));
							
							mapping1 = "";
							String sm_name = "";							
							sm_name = Util.superTrim(ToolString.hanToFull(selPayment.getText("sm_name")));
							mapping1 = sm_name +"|"+payor_nm+"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+ selPayment.getText("acct_nm") + "|"+selPayment.getText("payor_ssn") +"|" + selPayment.getText("lstpdat").substring(0,4) + "년 " + selPayment.getText("lstpdat").substring(4) + "월" ;
							input10.put("v_mapping", mapping1);
							
							anyframe.log.Logger.debug.println("SM에게 메일 보내기 위한 필드  : "+input10);
							input10.put("v_lp_code", selPayment.getText("sm_code"));		
							DataSet mailsm = mailsend.sendMail(input10); 
							request.setAttribute("mailsm",mailsm);								
							*/
						}
						else
						{								
							////LP에게 메일 보내기					
							input10.put("v_mail_type", "03");
							input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
							input10.put("v_channel_code", "00000030");
							input10.put("v_member_id", cltnum);
							
							input10.put("v_to_email", selPayment.getText("lp_email"));
							
							mapping1 = "";
							String lpname = "";							
							lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname")));
							mapping1 = lpname +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
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
							
							mapping1 = sm_name +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
							input10.put("v_mapping", mapping1);
							
							anyframe.log.Logger.debug.println("SM에게 메일 보내기 위한 필드  : "+input10);
							input10.put("v_lp_code", selPayment.getText("sm_code"));		
							DataSet mailsm = mailsend.sendMail(input10); 
							request.setAttribute("mailsm",mailsm);								
							*/
						}
						
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
					msg = errmsg1;
	            			url = urlname;
	            			request.setAttribute("message", msg);	
	            			request.setAttribute("toURL", url);	
	            			return mapping.findForward("alert");														
				}
				else if(errrtn.equals("3"))////KSPS2000실행-은행처리지연:50
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
	
					  spinputp.put("srvc_cd","6"); ////처리업무코드
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
					
					////WEB DB저장(은행-HOST처리 지연 50)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "50");
					input1.put("err_msg", errmsg1);						
					DataSet rtnsave5 = returns.findRtnsave(input1);
					
					////WB_PAYMENT에 3(지연) SAVE
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "3");
					input2.put("err_msg", errmsg1);
					DataSet rtnsave6 = returns.findRtnsave1(input2);
					
					////처리 성공 메세지
					message = "은행 처리 지연입니다. 일정시간후 다시 확인하세요.";
					msg = message;
	            			url = urlname;
	            			request.setAttribute("message", errmsg1);	
	            			request.setAttribute("toURL", url);	
	            			return mapping.findForward("alert");																										
				}
				else if(errrtn.equals("1") || errrtn.equals("2"))////FILE OPEN ERROR, DATA VALID CHECK오류, 은행처리 후 CAPSIL오류				
				{
					////KSPS2000실행 (기타오류 :99) 은행처리 전,후 에러발생 관리자 확인필요	
					input.put("gubun", "W" );
					input.put("lvlnum", "99");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);
					DataSet ksps2000_99 = manager.findKsps2000(input);	
					
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
	
					  spinputp.put("srvc_cd","6"); ////처리업무코드
					  spinputp.put("sp_nm","KSPS2000"); ////sp명
					  spinputp.put("tran_no",emp_no); ////처리요청자 번호				
					  spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
					  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
					  spinputp.put("sp_out_put",ksps2000_99.toString()); ////sp_out_put
	
					  returns.findSpLogsave(spinputp);
	
					}catch(Exception e)
					{
	
					  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
					}
	
					////sp 로그를 위한 로직... 끝
					
					////WB_PROCESS에 저장(기타 오류 -99)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "99");
					input1.put("err_msg", errmsg1);						
					DataSet rtnsave7 = returns.findRtnsave(input1);
					
					////WB_PROCESS에 저장(기타 오류 -99)
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "2");
					input2.put("err_msg", errmsg1);
					DataSet rtnsave8 = returns.findRtnsave1(input2);
					
					////처리 성공 메세지
					message = "은행처리 전,후 에러입니다. 관리자 확인 필요합니다.";
					msg = errmsg1;
	            			url = urlname;
	            			request.setAttribute("message", msg);	
	            			request.setAttribute("toURL", url);	
	            			return mapping.findForward("alert");																																		
				}
				else if(errrtn.equals("4"))////은행실패
				{
					
					////KSPS2000실행(은행처리결과 실패 & 재접수가능 61), WB_PAYMENT에서는 반송으로 처리
					input.put("gubun", "W" );
					input.put("lvlnum", "61");
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
	
					  spinputp.put("srvc_cd","6"); ////처리업무코드
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
					
					////WEB DB저장(은행처리결과 실패-61)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "61");
					input1.put("err_msg", errmsg1);						
					DataSet rtnsave9 = returns.findRtnsave(input1);
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "2");
					input2.put("err_msg", errmsg1);
					DataSet rtnsave10 = returns.findRtnsave1(input2);
					
					////처리 성공 메세지
					message = "해당요청의 은행처리 실패입니다. 잔고확인및 재실행하세요.";
					msg = errmsg1;
	            			url = urlname;
	            			request.setAttribute("message", msg);	
	            			request.setAttribute("toURL", url);	
	            			return mapping.findForward("alert");																																									
				}
				else if(errrtn.equals("5"))////HOST처리실패 (DISB, PPAY,MODP)
				{
					input.put("gubun", "W" );
					input.put("lvlnum", "70");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);
					DataSet ksps2000_70w = manager.findKsps2000(input);	
					
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
	
					  spinputp.put("srvc_cd","6"); ////처리업무코드
					  spinputp.put("sp_nm","KSPS2000"); ////sp명
					  spinputp.put("tran_no",emp_no); ////처리요청자 번호				
					  spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
					  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
					  spinputp.put("sp_out_put",ksps2000_70w.toString()); ////sp_out_put
	
					  returns.findSpLogsave(spinputp);
	
					}catch(Exception e)
					{
	
					  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
					}
	
					////sp 로그를 위한 로직... 끝
					
					////WEB DB저장(은행성공+HOST실패)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "70");
					input1.put("err_msg", errmsg1);						
					DataSet rtnsave11 = returns.findRtnsave(input1);
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "3");////지연으로 처리
					input2.put("err_msg", errmsg1);
					DataSet rtnsave12 = returns.findRtnsave1(input2);
					
					////처리 성공 메세지
					message = "HOST 처리 실패입니다. 관리자에게 문의하세요.";
					msg = errmsg1;
	            			url = urlname;
	            			request.setAttribute("message", msg);	
	            			request.setAttribute("toURL", url);	
	            			return mapping.findForward("alert");																																											
					
				}
			
		}////승인요청 or 실시간저장할때 끝	
		else if(process.equals("R"))////지연건인경우 자동 PGM처리와 접수일때 승인처리
		{
			DataSet wbprostatus = manager.findProcstatus(policyan);
			proc_status = "";
			proc_status = wbprostatus.getText("proc_status");
						
			////KSPS0450을 처리하기 위한 처리루틴			
			DataSet sendall = manager.findSend(policyan);	
			sendingnum = sendall.getText("sending_num");////전송번호
			date = sendall.getText("date");////전송일자
			
			input7.put("musera", "INTUSER");
			input7.put("snddate", date);
			input7.put("sndseq", sendingnum);
			DataSet ksps0450 = manager.findIsaogong(input7);////KSPS0450실행
						
			rtn0450 = ksps0450.getText("rtn");
			ksps0450err = ksps0450.getText("errmsg");////에러메세지
			
			if(rtn0450.equals("1") || rtn0450.equals("3"))
			{
				message = "프로그램실행중 에러및 지연건입니다. 관리자에게 문의하세요.";
				msg = ksps0450err;
	    			url = urlname;
	    			request.setAttribute("message", msg);	
	    			request.setAttribute("toURL", url);	
	    			return mapping.findForward("alert");
			}
			else if(rtn0450.equals("4"))////은행실패인 경우
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
	
				  spinputp.put("srvc_cd","6"); ////처리업무코드
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
				errrtn = ksps2000_61.getText("rtn");				
				if(errrtn.equals("0"))
				{
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "60");
					input1.put("err_msg", ksps0450err);						
					DataSet rtnsavek13 = returns.findRtnsave(input1);
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "2");
					input2.put("err_msg", ksps0450err);
					DataSet rtnsavek14 = returns.findRtnsave1(input2);	
					
					
					////KSPS0450D을 실행후 에러코드(4) 은행실패-고객에게 은행처리 실패 SMS전송, 은행잔고 확인등 요청				
					////고객에게 SMS보내기
					
					/*
					String cltnumt = "";
					cltnumt = cltnum.substring(0,6)+"-"+cltnum.substring(6);
					input11.put("policy_apln_no", policy_apln_no);
					
					DataSet selPayment = manager3.findRecei(input11);
					
					String payor_nm = selPayment.getText("payor_nm");
					String v_to_mail = selPayment.getText("payor_email");
					String mapping1 = "";
					String apln_dt = selPayment.getText("apln_dt").substring(0,10);							
					apln_dt = apln_dt.substring(0,4) +" 년 " + apln_dt.substring(5,7) +" 월 "+ apln_dt.substring(8,10) +" 일";
					
					to_year = null;
					v_toyear = Util.getTodayToYMD();
					to_year = v_toyear.substring(0,8);
					String pay_dt  = "";
					pay_dt = to_year;
					if(pay_dt.length() == 8)
					{
						pay_dt = pay_dt.substring(0,4) + " 년 "+ pay_dt.substring(4,6) +" 월 "+ pay_dt.substring(6,8) +" 일";
					}							
					String apln_amt = "";
					apln_amt = selPayment.getText("apln_amt");
					apln_amt = Util.addComma(apln_amt);
								
					String owner_mobile  	= selPayment.getText("payor_phone");////핸드폰
					String lp_code       	= "";////LP사번
					String amt           	= Util.addComma(StringFormater.removeZero(selPayment.getText("apln_amt")));////금액
					String gubun1         = selPayment.getText("pay_cd");////상환구분					
					String sms_code = "";
					String srvc_gubunc = "";
					String owner = "";
					owner = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm")));
					
					srvc_gubunc = selPayment.getText("srvc_cd");
					sms_code = "8";
					String indate1 = "";
					indate1 = selPayment.getText("policy_apln_no").substring(0,8);
					
					smscu.put("v_sms_code",  		sms_code);////SMS 메시지 업무코드
					smscu.put("v_success_yn",  	"1");////0-성공,1-실패
					smscu.put("v_policy_no",  	selPayment.getText("policy_no"));
					smscu.put("v_name",  			owner);
					smscu.put("v_owner",  		owner);
					smscu.put("v_owner_mobile",  	owner_mobile);
					smscu.put("v_lp_code",  		lp_code);
					smscu.put("v_amt",  			amt);
					smscu.put("v_gubun",  		gubun1);
					
					smscu.put("tran_etc1",  		indate1);////입력날짜
					smscu.put("tran_etc2",  		selPayment.getText("policy_apln_no"));////실질 순번
					smscu.put("v_pr",  			"AD");					
					DataSet sms_ins_cu = manager2.findClientSms(smscu);////CU만	
					*/
									
				}////WEB DB저장(은행처리결과 실패-61									
			}
			else if(rtn0450.equals("0"))////KSPS0450실행후 리턴값이 0인경우(은행정상처리)
			{
				
				////유효일자를 가져옴(현재일이 월처음영업일전인지 후인지... 판단하여 일자를 가져옴)
				DataSet inputval = new DataSet();
				DataSet findValidDay = Pmanager.findValidDay(inputval);
												
				String validday = findValidDay.getText("validday"); //// 유효일자 
												
				anyframe.log.Logger.debug.println("유효일자 ====  :"+validday);	
				
				input3.put("deptcd", "INT");
				input3.put("init", tproc_emp_no);
				input3.put("opt1", opt1);
				input3.put("opt2", "H");
				input3.put("policy", policy);
				input3.put("regdate", indate);
				input3.put("paydate", validday);
				input3.put("cash", cash);
				input3.put("prmsusp", "00000000000");
				input3.put("susp", "00000000000");
				input3.put("plpay", "00000000000");
				input3.put("tax", "00000000000");
				input3.put("sndseq", "      ");
				input3.put("bnkclt", bnkclt);
				input3.put("bnkcode", bnkcode);
				input3.put("bnkacct", bnkacct);						
				input3.put("agency", "   ");						
									
				input5.put("proc_emp_no", proc_emp_no);
				
				anyframe.log.Logger.debug.println("지연인경우 M0181SP1  input3==========="+input3);
				DataSet approval3 = Pmanager.getApproval(input3, policyan, input5);////결재,policy_apln_no,proc_emp_no
				
				
				////			sp 로그를 위한 로직... 시작
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
				
				 spinputp.put("srvc_cd","6"); ////처리업무코드
				 spinputp.put("sp_nm","M0181SP1"); ////sp명
				 spinputp.put("tran_no",emp_no); ////처리요청자 번호				
				 spinputp.put("tran_nm",emp_nm); ////처리요청자 네임
				 spinputp.put("sp_in_put",input3.toString()); ////sp_in_put
				 spinputp.put("sp_out_put",approval3.toString()); ////sp_out_put
				
				 returns.findSpLogsave(spinputp);
				
				}catch(Exception e)
				{
				
				 System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp로그를 넣다가 에러가 발생시에는 다른처리를 위해... 로그만 찍는다. 
				}
				
				////sp 로그를 위한 로직... 끝				
				
				
				////M0181SP1을 돌고난 다음에 output으로 전송번호를 받음
				sending_num = approval3.getText("sndseq");////전송번호
				input6.put("policy_apln_no", policy_apln_no);
				input6.put("sending_num", sending_num);
				input6.put("pay_dt", Util.getTodayToYMD().substring(0,8));
				DataSet sending = manager.Sendingsave(input6);////전송번호 저장
				
				realpay.put("policy_apln_no", policy_apln_no);
				realpay.put("pay_amt", approval3.getText("netpay"));////실지급금
				realpay.put("pay_amt", cash);////실지급금
				
				errrtn = approval3.getText("rtn");
				
				if(errrtn.equals("0"))////정상으로 처리된경우
				{
					
					DataSet netpay = manager3.Realpaysave(realpay);////실지급금저장
					
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
	
					  spinputp.put("srvc_cd","6"); ////처리업무코드
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
					
					////WEB DB저장(은행-HOST처리성공 80)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "80");
					input1.put("err_msg", ksps0450err);						
					DataSet rtnsavek15 = returns.findRtnsave(input1);
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "0");
					input2.put("err_msg", ksps0450err);
					DataSet rtnsavek16 = returns.findRtnsave1(input2);
					
					////WB_PAYMENT에서 접수번호를 키값으로 해당 자료를 Search
					String cltnumt = "";
					cltnumt = cltnum.substring(0,6)+"-"+cltnum.substring(6);
					input11.put("policy_apln_no", policy_apln_no);
					
					DataSet selPayment = manager3.findRecei(input11);
					
					String payor_nm = Util.superTrim(selPayment.getText("payor_nm"));
					String v_to_mail = selPayment.getText("payor_email");
					String mapping1 = "";
					String apln_dt = selPayment.getText("apln_dt").substring(0,10);							
					apln_dt = apln_dt.substring(0,4) +" 년 " + apln_dt.substring(5,7) +" 월 "+ apln_dt.substring(8,10) +" 일";
					
					to_year = null;
					v_toyear = Util.getTodayToYMD();
					to_year = v_toyear.substring(0,8);
					String pay_dt  = "";
					pay_dt = to_year;
					if(pay_dt.length() == 8)
					{
						pay_dt = pay_dt.substring(0,4) + " 년 "+ pay_dt.substring(4,6) +" 월 "+ pay_dt.substring(6,8) +" 일";
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
												
					if(selPayment.getText("srvc_cd").equals("6"))
					{
						apln_amt  = "";
						////apln_amt = Util.addComma(approval3.getText("netpay"));
						apln_amt = Util.addComma(apln_amt = selPayment.getText("apln_amt"));
						
						
						////LP에게 메일 보내기					
						input10.put("v_mail_type", "03");
						input10.put("v_mail_type_seq", Variable.get("email-id.cyber10"));////67
						input10.put("v_channel_code", "00000030");
						input10.put("v_member_id", cltnum);
						
						input10.put("v_to_email", selPayment.getText("lp_email"));
						
						mapping1 = "";
						String lpname = "";							
						lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname")));
						mapping1 = lpname +"|"+payor_nm+"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+ selPayment.getText("acct_nm") + "|"+selPayment.getText("payor_ssn") +"|" + selPayment.getText("lstpdat").substring(0,4) + "년 " + selPayment.getText("lstpdat").substring(4) + "월" ;
						input10.put("v_mapping", mapping1);
						
						anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 필드  : "+input10);
						input10.put("v_lp_code", selPayment.getText("lp_id"));		
						DataSet maillp = mailsend.sendMail(input10); 
						request.setAttribute("maillp",maillp);	
						/*
						////SM에게 메일 보내기					
						input10.put("v_mail_type", "03");
						input10.put("v_mail_type_seq", Variable.get("email-id.cyber10"));////67
						input10.put("v_channel_code", "00000030");
						input10.put("v_member_id", cltnum);
						
						input10.put("v_to_email", selPayment.getText("sm_email"));
						
						mapping1 = "";
						String sm_name = "";							
						sm_name = Util.superTrim(ToolString.hanToFull(selPayment.getText("sm_name")));
						mapping1 = sm_name +"|"+payor_nm+"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+ selPayment.getText("acct_nm") + "|"+selPayment.getText("payor_ssn") +"|" + selPayment.getText("lstpdat").substring(0,4) + "년 " + selPayment.getText("lstpdat").substring(4) + "일" ;
						input10.put("v_mapping", mapping1);
						
						anyframe.log.Logger.debug.println("SM에게 메일 보내기 위한 필드  : "+input10);
						input10.put("v_lp_code", selPayment.getText("sm_code"));		
						DataSet mailsm = mailsend.sendMail(input10); 
						request.setAttribute("mailsm",mailsm);								
						*/
					}
					else
					{				
						////LP에게 메일 보내기
						input10.put("v_mail_type", "03");
						input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
						input10.put("v_channel_code", "00000030");
						input10.put("v_member_id", cltnum);
						
						input10.put("v_to_email", selPayment.getText("lp_email"));
						
						mapping1 = "";
						String lpname = "";							
						lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname")));
						mapping1 = lpname +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
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
						
						mapping1 = sm_name +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
						input10.put("v_mapping", mapping1);
						
						anyframe.log.Logger.debug.println("SM에게 메일 보내기 위한 필드  : "+input10);
						input10.put("v_lp_code", selPayment.getText("sm_code"));		
						DataSet mailsm = mailsend.sendMail(input10); 
						request.setAttribute("mailsm",mailsm);								
						*/
					}
					
					////고객에게 SMS보내기
								
					String owner_mobile  	= selPayment.getText("payor_phone");////핸드폰
					String lp_code       	= "";////LP사번
					String amt           	= Util.addComma(StringFormater.removeZero(selPayment.getText("apln_amt")));////금액
					String gubun1        = selPayment.getText("pay_cd");////상환구분					
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
					msg = ksps0450err;
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
	
					  spinputp.put("srvc_cd","6"); ////처리업무코드
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
					
					////WEB DB저장(실패 70)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "70");
					input1.put("err_msg", ksps0450err);						
					DataSet rtnsavek17 = returns.findRtnsave(input1);
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "2");
					input2.put("err_msg", ksps0450err);
					DataSet rtnsavek18 = returns.findRtnsave1(input2);
					
					////처리 성공 메세지
					message = "실패하였습니다. 관리자에게 문의하세요.";
					msg = ksps0450err;
        			url = urlname;
        			request.setAttribute("message", msg);	
        			request.setAttribute("toURL", url);	
        			return mapping.findForward("alert");																				
				}////M0181SP1을 수행후 리턴코드가 1,2,5인경우					
				}////KSPS0450이 0인경우
			
		}////지연건인경우 자동 PGM처리와 접수일때 승인처리
		
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

package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class PolicychangeDao
{

   ////wb_master에서 접수건가져오기
   public DataSet findPolicychangeList(DataSet input) throws Exception
    {
        try
        {	  
            Executor executor = null;
            executor = Executor.getInstance();
	     anyframe.log.Logger.debug.println("PolicychangeDao (wb_master에서 접수건가져오기)----  input  : "+input );			
            DataSet output = executor.execute("/changeminer/policy_change_list", input);
	     anyframe.log.Logger.debug.println("PolicychangeDao (wb_master에서 접수건가져오기)----  output  : "+output );			            
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }



   ////wb_DB에서 값 가져오기
   public DataSet findPolicychange_wb(DataSet input, DataSet input1) throws Exception
    {
        try
        {	  
            Executor executor = null;
            executor = Executor.getInstance();
            
            String gubun_cd = input1.getText("gubun");
            String xml_name = "";
            
            if( gubun_cd.equals("A") )
			{
				xml_name = "/changeminer/policy_change_list_member";
			}
			else if( gubun_cd.equals("BCD") )
			{
				xml_name = "/changeminer/policy_change_list_account";
			}
			else if( gubun_cd.equals("EF") )
			{
				xml_name = "/changeminer/policy_change_list_repayment";
			}
			else if( gubun_cd.equals("GHIJ") )
			{
				xml_name = "/changeminer/policy_change_list_method";
			}

			anyframe.log.Logger.debug.println("PolicychangeDao (wb_DB에서 값 가져오기)----  input  : "+input );			
			DataSet output = executor.execute(xml_name, input);
			anyframe.log.Logger.debug.println("PolicychangeDao (wb_DB에서 값 가져오기)----  output  : "+output );			            			
			return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
    


   ////Host - insert
   public DataSet findPolicychange_host_insert(DataSet input, DataSet input1) throws Exception
    {
        try
        {	  
            Executor executor = null;
            executor = Executor.getInstance();
            
            String gubun_cd = input1.getText("gubun");
            String xml_name = "";

            if( gubun_cd.equals("A") )
			{
				xml_name = "/changeminer/ksps0930";
			}
			else if( gubun_cd.equals("B") )
			{
				xml_name = "/changeminer/ksps0870";
			}
			else if( gubun_cd.equals("E") || gubun_cd.equals("F") )
			{
				xml_name = "/changeminer/ksps1180";
 			}
			else if( gubun_cd.equals("C") || gubun_cd.equals("G") || gubun_cd.equals("I") || gubun_cd.equals("J") )
			{
				xml_name = "/changeminer/m0141sp1";
			}
			else if( gubun_cd.equals("D1") )////그룹빌링
			{
				xml_name = "/changeminer/ksps1820";
			}
			else if( gubun_cd.equals("D2") )////그룹빌링
			{
				xml_name = "/changeminer/m0141sp1";
			}
			
			anyframe.log.Logger.debug.println("PolicychangeDao (Host - insert-DAO)----  xml_name  : "+xml_name );			
			
			anyframe.log.Logger.debug.println("PolicychangeDao (Host - insert-DAO)----  input  : "+input );			
			DataSet output = executor.execute(xml_name, input);
			anyframe.log.Logger.debug.println("PolicychangeDao (Host - insert-DAO)----  output  : "+output );			
			return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }

   ////이체일변경전 기신청여부
   public DataSet findExistpolicy(DataSet input) throws Exception
    {
        try
        {	  
            Executor executor = null;
            executor = Executor.getInstance();
	     anyframe.log.Logger.debug.println("이체일변경전 기신청여부-DAO)----  input  : "+input );			            
	     System.out.println("이체일변경전 기신청여부-DAO)----  input  : "+input );			            
	     DataSet output = executor.execute("/changeminer/ksps2200", input);
	     System.out.println("이체일변경전 기신청여부-DAO)----  output  : "+output );						
	     return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
    

   ////wb_DB - update
   public DataSet findPolicychange_wb_update(DataSet input) throws Exception
    {
        try
        {	  
            Executor executor = null;
            executor = Executor.getInstance();
	     anyframe.log.Logger.debug.println("PolicychangeDao (wb_DB - update-DAO)----  input  : "+input );			            
	     DataSet output = executor.execute("/changeminer/policy_change_update_master", input);
	     anyframe.log.Logger.debug.println("PolicychangeDao (wb_DB - update-DAO)----  output  : "+output );						
	     return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }

   ////메일을 보내기 위한 처리값들
   public DataSet findMail_sendmsg(DataSet input) throws Exception
    {
        try
        {	
		DataSet input1 = new DataSet();	  
		DataSet input2 = new DataSet();	  
		DataSet input3 = new DataSet();	  
		DataSet input4 = new DataSet();	
		DataSet input5 = new DataSet();	
		
		Executor executor = null;
		executor = Executor.getInstance();
		anyframe.log.Logger.debug.println("메일에 세팅하기위한 값들 조회 input-DAO  : "+input );			            
		DataSet output = executor.execute("/changeminer/mailsending", input);
		anyframe.log.Logger.debug.println("메일에 세팅하기위한 값들 조회 output-DAO  : "+output );
		
		int cnt = output.getCount("policy");
		if(cnt > 0)
		{
			 for(int i=0;i<cnt;i++) 
	     		{
	     			String policy = output.getText("policy",i);
	     			input1.put("policy", policy);
	     			InteractionBean interact1 = new InteractionBean();
					DataSet output1 = interact1.execute("/changeminer/ksps0300", input1);		
					output.put("slpcd", output1.getText("slpcd"), i);	
					
					input3.put("deptcd", "INT");
					input3.put("init", "     ");
					input3.put("plyno", policy);
					InteractionBean interact4 = new InteractionBean();
					DataSet output4 = interact4.execute("/changeminer/coveragenormal", input3);			     					
					
					output.put("plan_nm", output4.getText("plnname"), i);	
					
					input2.put("lpcode", output1.getText("slpcd"));
					InteractionBean interact2 = new InteractionBean();
					DataSet output2 = interact2.execute("/changeminer/lp_search", input2);			     					
					output.put("lpname", output2.getText("lpname"), i);	
					output.put("lpemail", output2.getText("lpemail"),i);				
	
					
					InteractionBean interact3 = new InteractionBean();
					DataSet output3 = interact3.execute("/changeminer/bmailsending", input);		
					output.put("bmode", output3.getText("bmode"), i);	
					
					input4.put("deptcd",    "INT");
					input4.put("init",      	"CYBER");
					input4.put("cltno",     	output.getText("ssn"));
					input4.put("schk",	"");
					input4.put("hchk",	"");  
					input4.put("htchk",	""); 
					input4.put("ochk",	"");  
					input4.put("otchk",	""); 
					input4.put("mtchk",	"");
					input4.put("emchk",	"");
					input4.put("send", 	"");			
					input4.put("hpost", 	"");
					input4.put("hadd1", 	"");
					input4.put("hadd2", 	"");
					input4.put("htela", 	"");
					input4.put("htel1", 	"");
					input4.put("htel2", 	"");
					input4.put("opost", 	"");
					input4.put("oadd1", 	"");
					input4.put("oadd2", 	"");
					input4.put("oadd3", 	"");
					input4.put("oadd4", 	"");
					input4.put("otela", 	"");
					input4.put("otel1", 	"");
					input4.put("otel2", 	"");
					input4.put("mtela", 	"");
					input4.put("mtel1", 	"");
					input4.put("mtel2", 	"");
					input4.put("email", 	"");
					input4.put("emschk", "");
					input4.put("emserv", 	"");
					input4.put("option",	"I");
					input4.put("sexchk",	"");
					input4.put("sex",		"");
					input4.put("namechk", "");
					input4.put("name",	"");
					
					InteractionBean interact5 = new InteractionBean();
					DataSet output5 = interact5.execute("/changeminer/ksps0930", input4);		
					output.put("email", output5.getText("email"), i);	
					output.put("mtela", output5.getText("mtela"), i);	
					output.put("mtel1", output5.getText("mtel1"), i);	
					output.put("mtel2", output5.getText("mtel2"), i);	
					
					input5.put("lpcode", output.getText("slpcd"));
					InteractionBean interact6 = new InteractionBean();
					DataSet output6 = interact6.execute("/changeminer/lpsm_info_search", input5);		
					output.put("sm_code", output6.getText("sm_code"), i);	
					output.put("sm_name", output6.getText("sm_name"), i);	
					output.put("sm_email", output6.getText("sm_email"), i);	
	     		}
		}
		anyframe.log.Logger.debug.println("총 last 메일에 세팅하기위한 값들 조회 output-DAO  : "+output );				
		return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }  
 
    ////메일을 보내기 위한 처리값들(자동이체신청,변경/해지/그룹빌링)
   public DataSet findMail_sendaccount(DataSet input) throws Exception
    {
        try
        {	
		DataSet input1 = new DataSet();	  
		DataSet input2 = new DataSet();	  
		DataSet input3 = new DataSet();	  
		DataSet input4 = new DataSet();	
		DataSet input5 = new DataSet();	
		
		Executor executor = null;
		executor = Executor.getInstance();
		anyframe.log.Logger.debug.println("ACCOUNT 메일에 세팅하기위한 값들 조회 input-DAO  : "+input );			            
		DataSet output = executor.execute("/changeminer/mailsendaccount", input);
		anyframe.log.Logger.debug.println("ACCOUNT 메일에 세팅하기위한 값들 조회 output-DAO  : "+output );
		
		int cnt = output.getCount("policy");
		if(cnt > 0)
		{
			 for(int i=0;i<cnt;i++) 
	     		{
	     			String policy = output.getText("policy",i);
	     			input1.put("policy", policy);
	     			InteractionBean interact1 = new InteractionBean();
					DataSet output1 = interact1.execute("/changeminer/ksps0300", input1);		
					output.put("slpcd", output1.getText("slpcd"), i);	
					
					input3.put("deptcd", "INT");
					input3.put("init", "     ");
					input3.put("plyno", policy);
					InteractionBean interact4 = new InteractionBean();
					DataSet output4 = interact4.execute("/changeminer/coveragenormal", input3);			     					
					
					output.put("plan_nm", output4.getText("plnname"), i);	
					output.put("modprem", output4.getText("modprem"),i);
					
					input2.put("lpcode", output1.getText("slpcd"));
					InteractionBean interact2 = new InteractionBean();
					DataSet output2 = interact2.execute("/changeminer/lp_search", input2);			     					
					output.put("lpname", output2.getText("lpname"), i);	
					output.put("lpemail", output2.getText("lpemail"),i);				
	
					
					InteractionBean interact3 = new InteractionBean();
					DataSet output3 = interact3.execute("/changeminer/bmailsending", input);		
					output.put("bmode", output3.getText("bmode"), i);	


					InteractionBean interact7 = new InteractionBean();
					DataSet output7 = interact7.execute("/changeminer/baccountmail", input);		
					output.put("bbank_name", output7.getText("bbank_name"), i);	
					output.put("baccount_code", output7.getText("baccount_code"), i);	
					output.put("bfb_day", output7.getText("bfb_day"), i);	

					
					input4.put("deptcd",    "INT");
					input4.put("init",      	"CYBER");
					input4.put("cltno",     	output.getText("ssn"));
					input4.put("schk",	"");
					input4.put("hchk",	"");  
					input4.put("htchk",	""); 
					input4.put("ochk",	"");  
					input4.put("otchk",	""); 
					input4.put("mtchk",	"");
					input4.put("emchk",	"");
					input4.put("send", 	"");			
					input4.put("hpost", 	"");
					input4.put("hadd1", 	"");
					input4.put("hadd2", 	"");
					input4.put("htela", 	"");
					input4.put("htel1", 	"");
					input4.put("htel2", 	"");
					input4.put("opost", 	"");
					input4.put("oadd1", 	"");
					input4.put("oadd2", 	"");
					input4.put("oadd3", 	"");
					input4.put("oadd4", 	"");
					input4.put("otela", 	"");
					input4.put("otel1", 	"");
					input4.put("otel2", 	"");
					input4.put("mtela", 	"");
					input4.put("mtel1", 	"");
					input4.put("mtel2", 	"");
					input4.put("email", 	"");
					input4.put("emschk", "");
					input4.put("emserv", 	"");
					input4.put("option",	"I");
					input4.put("sexchk",	"");
					input4.put("sex",		"");
					input4.put("namechk", "");
					input4.put("name",	"");
					
					InteractionBean interact5 = new InteractionBean();
					DataSet output5 = interact5.execute("/changeminer/ksps0930", input4);		
					output.put("email", output5.getText("email"), i);	
					output.put("mtela", output5.getText("mtela"), i);	
					output.put("mtel1", output5.getText("mtel1"), i);	
					output.put("mtel2", output5.getText("mtel2"), i);	
					
					input5.put("lpcode", output.getText("slpcd"));
					InteractionBean interact6 = new InteractionBean();
					DataSet output6 = interact6.execute("/changeminer/lpsm_info_search", input5);		
					output.put("sm_code", output6.getText("sm_code"), i);	
					output.put("sm_name", output6.getText("sm_name"), i);	
					output.put("sm_email", output6.getText("sm_email"), i);	
	     		}
		}
		anyframe.log.Logger.debug.println("총 last 메일에 세팅하기위한 값들 조회 account output-DAO  : "+output );				
		return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }   
  
 ////메일을 보내기 위한 처리값들(상환)
   public DataSet findMail_repayment(DataSet input) throws Exception
    {
        try
        {	
		DataSet input1 = new DataSet();	  
		DataSet input2 = new DataSet();	  
		DataSet input3 = new DataSet();	  
		DataSet input4 = new DataSet();	
		DataSet input5 = new DataSet();	
		
		Executor executor = null;
		executor = Executor.getInstance();
		anyframe.log.Logger.debug.println("메일에 세팅하기위한 값들 조회상환 input-DAO  : "+input );			            
		DataSet output = executor.execute("/changeminer/mail_repayment", input);
		anyframe.log.Logger.debug.println("메일에 세팅하기위한 값들 조회상환 output-DAO  : "+output );
		
		int cnt = output.getCount("policy");
		if(cnt > 0)
		{
			 for(int i=0;i<cnt;i++) 
	     		{
	     			String policy = output.getText("policy",i);
	     			input1.put("policy", policy);
	     			InteractionBean interact1 = new InteractionBean();
					DataSet output1 = interact1.execute("/changeminer/ksps0300", input1);		
					output.put("slpcd", output1.getText("slpcd"), i);	
					
					input3.put("deptcd", "INT");
					input3.put("init", "     ");
					input3.put("plyno", policy);
					InteractionBean interact4 = new InteractionBean();
					DataSet output4 = interact4.execute("/changeminer/coveragenormal", input3);			     					
					
					output.put("plan_nm", output4.getText("plnname"), i);	
					
					input2.put("lpcode", output1.getText("slpcd"));
					InteractionBean interact2 = new InteractionBean();
					DataSet output2 = interact2.execute("/changeminer/lp_search", input2);			     					
					output.put("lpname", output2.getText("lpname"), i);	
					output.put("lpemail", output2.getText("lpemail"),i);				
	
					
					InteractionBean interact3 = new InteractionBean();
					DataSet output3 = interact3.execute("/changeminer/bmailsending", input);		
					output.put("bmode", output3.getText("bmode"), i);	
					
					input4.put("deptcd",    "INT");
					input4.put("init",      	"CYBER");
					input4.put("cltno",     	output.getText("ssn"));
					input4.put("schk",	"");
					input4.put("hchk",	"");  
					input4.put("htchk",	""); 
					input4.put("ochk",	"");  
					input4.put("otchk",	""); 
					input4.put("mtchk",	"");
					input4.put("emchk",	"");
					input4.put("send", 	"");			
					input4.put("hpost", 	"");
					input4.put("hadd1", 	"");
					input4.put("hadd2", 	"");
					input4.put("htela", 	"");
					input4.put("htel1", 	"");
					input4.put("htel2", 	"");
					input4.put("opost", 	"");
					input4.put("oadd1", 	"");
					input4.put("oadd2", 	"");
					input4.put("oadd3", 	"");
					input4.put("oadd4", 	"");
					input4.put("otela", 	"");
					input4.put("otel1", 	"");
					input4.put("otel2", 	"");
					input4.put("mtela", 	"");
					input4.put("mtel1", 	"");
					input4.put("mtel2", 	"");
					input4.put("email", 	"");
					input4.put("emschk", "");
					input4.put("emserv", 	"");
					input4.put("option",	"I");
					input4.put("sexchk",	"");
					input4.put("sex",		"");
					input4.put("namechk", "");
					input4.put("name",	"");
					
					InteractionBean interact5 = new InteractionBean();
					DataSet output5 = interact5.execute("/changeminer/ksps0930", input4);		
					output.put("email", output5.getText("email"), i);	
					output.put("mtela", output5.getText("mtela"), i);	
					output.put("mtel1", output5.getText("mtel1"), i);	
					output.put("mtel2", output5.getText("mtel2"), i);	
					
					input5.put("lpcode", output.getText("slpcd"));
					InteractionBean interact6 = new InteractionBean();
					DataSet output6 = interact6.execute("/changeminer/lpsm_info_search", input5);		
					output.put("sm_code", output6.getText("sm_code"), i);	
					output.put("sm_name", output6.getText("sm_name"), i);	
					output.put("sm_email", output6.getText("sm_email"), i);	
	     		}
		}
		anyframe.log.Logger.debug.println("총 last 메일에 세팅하기위한 값들 조회 output-DAO  : "+output );				
		return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }    
  
  
  
   ////고객정보변경실제 메일을 보내는 SP
   public DataSet findMail_custmsg(DataSet input) throws Exception
    {
        try
        {	  
            Executor executor = null;
            executor = Executor.getInstance();
	     	anyframe.log.Logger.debug.println("고객정보변경메일 보내기  input  : "+input );			            
	     	DataSet output = executor.execute("/changeminer/sender_custer", input);
	     	anyframe.log.Logger.debug.println("고객정보변경메일 보내기  output  : "+output );						
	     	return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }    
      
   ////실제 메일을 보내는 SP
   public DataSet sendMail(DataSet input) throws Exception
    {
        try
        {	  
            Executor executor = null;
            executor = Executor.getInstance();
	     anyframe.log.Logger.debug.println("메일 보내기  input  : "+input );			            
	     
			DataSet output = null;
			String policyno = input.getText("v_policy_number");
			if( policyno != null && policyno.length() > 3 ){
				if( !"601".equals( policyno.substring(0,3) )) {
					output = executor.execute("/changeminer/usp_email_ins", input);
				}
			}else{
				anyframe.log.Logger.debug.println("방카상품은 메일발송을 안합니다.");
			}

	     anyframe.log.Logger.debug.println("메일 보내기  output  : "+output );						
	     return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    } 
      
	//// 메일을 보내는 SP
	public DataSet sendSimpleMail(DataSet input) throws Exception
	 {
		 try
		 {	  
			 Executor executor = null;
			 executor = Executor.getInstance();
		  anyframe.log.Logger.debug.println("메일 보내기  input  : "+input );			            
		  DataSet output = executor.execute("/changeminer/mail_simple_send", input);
		  anyframe.log.Logger.debug.println("메일 보내기  output  : "+output );						
		  return output;
		 }
		 catch(Exception e)
		 {
			 throw e;
		 }
	 } 

   ////wb_master에 상태코드 업데이트
   public DataSet uptMaster(DataSet input) throws Exception
    {
        try
        {	  
            Executor executor = null;
            executor = Executor.getInstance();
	     anyframe.log.Logger.debug.println("uptMaster 업데이트  input  : "+input );			            
	     DataSet output = executor.execute("/changeminer/master_upt", input);
	     anyframe.log.Logger.debug.println("uptMaster 업데이트   output  : "+output );						
	     return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }       
        
   ////wb_detail에 상태코드 업데이트
   public DataSet uptDetail(DataSet input) throws Exception
    {
        try
        {	  
            Executor executor = null;
            executor = Executor.getInstance();
	     anyframe.log.Logger.debug.println("uptDetail 업데이트  input  : "+input );			            
	     DataSet output = executor.execute("/changeminer/detail_upt", input);
	     anyframe.log.Logger.debug.println("uptDetail 업데이트   output  : "+output );						
	     return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }     
    
           
                  
}


/**
 * Title       : 
 * Description :  Sample action
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author 
 * @version 1.0
 */ 
package gtone.changeminer.event.action;

import org.apache.struts.actions.DispatchAction;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gtone.changeminer.common.utility.RequestToDataset;

/** 로그인 체크시 **/
import anyframe.Config;
import anyframe.Configuration;
/*******************/

import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

import anyframe.data.DataSet;
import anyframe.log.Logger;

import java.util.Hashtable;
	
/** 암호화 이용시
import com.initech.iniplugin.IniPlugin;
import com.initech.iniplugin.vid.IDVerifier;
import com.initech.iniplugin.vid.IDVerifierException;
import com.initech.ocspcd.OCSPCD;
import com.initech.ocspcd.OCSPCDException;
import com.initech.ocspcd.OCSPCDcode;

import java.security.cert.X509Certificate;
**/

import gtone.changeminer.event.dao.EventPrizeDao;

public  class EventPrizeAction extends DispatchAction
{

	public ActionForward list(
		ActionMapping mapping, 
		ActionForm form, 
		HttpServletRequest request,
		HttpServletResponse response)
		throws Exception
	{
		Logger.debug.println("EventPrizeAction list Start.");
                EventPrizeDao dao;
                DataSet input = null;
                DataSet output = null;

                dao = new EventPrizeDao();
                input = new DataSet();
                RequestToDataset.copyProperties(input, request);
		
		return mapping.findForward("list");
	}

	public ActionForward select(
		ActionMapping mapping, 
		ActionForm form, 
		HttpServletRequest request,
		HttpServletResponse response)
		throws Exception
	{
                EventPrizeDao dao;
                DataSet input = null;
                DataSet output = null;

                dao = new EventPrizeDao();
                input = new DataSet();
                RequestToDataset.copyProperties(input, request);
		
		output = dao.selectPrize(input);

		String msg = "";
		String url = "";
		msg = output.getText("rsltmsg");
		url = "/common/event/event_prize.do?run=list";
		request.setAttribute("message", output.getText("rsltmsg"));
		request.setAttribute("toURL", url);
		return mapping.findForward("alert");
	}
}

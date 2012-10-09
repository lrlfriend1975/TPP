<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/WEB-INF/struts-html-el.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<html>
<head>
<title>main</title>
<link href="../_css/reset.css" rel="stylesheet" type="text/css" />
		<link href="../_css/global.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" language="javascript"
			src="../_js/jquery-1.3.1.min.js"></script>
		<script src="../_js/common.js" type="text/javascript"></script>
<script src="../_js/calendar/WdatePicker.js" type="text/javascript"></script>
<script>
function smb()
{
	var minq=document.forms[0].minAmount.value;
	var maxq=document.forms[0].maxAmount.value;
	var begin=document.getElementById("beginDate").value;
	var end=document.getElementById("endDate").value;
	if(begin!="" && end!="" && begin > end){
		alert("终止时间不能比起始时间小！");
		return false;
	}else if(minq!=""&&!(/^([0-9]\d+|[0-9])(\.\d\d?)*$/.test(minq))){
		     alert("最小金额输入错误");
		     return false;
	}else if(maxq!="" &&!(/^([0-9]\d+|[0-9])(\.\d\d?)*$/.test(maxq))){
			alert("最大金额输入错误");
			return false;
	}else if( minq!="" && maxq!="" && parseFloat(minq*100) > parseFloat(maxq*100)){
			alert("最小金额不能大于最大金额");
			return false;
	} 
	if(minq==""){
	 document.forms[0].minAmount.value=0; 
	 }
	if(maxq==""){
	 document.forms[0].maxAmount.value=1000000;
	 }
	 		document.forms[0].thisAction.value="listChargeLog";
			document.forms[0].submit();
}


</script>
</head>
<body>
<div id="mainContainer">
<div id="container"><html:form action="/transaction/chargeLoglist.do" >
	<html:hidden property="thisAction" />
	<html:hidden property="lastAction" />
	<html:hidden property="intPage" />
	<html:hidden property="pageCount" />
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="10" height="10" class="tblt"></td>
			<td height="10" class="tbtt"></td>
			<td width="10" height="10" class="tbrt"></td>
		</tr>
		<tr>
			<td width="10" class="tbll"></td>
			<td valign="top" class="body">
<c:import url="../_jsp/mainTitle.jsp?title1=充值管理&title2=充值日志" charEncoding="UTF-8" />
			<div class="searchBar">
			<p>搜索栏</p>
			<hr />

			<table cellpadding="0" cellspacing="0" border="0" class="searchPanel">
				<tr>
					
					<td>商户： <html:text property="agentName" styleClass="colorblue2 p_5" style="width:150px;"/></td>
					<td>起始时间：<html:text styleId="beginDate"  property="beginDate" styleClass="colorblue2 p_5"  style="width:150px;"
													onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" readonly="true" />  </td>
					<td>终止时间：<html:text styleId="endDate" property="endDate" styleClass="colorblue2 p_5" style="width:150px;"
													onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" readonly="true" />  </td>
					<td>
						充值金额：
						<html:text property="minAmount" styleClass="colorblue2 p_5" style="width:80px;"></html:text>
						--
						<html:text property="maxAmount" styleClass="colorblue2 p_5" style="width:80px;"></html:text>
					</td>
					<td><input type="button" name="button" id="button" value="查询"
						class="submit greenBtn"  onclick="smb()"/></td>
				</tr>
			</table>
			</div>
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataList" style="word-break :break-all">
				<tr>
					<th  width="2%">
					<div>&nbsp;</div>
					</th>
					<th  width="12%">
					<div>日志时间</div>
					</th>
					<th  width="6%">
					<div>商户名</div>
					</th>
					<th width="70%">
					<div>日志内容</div>
					</th>
					<th  width="10%"> 
					<div>充值金额(元)</div>
					</th>
				</tr>
				<c:forEach var="info" items="${clof.list}" varStatus="status">
					<tr>
						<td><c:out value="${status.count+(clof.intPage-1)*clof.perPageNum}" /></td>
						<td><fmt:formatDate pattern="yyyy年MM月dd日 HH:mm:ss" value="${info.chargeDate}"/></td>
						<td>
							<html:link page="/agent/agentlist.do?thisAction=view&agentId=${info.agent.id}"><c:out value="${info.agent.name}" /></html:link>
						</td>
						<td style="text-align: left;"><c:out value="${info.content}" /></td>
						<td style="text-align: right;"><fmt:formatNumber value="${info.amount}" pattern="0.00"/>&nbsp;</td>
					</tr>
				</c:forEach>
				<tr>
				<td colspan="4"><div align="center"><font>合计</font> </div> </td>
				<td style="text-align: right;"><c:out value="${clof.totalValue1}"/>&nbsp;</td>
				</tr>
			</table>

			<table width="100%" style="margin-top: 5px;">
				<tr>

					<td align="right">
					<div>共有记录&nbsp;<c:out value="${clof.totalRowCount}"></c:out>&nbsp;条&nbsp;&nbsp;&nbsp;&nbsp;
					[<a href="JavaScript:turnToPage(document.forms[0],0)">首页</a> | <a
						href="JavaScript:turnToPage(document.forms[0],1)">上一页</a> | <a
						href="JavaScript:turnToPage(document.forms[0],2)">下一页</a> | <a
						href="JavaScript:turnToPage(document.forms[0],3)"> 末页</a>] 页数:<c:out
						value="${clof.intPage}" />/<c:out value="${clof.pageCount}" />]</div>
					</td>
				</tr>
			</table>	<div class="clear"></div>
						
						</td>
						<td width="10" class="tbrr"></td>
					</tr>
					<tr>
						<td width="10" class="tblb"></td>
						<td class="tbbb"></td>
						<td width="10" class="tbrb"></td>
					</tr>
	</table>
</html:form></div>
</div>
</body>
</html>

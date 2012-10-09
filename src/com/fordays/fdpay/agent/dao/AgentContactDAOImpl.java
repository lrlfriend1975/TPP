package com.fordays.fdpay.agent.dao;

import java.util.List;

import org.hibernate.Query;

import com.fordays.fdpay.agent.Account;
import com.neza.base.BaseDAOSupport;
import com.neza.base.Hql;
import com.neza.base.ListActionForm;
import com.neza.exception.AppException;

public class AgentContactDAOImpl extends BaseDAOSupport implements AgentContactDAO {

	public List getAgentContacts(Long agentId) throws AppException {
		Hql hql=new Hql("from AgentContact a where a.agent.id=?");
		hql.addParamter(agentId);
		Query query = this.getQuery(hql);
		return query.list();
	}
	
}

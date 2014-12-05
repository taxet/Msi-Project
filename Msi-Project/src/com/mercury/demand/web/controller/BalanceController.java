package com.mercury.demand.web.controller;


import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.demand.persistence.model.Creditcard;
import com.mercury.demand.persistence.model.Trader;
import com.mercury.demand.persistence.model.Trans;
import com.mercury.demand.service.RealTimePriceService;
import com.mercury.demand.service.StocksService;
import com.mercury.demand.service.TraderService;
import com.mercury.demand.service.TransactionService;

@Controller
public class BalanceController {
	
	@Autowired
	private TraderService trader_s;
	
	public TraderService getTrader_s() {
		return trader_s;
	}

	public void setTrader_s(TraderService trader_s) {
		this.trader_s = trader_s;
	}
	
	@Autowired
	private TransactionService trans_s;
	
	public TransactionService getTrans_s() {
		return trans_s;
	}
	public void setTrans_s(TransactionService trans_s) {
		this.trans_s = trans_s;
	}
	
	@Autowired
	private StocksService stock_service;
	

	public StocksService getStock_service() {
		return stock_service;
	}

	public void setStock_service(StocksService stock_service) {
		this.stock_service = stock_service;
	}
	
	@Autowired
	private RealTimePriceService price_s;
	
	public RealTimePriceService getPrice_s() {
		return price_s;
	}

	public void setPrice_s(RealTimePriceService price_s) {
		this.price_s = price_s;
	}

	@RequestMapping(value="/app/balance.htm", method=RequestMethod.GET)
	public ModelAndView viewBalance(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/app/balance");
		return mav;
	}
	
	@RequestMapping(value="app/buyStock.htm", method=RequestMethod.POST)
	public ModelAndView buyStock(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String sid = request.getParameter("symbol");
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		String username=SecurityContextHolder.getContext().getAuthentication().getName();
		Trader trader = trader_s.getTrader(username);
		double price = price_s.getRealTimePrice(sid);
		double balance = trader.getBalance()-quantity*price-5.00;
		Trans tran = new Trans(sid, new Date(), price, quantity, "B", "P");
		if(balance<0) {
			tran.setT_status("D");
		}else {
			trader.setBalance(balance);
		}
		trans_s.makeTransaction(trader, tran);
		trader_s.save(trader);
		mav.setViewName("/app/balance");
		return mav;
	}
	
	@RequestMapping(value="app/sellStock.htm", method=RequestMethod.POST)
	public ModelAndView sellStock(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String sid = request.getParameter("symbol");
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		String username=SecurityContextHolder.getContext().getAuthentication().getName();
		Trader trader = trader_s.getTrader(username);
		double price = price_s.getRealTimePrice(sid);
		double balance = trader.getBalance()+quantity*price-5.00;
		Trans tran = new Trans(sid, new Date(), price, quantity, "S", "P");
		trader.setBalance(balance);
		trans_s.makeTransaction(trader, tran);
		trader_s.save(trader);
		mav.setViewName("/app/balance");
		return mav;
	}
	
	@RequestMapping(value="app/addBalance.htm", method=RequestMethod.POST)
	public ModelAndView addBalance(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		String card_holder = request.getParameter("Card_holder");
		byte[] card_number = request.getParameter("Card_number").getBytes();
		int expire_month = Integer.parseInt(request.getParameter("Expire_month"));
		int expire_year = Integer.parseInt(request.getParameter("Expire_year"));
		int code = Integer.parseInt(request.getParameter("Code"));
		double balance = Double.parseDouble(request.getParameter("Amount"));
		Creditcard creditcard = new Creditcard(card_holder, card_number, expire_month, expire_year, code);
		String username=SecurityContextHolder.getContext().getAuthentication().getName();
		Trader trader = trader_s.getTrader(username);
		trader.addCreditcard(creditcard);
		trader.setBalance(balance);
		trader_s.save(trader);
		mav.setViewName("/app/balance");
		return mav;
	}
	
}

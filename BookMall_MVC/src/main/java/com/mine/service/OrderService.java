package com.mine.service;

import java.util.List;

import com.mine.model.OrderPageItemDTO;

public interface OrderService {

	// 주문 정보
	public List<OrderPageItemDTO> getGoodsInfo(List<OrderPageItemDTO> orders);
	
	
}

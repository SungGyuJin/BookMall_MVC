package com.mine.mapper;

import com.mine.model.BookVO;
import com.mine.model.MemberVO;
import com.mine.model.OrderDTO;
import com.mine.model.OrderItemDTO;
import com.mine.model.OrderPageItemDTO;

public interface OrderMapper {

	// 주문 상품 정보
	public OrderPageItemDTO getGoodsInfo(int bookId);

	// 주문 상품 정보
	public OrderItemDTO getOrderInfo(int bookId);

	// 주문 테이블 등록
	public void enrollOrder(OrderDTO ord);

	// 주문 아이템 테이블 등록
	public int enrollOrderItem(OrderItemDTO orid);

	// 주문 금액 차감
	public int deductMoney(MemberVO member);

	// 주문 재고 차감
	public int deductStock(BookVO book);

}

package com.mine.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mine.mapper.AttachMapper;
import com.mine.mapper.BookMapper;
import com.mine.mapper.CartMapper;
import com.mine.mapper.MemberMapper;
import com.mine.mapper.OrderMapper;
import com.mine.model.AttachImageVO;
import com.mine.model.BookVO;
import com.mine.model.CartDTO;
import com.mine.model.MemberVO;
import com.mine.model.OrderDTO;
import com.mine.model.OrderItemDTO;
import com.mine.model.OrderPageItemDTO;

@Service
public class OrderServiceImpl implements OrderService{

	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private BookMapper bookMapper;
	
	@Override
	public List<OrderPageItemDTO> getGoodsInfo(List<OrderPageItemDTO> orders) {

		List<OrderPageItemDTO> result = new ArrayList<OrderPageItemDTO>();
		
		for(OrderPageItemDTO ord : orders) {
			
			OrderPageItemDTO goodsInfo = orderMapper.getGoodsInfo(ord.getBookId());
			
			goodsInfo.setBookCount(ord.getBookCount());
			
			goodsInfo.initSaleTotal();
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(goodsInfo.getBookId());
			
			goodsInfo.setImageList(imageList);
			
			result.add(goodsInfo);
			
		}
		
		return result;
	}
	
	@Override
	@Transactional
	public void order(OrderDTO ord) {
		
		// 회원정보
		MemberVO member = memberMapper.getMemberInfo(ord.getMemberId());
		
		// 주문 정보
		List<OrderItemDTO> ords = new ArrayList<>();
		
		for(OrderItemDTO oid : ord.getOrders()) {
			
			OrderItemDTO orderItem = orderMapper.getOrderInfo(oid.getBookId());
			
			orderItem.setBookCount(oid.getBookCount());
			
			orderItem.initSaleTotal();
			
			ords.add(orderItem);
		}
		
		ord.setOrders(ords);
		ord.getOrderPriceInfo();
		
		// DB 주문
		Date date = new Date();
		
		SimpleDateFormat format = new SimpleDateFormat("_yyyyMMddmm");
		String orderId = member.getMemberId() + format.format(date);
		ord.setOrderId(orderId);
		
		// DB넣기
		orderMapper.enrollOrder(ord);
		for(OrderItemDTO oid : ord.getOrders()) {
			oid.setOrderId(orderId);
			orderMapper.enrollOrderItem(oid);
		}
		
		// 주문 후 포인트 변화
		int calMoney = member.getMoney();
		calMoney -= ord.getOrderFinalSalePrice();
		member.setMoney(calMoney);
		
		int calPoint = member.getPoint();
		calPoint = calPoint - ord.getUsePoint() + ord.getOrderSavePoint();
		member.setPoint(calPoint);
		
		orderMapper.deductMoney(member);
		
		// 주문 후 재고 변화
		for(OrderItemDTO oid : ord.getOrders()) {
			
			// 재고변화 로직
			BookVO book = bookMapper.getbookInfo(oid.getBookId());
			book.setBookStock(book.getBookStock() - oid.getBookCount());
			
			// 재고 값 새로고침
			orderMapper.deductStock(book);
			
		}
		
		// 주문 후 장바구니 내용 초기화
		for(OrderItemDTO oit : ord.getOrders()) {
			CartDTO dto = new CartDTO();
			dto.setMemberId(ord.getMemberId());
			dto.setBookId(oit.getBookId());
			
			cartMapper.deleteOrderCart(dto);
		}
		
	}

	
	
}

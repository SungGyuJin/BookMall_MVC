package com.mine.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.mine.model.CartDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CartMapperTests {

	@Autowired
	private CartMapper mapper;
	
	@Test
	public void addCart() throws Exception {
		String memberId = "test3";
		int bookId = 1;
		int count = 5;
		
		CartDTO cart = new CartDTO();
		cart.setMemberId(memberId);
		cart.setBookId(bookId);
		cart.setBookCount(count);
		
		int result = 0;
		
		result = mapper.addCart(cart);
		
		System.out.println("결과 : " + result);
		
	}
	/* 장바구니 제거(주문 처리) */
	@Test
	public void deleteOrderCart() {
		String memberId = "test3";
		int bookId = 3201;
		
		CartDTO dto = new CartDTO();
		dto.setMemberId(memberId);
		dto.setBookId(bookId);
		
		mapper.deleteOrderCart(dto);
		
	}
//	
//	// 카트 삭제
//	@Test
//	public void deleteCartTest() {
//		
//		int cartId = 1;
//		
//		mapper.deleteCart(cartId);
//
//	}
//		
//	// 카트 수량 수정
//	@Test
//	public void modifyCartTest() {
//		int cartId = 3;
//		int count = 5;
//		
//		CartDTO cart = new CartDTO();
//		cart.setCartId(cartId);
//		cart.setBookCount(count);
//		
//		mapper.modifyCount(cart);
//		
//	}
//
//	
//	// 카트 목록
//	@Test
//	public void getCartTest() {
//		String memberId = "test3";
//			
//			
//		List<CartDTO> list = mapper.getCart(memberId);
//		for(CartDTO cart : list) {
//			System.out.println(cart);
//			cart.initSaleTotal();
//			System.out.println("init cart : " + cart);
//		}
//		
//		
//	
//	}
	// 카트 확인 
//	@Test
//	public void checkCartTest() {
//		
//		String memberId = "admin";
//		int bookId = 71;
//		
//		CartDTO cart = new CartDTO();
//		cart.setMemberId(memberId);
//		cart.setBookId(bookId);
//		
//		CartDTO resutlCart = mapper.checkCart(cart);
//		System.out.println("결과 : " + resutlCart);
//		
//	}
	
	
	
	
}

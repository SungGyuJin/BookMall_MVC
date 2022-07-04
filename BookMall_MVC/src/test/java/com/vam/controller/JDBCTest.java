package com.vam.controller;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class JDBCTest {
	
	static {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
		}catch(Exception e) {
			e.getMessage();
		}
	}
	
	@Test
	public void testConnection() {
		
		try(Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/mysql?serverTimezone=Asia/Seoul",
				"root",
				"7007")){
			System.out.println(con);
		}catch(Exception e) {
			fail(e.getMessage());
		}
	}
}

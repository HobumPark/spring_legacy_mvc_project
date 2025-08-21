package com.hb.cms.test;

import org.junit.Test;
import static org.junit.Assert.fail;
import java.sql.Connection;
import java.sql.DriverManager;
import lombok.extern.log4j.Log4j;
import java.sql.Statement;
import java.sql.ResultSet;
@Log4j
public class JDBCTest {
	static {
		try {
			Class.forName("org.mariadb.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testConnection() {
		try (Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3307/mvc_test_db", "root", "1234")) {
			System.out.println("connect:"+con);
			
			 // SQL 쿼리 작성 (test 테이블 조회)
            String sql = "SELECT * FROM test";
            try (Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
                // 결과 처리
                while (rs.next()) {
                    int no = rs.getInt("no");
                    String name = rs.getString("name");
                    // 조회된 데이터를 출력
                    System.out.println("no: " + no + ", name: " + name);
                }
            }
            
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
}
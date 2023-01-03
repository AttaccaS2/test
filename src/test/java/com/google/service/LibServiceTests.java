package com.google.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.google.domain.LibVO;
import com.google.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class LibServiceTests {

	@Setter(onMethod_ = {@Autowired})
	private LibService service;
	
	//@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	//@Test
	public void testRegister() {
		LibVO vo = new LibVO();
		vo.setName("1203");
		vo.setCity("서비스테스트");
		
		service.register(vo);
	}
	@Test
	public void testGetList(Criteria cri) {
		service.getList(cri).forEach(board->log.info(board));
	}
	
	//@Test
	public void testGet() {
		service.get(41);
		
	}
	
	//@Test
	public void testRemove() {
		service.remove(6523);
	}
	
	//@Test
	public void testModify() {
		LibVO vo = new LibVO();
		vo.setNo(6524);
		vo.setName("변경 제목");
		vo.setCity("변경 내용");
		service.modify(vo);
	}
}

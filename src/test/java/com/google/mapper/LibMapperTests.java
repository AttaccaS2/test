package com.google.mapper;

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
public class LibMapperTests {
	
	@Setter(onMethod_ = {@Autowired})
	private LibMapper mapper;
	
	//@Test
	public void testGetList() {
		mapper.getList().forEach(board->log.info(board));
	}
	
	//@Test
	public void testGetListWithPaging() {
		Criteria cri=new Criteria(1,20);
		cri.setType("C");
		cri.setKeyword("포항");	
		mapper.getListWithPaging(cri).forEach(board->log.info(board));
	}
	
	//@Test
	public void testGetListTotal() {
		Criteria cri=new Criteria(1,20);
		cri.setType("C");
		cri.setKeyword("포");
		int total = mapper.getListTotal(cri);
	}
	
	
	//@Test
	public void testInsert() {
		LibVO vo = new LibVO();
		vo.setName("새글제목");
		vo.setCity("새글내용");
		mapper.insert(vo);
		log.info("추가");
	}
	
	//@Test
	public void testInsertLastId() {
		LibVO vo = new LibVO();
		vo.setName("새제목");
		vo.setCity("새내용");
		mapper.insertLastId(vo);
		log.info(vo);
	}
	
	//@Test
	public void testRead() {
		mapper.read(38);
	}
	
	@Test
	public void testDelete() {
		mapper.delete(6526);
	}
	
	//@Test
	public void testUpdate() {
		LibVO vo = new LibVO();
		vo.setNo(6525);
		vo.setName("변경 제목");
		vo.setCity("변경 내용");
		
		mapper.update(vo);
	}
}






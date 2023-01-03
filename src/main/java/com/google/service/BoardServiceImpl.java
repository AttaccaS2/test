package com.google.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.domain.BoardAttachVO;
import com.google.domain.BoardVO;
import com.google.domain.Criteria;
import com.google.mapper.BoardAttachMapper;
import com.google.mapper.BoardMapper;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {
	
	private BoardMapper mapper;
	private BoardAttachMapper attachMapper;

	@Override
	public List<BoardVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getListTotal(Criteria cri) {
		return mapper.getListTotal(cri);
	}

	@Transactional
	@Override
	public void register(BoardVO vo) {
		mapper.insertLastId(vo);
		
		if(vo.getAttachList() == null || vo.getAttachList().size()<=0) {
			return;
		}
		
		vo.getAttachList().forEach(attach->{
			attach.setBno(vo.getBno());
			attachMapper.insert(attach);
			System.out.println(attach);
		});
	}

	@Transactional
	@Override
	public BoardVO get(long bno) {
		mapper.updateHit(bno); //조회수 증가
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean remove(long bno) {
		//참조 무결성: BoardAttach가 Board의 bno를 외래키로 참조하기때문에 attach를 먼저 지워야 한다.
		//안그러면 참조 못한다고 에러 남
		//이거를 안하려면 sql 외래키 만들때 cascade로 설정하면 된다.
		attachMapper.deleteAll(bno);
		
		return mapper.delete(bno) == 1;
		//mapper.delete(bno)가 int여야함

	}

	@Override
	public void modify(BoardVO vo) {
		mapper.update(vo);
		
		//첨부파일 테이블 삭제
		attachMapper.deleteAll(vo.getBno());
		
		//청부파일 있으면 등록	없거나 조건에 안맞으면 리턴
		if(vo.getAttachList() == null || vo.getAttachList().size()<=0) {
			return;
		}
	
		vo.getAttachList().forEach(attach->{
			attach.setBno(vo.getBno());
			attachMapper.insert(attach);
			//System.out.println(attach);
		});
		
		
		
	}

	@Override
	public List<BoardAttachVO> getAttachList(long bno) {
		return attachMapper.findByBno(bno);
	}

}

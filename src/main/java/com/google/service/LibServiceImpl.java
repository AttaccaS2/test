package com.google.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.domain.BoardAttachVO;
import com.google.domain.Criteria;
import com.google.domain.LibVO;
import com.google.mapper.BoardAttachMapper;
import com.google.mapper.LibMapper;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class LibServiceImpl implements LibService{
	
	private LibMapper mapper;
	private BoardAttachMapper attachMapper;
	
	@Transactional	
	@Override
	public void register(LibVO vo) {
		mapper.insertLastId(vo);
		
		if(vo.getAttachList() == null || vo.getAttachList().size()<=0) {
			return;
		}
		
		vo.getAttachList().forEach(attach->{
			attach.setBno(vo.getNo());
			attachMapper.insert(attach);
			System.out.println(attach);
		});
	}

	@Transactional
	@Override
	public LibVO get(int no) {
		mapper.updateHit(no); //조회수 증가
		return mapper.read(no);
	}
	@Transactional
	@Override
	public boolean remove(int no) {
		return mapper.delete(no) == 1;
	}

	@Override
	public void modify(LibVO vo) {
		mapper.update(vo);			
		//청부파일 있으면 등록	없거나 조건에 안맞으면 리턴
		if(vo.getAttachList() == null || vo.getAttachList().size()<=0) {
			return;
		}
	
		vo.getAttachList().forEach(attach->{
			attach.setBno(vo.getNo());
			attachMapper.insert(attach);
			//System.out.println(attach);
		});

		
	}

	@Override
	public List<LibVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);	}

	@Override
	public int getListTotal(Criteria cri) {
		return mapper.getListTotal(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(long bno) {
		return attachMapper.findByBno(bno);
	}

}

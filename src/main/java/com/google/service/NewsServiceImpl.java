package com.google.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.domain.BoardAttachVO;
import com.google.domain.Criteria;
import com.google.domain.NewsVO;
import com.google.mapper.BoardAttachMapper;
import com.google.mapper.NewsMapper;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class NewsServiceImpl implements NewsService {
	
	private NewsMapper mapper;
	private BoardAttachMapper attachMapper;

	@Override
	public List<NewsVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
	@Transactional
	@Override
	public void register(NewsVO vo) {
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
	public NewsVO get(long bno) {
		mapper.updateHit(bno); //조회수 증가
		return mapper.read(bno);
	}

	@Override
	public boolean remove(long bno) {
		attachMapper.deleteAll(bno);
		
		return mapper.delete(bno) == 1;
	}

	@Override
	public void modify(NewsVO vo) {
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
	public int getListTotal(Criteria cri) {
		return mapper.getListTotal(cri);
	}
	
	@Override
	public List<BoardAttachVO> getAttachList(long bno) {
		return attachMapper.findByBno(bno);
	}


}

package com.google.mapper;

import java.util.List;

import com.google.domain.BoardAttachVO;

public interface BoardAttachMapper {

	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByBno(long bno);
	
	public void deleteAll(Long bno);
	
	public List<BoardAttachVO> getOldFiles();
	
}

package com.google.service;

import java.util.List;

import com.google.domain.LibVO;
import com.google.domain.BoardAttachVO;
import com.google.domain.Criteria;

public interface LibService {

	public void register(LibVO vo);//insert
	
	public LibVO get(int no);//read	
	
	public boolean remove(int no); //delete
	
	public void modify(LibVO vo); //update
	
	public List<LibVO> getList(Criteria cri);
	
	public int getListTotal(Criteria cri);
	
	public List<BoardAttachVO> getAttachList(long bno);//첨부파일목록	
}

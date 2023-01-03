package com.google.service;

import java.util.List;

import com.google.domain.BoardAttachVO;
import com.google.domain.Criteria;
import com.google.domain.NewsVO;

public interface NewsService {
	
	public List<NewsVO> getList(Criteria cri);
	
	public int getListTotal(Criteria cri);
	
	public void register(NewsVO vo);//insert
	
	public NewsVO get(long bno);//read
	
	public boolean remove(long bno); //delete
	
	public void modify(NewsVO vo); //update
	

	public List<BoardAttachVO> getAttachList(long bno);//첨부파일목록
}

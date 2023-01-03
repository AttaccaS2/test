package com.google.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.google.domain.Criteria;
import com.google.domain.NewsVO;

public interface NewsMapper {

	public List<NewsVO> getList();
	
	public List<NewsVO> getListWithPaging(Criteria cri);	

	public int getListTotal(Criteria cri);
	
	public void insert(NewsVO vo);
	
	public long insertLastId(NewsVO vo);
	
	public NewsVO read(long bno);
	
	public int delete(long bno);
	
	public void update(NewsVO vo);
	
	public void updateReplyCnt(@Param("bno") long bno,
			@Param("amount") int amount);

	public void updateHit(long bno);
}

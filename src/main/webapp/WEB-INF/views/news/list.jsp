<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<%@ include file="../includes/header.jsp" %>    
    
<div class="wrap">
	<div class="row">
			<div class="col-md-12">
				<div class="widget p-lg">
					<h4 class="m-b-lg">공지사항</h4>
					<div style="text-align:right;" class="form-group"><a href="register" class="btn btn-default btn-sm" role="btn">New Register</a></div>
					<div class="table-responsive">
						<table class="table">
						<colgroup>
							<col style="width:80px"/>
							<col style=""/>
							<col style="width:100px"/>
							<col style="width:150px"/>
							<col style="width:150px"/>
						</colgroup>

							<tr>
								<th>#번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>수정일</th>
							</tr>

						<c:set value="0" var="rowCnt"></c:set>
						<c:forEach items="${list }" var="board">
							<tr>
								<td><c:out value="${board.bno }"></c:out></td>
								<td><a href="get?bno=<c:out value="${board.bno }"></c:out>">
								<c:out value="${board.title }"></c:out></a></td>
								<td><c:out value="${board.writer }"></c:out></td>
								<td><fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td><fmt:formatDate value="${board.updateDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							</tr>
						<c:set value="${rowCnt +1 }" var="rowCnt"></c:set>	
						</c:forEach>								
						<c:if test="${rowCnt eq 0}">							
							<tr>
								<td colspan="5">등록된 글이 없습니다.</td>
							</tr>
						</c:if>	
							</table>
					</div>
<!-- 페이지 -->
					<nav style="text-align:right;">
					  <ul class="pagination">					  
					    <c:if test="${pageMaker.prev}">
					    <li>   
					      <a href="?pageNum=${pageMaker.startPage-1 }&amount=${pageMaker.cri.amount }" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					    </c:if>
					    <c:forEach begin="${pageMaker.startPage }" 
					    end="${pageMaker.endPage }" var="num" >			
					    	
						<c:if test="${pageMaker.cri.pageNum eq num}">					
					   		<li class="active">
					   			<a>${num }</a>
					    	</li>
					    </c:if>	
					    	
						<c:if test="${pageMaker.cri.pageNum ne num}">					
					   		<li>
					   			<a href="?pageNum=${num }&amount=${pageMaker.cri.amount }">${num }</a>
					    	</li>
					    </c:if>    
						</c:forEach>
				    <c:if test="${pageMaker.next}">
				    <li>
				      <a href="?pageNum=${pageMaker.endPage + 1 }&amount=${pageMaker.cri.amount }" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
					</c:if>
					  </ul>
					</nav>
				</div><!-- .widget -->	
			</div><!-- END column -->  
	</div><!-- 	<div class="row"> -->
</div><!-- .wrap -->

<%@ include file="../includes/footer.jsp" %>  
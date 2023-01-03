<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
    
<%@ include file="../includes/header.jsp" %>    
       ${board.TABLE_ID }
<div class="wrap">
	<div class="row">
		<div class="col-md-12">
			<div class="widget">
					<header class="widget-header">
						<h4 class="widget-title">Board View</h4>
					</header><!-- .widget-header -->
					<hr class="widget-separator">
					<div class="widget-body">
						<form method="post" class="form-horizontal" action="">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}">
				
						<input type="hidden" name="bno" value="${board.bno }"/>
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"/>
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
						<input type="hidden" name="type" value="${pageMaker.cri.type }"/>
						<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }"/>
						<input type="hidden" name="writer" value="${board.writer }"/>
					
							<div class="form-group">
								<label for="exampleTextInput1" class="col-sm-3 control-label">Title:</label>
								<div class="col-sm-9">
						<c:out value="${board.title }"></c:out>	
								</div>
							</div>

							<div class="form-group">
								<label for="textarea1" class="col-sm-3 control-label">Content:</label>
								<div class="col-sm-9">
						<% pageContext.setAttribute("newLineChar", "\n"); %>		
						${fn:replace(board.content, newLineChar,'<br/>')}				
								</div>
							</div>
							
							<div class="form-group">
								<label for="exampleTextInput1" class="col-sm-3 control-label">Writer:</label>
								<div class="col-sm-9">
						<c:out value="${board.writer }"></c:out>	
								</div>
							</div>
							
							<div class="form-group">
								<label for="exampleTextInput1" class="col-sm-3 control-label">Regdate:</label>
								<div class="col-sm-9">
						<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.regdate }"/>					
								</div>
							</div>							

							<div class="row">
								<div class="col-sm-9 col-sm-offset-3">
							<sec:authentication property="principal" var="pinfo"/>
							<sec:authorize access="isAuthenticated()">
								<c:if test="${pinfo.username eq  board.writer}">
									<a href="modify${pageMaker.cri.listLink }&bno=${board.bno }" class="btn btn-success btn-sm">Modify Button</a>
									<button type="button" id="btn_remove" class="btn btn-success btn-sm">Remove Button</button>
								</c:if>
							</sec:authorize>
									
									<a href="javascript:history.go(-1)" class="btn btn-success btn-sm">List Button</a>
								</div>
							</div>
							
						</form>
					</div>
					
			<div class="mail-item">	
				<div style="height:38px;padding-top:6px;">Files</div>
				<div class="uploadResult">
					<ul style="display:flex">
	
					</ul>
				</div>
			</div>	
					<!-- .widget-body -->
				
				</div><!-- .widget -->
				
			<div class="mail-item">	
				<div style="display:inline-block;height:38px;padding-top:6px;">Reply</div>
				<div style="display:inline-block;float:right;">
				<sec:authorize access="isAuthenticated()">
				<Button data-toggle="modal" data-target="#composeModal" class="btn btn-default btn-sm" onclick="btn_new();">New Reply</Button>			
				</sec:authorize>
				</div>
			</div>	
			
			<!-- a single mail -->
			<div id="chat">				

			</div><!-- END mail-item -->
		
			<div class="col-md-12">
					<!-- 페이지 -->
					<nav style="text-align:right;">
					  <ul class="pagination">					  

					  </ul>
					</nav>
			</div><!-- 페이지 -->
			
			</div><!-- END column -->
	</div>
</div><!-- .wrap -->

<!-- Compose modal -->
<div class="modal fade" id="composeModal" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">New Reply</h4>
			</div>
			<div class="modal-body">
				<form action="#" onsubmit="return false;"> <!-- 엔터 쳐도 작동(submit) 안하게 해야한다 -->
				<input type="hidden" name="rno" id="rno">
					<textarea name="reply" id="reply" cols="30" rows="5" class="form-control" placeholder="content"></textarea>
					
					<div class="form-group">
						<input name="replyer" id="replyer" type="text" class="form-control" placeholder="writer" value="<sec:authentication property="principal.username"/>" readonly="readonly">
					</div>
				</form>
			</div>
			<div class="modal-footer">
					<button type="button" id="btn_modify" data-dismiss="" class="btn btn-primary">Modify<i class="fa fa-send"></i></button>
					<button type="button" id="btn_del" data-dismiss="" class="btn btn-primary">Remove<i class="fa fa-send"></i></button>		
					<button type="button" id="btn_reply" data-dismiss="" class="btn btn-primary">Send<i class="fa fa-send"></i></button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

function btn_new(){
	$('#rno').val('');
	$("#reply").val('');
	$("#replyer").val('<sec:authentication property="principal.username"/>');

	//원래 있던 내용 다 지워버리고
	$(".modal-footer").empty();
	let btn_footer = "";
	btn_footer +='<button type="button" id="btn_reply" data-dismiss="" class="btn btn-primary">Send<i class="fa fa-send"></i></button>';

	$(".modal-footer").html(btn_footer);
	//버튼 추가
}

function btn_modal(t){
	let rno = $(t).data("rno");
	let reply = $(t).data("reply");
	let replyer = $(t).text();
	
	//수정 위해 해당하는 값을 준다. input은 text 아니고 val
	$("#rno").val(rno);
	$("#reply").val(reply);
	$("#replyer").val(replyer);

	//footer 부분을 초기화 시키고 버튼 2개 보여줘
	$(".modal-footer").empty();
	let btn_footer = "";
	btn_footer +='<button type="button" id="btn_modify" data-dismiss="" class="btn btn-primary">Modify <i class="fa fa-send"></i></button>';
	btn_footer +='<button type="button" id="btn_del" data-dismiss="" class="btn btn-primary">Remove<i class="fa fa-send"></i></button>';
	$(".modal-footer").html(btn_footer); //innerHTML() 같은거
}

var pageNum=1;
function showReplyPage(replyCnt){
	//console.log("페이징"+replyCnt);
	var endNum = Math.ceil(pageNum / 10.0) * 10;
	var startNum = endNum - 9;
	
	var prev = startNum != 1;
	var next = false;
	
	if(endNum * 10 >= replyCnt){
		endNum = Math.ceil(replyCnt/10.0);
	}
	
	if(endNum * 10 <replyCnt){
		next = true;
	}
	
	var str = "";
	if(prev){/* if(prev == true) 이거랑 같다*/
		str += '<li>';   
		str += '<a href="'+(startNum - 1)+'" class="btn_pagination" aria-label="Previous">';
		str += '<span aria-hidden="true">&laquo;</span>';
		str += '</a>';
		str += '</li>';
	}

	for(let i = startNum; i<=endNum; i++){
		if(pageNum == i){				
			str += '<li class="active">';
			str += '<a>'+i+'</a>';
			str += '</li>';
		} else{			
			str += '<li>';
			str += '<a href="'+i+'"class="btn_pagination">'+i+'</a>';
			str += '</li>';
		}   
	}

	if(next){
		str += '<li>';
		str += '<a href="'+(endNum+1)+'" class="btn_pagination" aria-label="Next">';
		str += '<span aria-hidden="true">&raquo;</span>';
		str += '</a>';
		str += '</li>';
	}
	
	$('.pagination').html(str);
}

function getList(){
	// ajax 통신으로 댓글 목록 읽어오라
    $.ajax({
		type : "GET",         
		url : "/replies/pages/${board.bno }/"+pageNum+".json",                
		success : function(res){
			let html= "";
			//console.log(res.list); //Array(댓글 갯수) 나옴
        	for(let i=0 ; i<res.list.length; i++){
    
        		html+= '<div class="mail-item">';
        		html+= '<table class="mail-container">';
        		html+= '<tr>';
        		html+= '<td class="mail-center">';
        		html+= '<div class="mail-item-header">';
           		html+= '<h4 class="mail-item-title"><span data-toggle="modal" data-target="#composeModal" class="title-color" onclick="btn_modal(this)" data-reply="'+res.list[i].reply+'" data-rno="'+res.list[i].rno+'">'+res.list[i].replyer+'</span></h4>';
           	    html+= '</div>';
        		html+= '<p class="mail-item-excerpt">'+res.list[i].reply+'</p>';
        		html+= '</td>';
        		html+= '<td class="mail-right" style="width:160px;">';
        		html+= '<p class="mail-item-date">'+(new Date(res.list[i].replyDate).toLocaleString())+'</p>';
        		html+= '</td>';
        		html+= '</tr>';
        		html+= '</table>';
        		html+= '</div>';
        		
/*         		console.log("글번호"+res[i].bno);
        		console.log("댓글내용"+res[i].reply);
        		console.log("댓글작성자"+res[i].replyer); */
        	}
			
        	$("#chat").html(html);
        	showReplyPage(res.replyCnt); //페이징
        },
		error : function(XMLHttpRequest, textStatus, errorThrown){ 
			console.log("통신 실패.");
        }
    });
	
}
$(document).ready(function(){
	
	getList();
	$("#btn_remove").on("click",function(){		
		if(confirm("정말 삭제?")){
			$("form").attr("action","remove");
			$("form").submit();
		}
		
	});
	$(document).on("click", "#btn_del", function(){
		let replyer = $('#replyer').val();
		let rno = $('#rno').val();
		let reply = $('#reply').val();
		
		if(confirm("정말 삭제?")){
			// ajax 통신으로 댓글 삭제
		    $.ajax({
		        type : "DELETE",     
		        url : "/replies/"+rno, 
		        data : JSON.stringify({rno:rno, replyer:replyer, reply:reply}),
		        contentType : "application/json; charset=utf-8",
				beforeSend:function(xhr){	
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				}, 		   
		        success : function(res){
		        	if(res=='success'){
		        		getList();
		        	}
		        },
		        error : function(XMLHttpRequest, textStatus, errorThrown){ 
		        	console.log("통신 실패.");
		        }
		    });
			
			$("#composeModal").modal('hide');
		}
	});
	//댓글 수정
	$(document).on("click", "#btn_modify", function(){
		let rno = $('#rno').val();
		let bno = '${board.bno }';
		let reply = $("#reply").val();
		let replyer = $("#replyer").val();
		
		let data={bno:bno,
	        	reply:reply,
	        	replyer:replyer};
		
		if(reply == ''){
			alert("댓글내용을 작성해주세요");
		} else if(replyer == ''){
			alert("댓글작성자를 입력해주세요");
		} else {
			// ajax 통신
		    $.ajax({
		        type : "PUT",         
		        url : "/replies/"+rno,    
		       	contentType : 'application/json',
		        data : JSON.stringify(data),     
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				}, 		        
		        success : function(res){
		        	if(res=='success'){
		        		getList();
		        	}
		        },
		        error : function(XMLHttpRequest, textStatus, errorThrown){ 
		        	console.log("통신 실패.");
		        }
		    });
			
			$("#composeModal").modal('hide');
		}
	});
	//댓글 작성
	$(document).on("click", "#btn_reply", function(){		
		let bno = '${board.bno }';
		let reply = $("#reply").val();
		let replyer = $("#replyer").val();
		
		let data={bno:bno,
	        	reply:reply,
	        	replyer:replyer};
		
		if(reply == ''){
			alert("댓글내용을 작성해주세요");
		} else if(replyer == ''){
			alert("댓글작성자를 입력해주세요");
		} else {
			// ajax 통신
		    $.ajax({
		        type : "POST",  
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},      
		        url : "/replies/new",    
		       	contentType : 'application/json',
		        data : JSON.stringify(data),            
		        success : function(res){
		        	//console.log("댓글등록성공"+res);
		        	if(res=='success'){
		        		getList();
		        	}
		        },
		        error : function(XMLHttpRequest, textStatus, errorThrown){ 
		        	console.log("통신 실패.");
		        }
		    });
			
			$("#composeModal").modal('hide');
		}
		//console.log("댓글버튼 눌림"+reply+replyer);
	});
	
	$(document).on("click", ".btn_pagination" ,function(e){
		e.preventDefault();
	//	console.log("btn"+$(this).attr("href"));//btn2 이렇게 자기 자신 숫자가 찍힘
		pageNum = $(this).attr("href");
		getList(); //겟리스트의 아작스 url이 "/replies/pages/${board.bno }/"+pageNum+".json"라서 목록을 보여줄수있다.      
	});
	
});

	var bno = '${board.bno }';
	$.getJSON("./getAttachList", {bno:bno}, function(arr){
		console.log(arr);
		
		let str="";
		$(arr).each(function(i, attach){
			
			var fileRealPath
			= encodeURIComponent(attach.uploadPath+"/"+attach.uuid+"_"+attach.fileName);
			
			//그림파일일때
			if(attach.fileType){
				var fileCallPath
				= encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
				
				
				str+='<li style="padding:5px;">';
				str+='<a href="../download?fileName='+fileRealPath+'">';
				str+='<img src="../display?fileName='+fileCallPath+'">';
				str+='</a>'; 
				str+='</li>';
				
			}	else{
				str+='<li style="padding:5px;">';
				str+='<a href="../download?fileName='+fileRealPath+'">';
				str+='<img src="/resources/assets/images/attach.png" width="150">';
				str+='</a>'; 
				str+='</li>';
			}//그림파일 아닐때
		});
		
		$(".uploadResult ul").html(str); //.text()는 글자만 덧붙임
		//이걸 해줘야 str이 화면에 보임 <a><img></a> 라서 이미지 클릭하면 링크
	});
	
</script>
<%@ include file="../includes/footer.jsp" %>  
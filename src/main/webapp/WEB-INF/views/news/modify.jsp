<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../includes/header.jsp" %>    
    
<div class="wrap">
	<div class="row">
		<div class="col-md-12">
			<div class="widget">
					<header class="widget-header">
						<h4 class="widget-title">Board Modify</h4>
					</header><!-- .widget-header -->
					<hr class="widget-separator">
					<div class="widget-body">
						<form method="post" class="form-horizontal" action="">
						<input type="hidden" name="bno" value="${board.bno }"/>
							<div class="form-group">
								<label for="exampleTextInput1" class="col-sm-3 control-label">Title:</label>
								<div class="col-sm-9">
									<input type="text" class="form-control input-sm" id="title" 
									name="title" placeholder="Title" required="required" value="${board.title }">
								</div>
							</div>

							<div class="form-group">
								<label for="textarea1" class="col-sm-3 control-label">Content:</label>
								<div class="col-sm-9">
									<textarea class="form-control input-sm" id="content" 
									name="content" placeholder="Your content..." required="required" >${board.content }</textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label for="exampleTextInput1" class="col-sm-3 control-label">Writer:</label>
								<div class="col-sm-9">
									<input type="text" class="form-control input-sm" id="writer"
									 name="writer" placeholder="Writer" readonly="readonly" value="${board.writer }">
								</div>
							</div>

							<div class="row">
								<div class="col-sm-9 col-sm-offset-3">
									<button type="submit" class="btn btn-success btn-sm">Modify Button</button>

									<a href="javascript:history.go(-2)" class="btn btn-success btn-sm">List Button</a>
								</div>
							</div>
						</form>
					</div><!-- .widget-body -->
				</div><!-- .widget -->
			</div><!-- END column -->
	
	</div>
</div><!-- .wrap -->

<%@ include file="../includes/footer.jsp" %>  
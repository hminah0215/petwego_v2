<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

#AddQnA,#DetailQnA,#UpdateQnA,#insertRe{
	display: none;
}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<!-- 썸머노트 설정 -->
<script src="../summernote/js/summernote-lite.js"></script>
<script src="../summernote/js/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="../summernote/css/summernote-lite.css">

<script type="text/javascript">
$(function(){

	
	//썸머노트
	$('#summernote').summernote({
		height: 300,                 // 에디터 높이
		minHeight: null,             // 최소 높이
		maxHeight: null,             // 최대 높이
		focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		lang: "ko-KR",					// 한글 설정
		placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
		callbacks: {	//여기 부분이 이미지를 첨부하는 부분
			onImageUpload : function(files) {
				uploadSummernoteImageFile(files[0],this);
			}
		}
	});


	/**
	* 이미지 파일 업로드
	*/
	function uploadSummernoteImageFile(file, editor) {
	data = new FormData();
	data.append("inq_file", file);
	$.ajax({
		data : data,
		type : "POST",
		url : "/uploadSummernoteImageFile",
		contentType : false,
		processData : false,
		success : function(data) {
	    	//항상 업로드된 파일의 url이 있어야 한다.
			$(editor).summernote('insertImage', data.url);
// 			alert(data.url);
			var data_url = data.url;
			var n = data_url.split('/');
			$("#inq_file").val(n[2]);
			}
		});
	}
	
	var arr = ${list };
// 	console.log(arr);
	
	All();

	//리스트
	function All(){
		$.each(arr,function(idx,qna){
				var inq_no = $("<td></td>").append(qna.inq_no);
				var category = qna.cs_no;
				var cs_no = $("<td></td>");
				if(category == 1){
					cs_no.append("홈페이지 이용 관련");
					}
				else if(category == 2){
					cs_no.append("계정 관련");
					}
				var user_id = $("<td></td>").append(qna.user_id);
				var inq_title = $("<td></td>").append(qna.inq_title);
				var inq_date = $("<td></td>").append(qna.inq_date);
	
				var tr = $("<tr></tr>").append(inq_no,cs_no,user_id,inq_title,inq_date);
				
				$("#list").append(tr);

				//상세보기
				$(tr).on("click",function(){
					$("#ListQnA").css("display","none");
					$("#DetailQnA").css("display","block");
					var d_no = {inq_no:qna.inq_no};
					$.ajax("/admin/detailQnA",{data:d_no,success:function(detail){
						$("#detail_inq_no").val(detail.inq_no);
						$("#detail_cs_no").val(detail.cs_no);
						$("#detail_user_id").val(detail.user_id);
						$("#detail_inq_title").val(detail.inq_title);
						
						$('#detail_inq_content').append(detail.inq_content).css({"border":"1px solid"});
						
						$("#detail_inq_date").val(detail.inq_date);
						}});

					//삭제
					$("#del").click(function(){
// 						alert(qna.inq_no);
						$.ajax("/admin/deleteQnA",{data:d_no,success:function(){
							window.location.reload(true)
							$("#ListQnA").css("display","block");
							$("#DetailQnA").css("display","none");
							}});
						});

					//답변
					$("#re").click(function(){
// 						alert(qna.inq_no + "번글에 답변등록");
						$("#rebutton").css("display","none");
						$("#insertRe").css({"display":"block","border":"1px solid"});
						});
					});

				
			})
	}
	//등록폼
	$("#add").click(function(){
		$("#ListQnA").css("display","none");
		$("#AddQnA").css("display","block");
		});

	//버트 누르면 등록
	$("#btn").click(function(){	
		var i = $("#insertQnA").serialize();	
		$.ajax("/admin/insertQnA",{data:i,success:function(){
			window.location.reload(true)
			$("#ListQnA").css("display","block");
			$("#AddQnA").css("display","none");
			}});
		});
	
})
</script>

</head>
<body>
<a href="/MainPage">메인페이지</a>

<section id="ListQnA">
<h2>QnA리스트</h2>
<hr>
<table id="list" border="1" width="60%">
	<tr><th>문의번호</th><th>카테고리</th><th>작성자</th><th>제목</th><th>작성일자</th></tr>
</table>

<button id="add">QnA등록하기</button>
</section>


<section id="AddQnA">
<h2>QnA등록</h2>
<hr>
<form id="insertQnA">
카테고리<br>
<select name="cs_no" required="required">
	<option value="1">홈페이지 이용 관련</option>
	<option value="2">계정 관련</option>
</select><br>
작성자<br>
<input type="text" name="user_id" required="required"><br>
제목<br>
<input type="text" name="inq_title" required="required"><br>
내용<br>
<textarea rows="8" cols="100" id="summernote" name="inq_content"></textarea><br>
<a href="/admin/List">뒤로가기</a>
<input type="hidden" name="inq_file" id="inq_file"><br>
</form>
<input type="button" id="btn" value="문의등록"><br>
</section>

<section id="DetailQnA">
<h2>QnA상세보기</h2>
<hr>
글번호 	<input type="text" id="detail_inq_no" readonly="readonly"><br>
카테고리	<input type="text" id="detail_cs_no" readonly="readonly"><br>
작성자	<input type="text" id="detail_user_id" readonly="readonly"><br>
제목		<input type="text" id="detail_inq_title" readonly="readonly"><br>
내용		<div id="detail_inq_content"></div><br>
작성일	<input type="text" id="detail_inq_date" readonly="readonly"><br>

<section id="rebutton">
	<button id="del">삭제하기</button><br>
	<button id="re">답변달기</button><br>
</section>

<section id="insertRe">
	<h3>답변등록</h3>
	<hr>
</section>
<a href="/admin/List">QnA리스트 돌아가기</a>
</section>

<section id="UpdateQnA">

<a href="/admin/List">QnA리스트 돌아가기</a>
</section>
</body>
</html>
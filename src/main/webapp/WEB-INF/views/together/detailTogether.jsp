<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page import="org.springframework.security.core.Authentication"%>

<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께가요</title>
<style type="text/css">
.btn-primary.disabled, .btn-primary:disabled {
	background-color: #4AD4C7;
	border: none;
}
.label-secondary {
	background-color: #4AD4C7;
}
.ml-3 {
	margin-left: 0;
}
.back-to-top {
	position: fixed;
	bottom: 25px;
	right: 25px;
	display: none;
}
</style>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	var g_userList = ${g_userList};

	$.each(g_userList,function(idx,ul){
		console.log(ul.user_id);
		$("#"+ul.user_id).click(function(){
// 			$("#m_animal").empty();
			$("#animalApplication").empty();
			$("#modal-h").empty();
			var h4 = $("<h5 class='modal-title'>동물 List</h5>");
			$("#modal-h").append(h4);
			
			var th_animal_pet_name = $("<th>반려동물 이름</th>");
			var th_animal_pet_date = $("<th>반려시작일</th>");
			var th_animal_pet_pic = $("<th>반려동물 사진</th>");
			var th_animal_pet_intro = $("<th>반려동물소개</th>");
			var tr_th = $("<tr></tr>").append(th_animal_pet_name,th_animal_pet_date,th_animal_pet_pic);
			$("#animalApplication").append(tr_th);
			
// 				alert(ul.user_id);
				var chk_id = {user_id:ul.user_id};
				$.ajax("/together/chk_animal_list",{data:chk_id,success:function(re){
// 						console.log(re);

						$.each(re,function(idx,animal){
							
							var animal_pet_name = $("<td></td>").append(animal.pet_name);
							
							var animal_pet_date = $("<td></td>").append(animal.pet_date);
							var animal_pet_pic = $("<img class='mr-3 circle-rounded'>");
							animal_pet_pic.attr("src","../img/animalImg/"+animal.pet_pic);
							animal_pet_pic.attr("width",50);
							animal_pet_pic.attr("height",50);
							var td_animal_pet_pic = $("<td></td>").append(animal_pet_pic);
							var animal_pet_intro = $("<td></td>").append(animal.pet_intro);
							var tr_content = $("<tr style='height: 100px;'></tr>").append(animal_pet_name,animal_pet_date,td_animal_pet_pic);
							$("#animalApplication").append(tr_content);
							});
						
					}});
			});
		});
	 
	//form태그를  변수에 저장
	 var formObj = $("form[name='detailForm']");
 
	//수정
	$("#update_btn").on("click",function(){
		formObj.attr("action","updateTogetherView");
		formObj.attr("method","get");
		formObj.submit();
	});
	//삭제
	$("#delete_btn").on("click",function(){
      var t_attendee_cnt = ${detailTogether.t_attendee_cnt };
      if(t_attendee_cnt > 1){
    	  swal("주의!","참가자가 있는 모임은 취소할 수 없습니다.","error");
      }else if(t_attendee_cnt == 1){
//          var deleteYN = confirm("삭제하시겠습니까?");
         
//          if(deleteYN==true){
//             formObj.attr("action","deleteTogether");
//             formObj.attr("method","post");
//             formObj.submit();
//          }

		 var deleteYN = swal({
				title:"삭제하시겠습니까?",
				text:"",
				icon:"info",
				buttons:["NO","YES"]
			}).then((YES) => {
				if(YES){
		             formObj.attr("action","deleteTogether");
		             formObj.attr("method","post");
		             formObj.submit();
				}

			})
			 
         
         if(deleteYN==true){
            formObj.attr("action","deleteTogether");
            formObj.attr("method","post");
            formObj.submit();
         }
      }
   });
	   
	//검색 유지한 목록으로 돌아가기
	//5월8일 현재 동작 안되고 있음 주소창에 입력값은 가져와지는데 페이지가 넘어가지지 않음
	$("#list_btn").on("click", function(){
		event.preventDefault();
		location.href = "/together/listTogether?page=${scri.page}"
		+"&perPageNum=${scri.perPageNum}"
		+"&searchType=${scri.searchType}&keyword=${scri.keyword}";
	})
	   
	//댓글 수정 View
	$(".replyUpdateBtn").on("click", function(){

		var updateYN = swal({
			title:"수정하시겠습니까?",
			text:"",
			icon:"info",
			buttons:["NO","YES"]
		}).then((YES) => {
			if(YES){
				location.href = "/together/updateReplyView?t_num=${detailTogether.t_num}"
					+ "&page=${scri.page}"
					+ "&perPageNum=${scri.perPageNum}"
					+ "&searchType=${scri.searchType}"
					+ "&keyword=${scri.keyword}"
					//클릭이벤트가 발생한 수정버튼의 data-t_r_num을 가져오겠다.
					+ "&t_r_num="+$(this).attr("data-t_r_num");
			}

		})
		
	});
			
	//댓글 삭제 View
// 	$(".replyDeleteBtn").on("click", function(){
// 		location.href = "/together/deleteReplyView?t_num=${detailTogether.t_num}"
// 						+ "&page=${scri.page}"
// 						+ "&perPageNum=${scri.perPageNum}"
// 						+ "&searchType=${scri.searchType}"
// 						+ "&keyword=${scri.keyword}"
// 						+ "&t_r_num="+$(this).attr("data-t_r_num");
// 	});
	$(".replyDeleteBtn").on("click",function(){
		var formObj2 =  $("form[id='replyForm']");
		var deleteReplyYN = swal({
			title:"삭제하시겠습니까?",
			text:"",
			icon:"info",
			buttons:["NO","YES"]
		}).then((YES) => {
			if(YES){
				location.href = "/together/deleteReply?t_num=${detailTogether.t_num}"
					+ "&page=${scri.page}"
					+ "&perPageNum=${scri.perPageNum}"
					+ "&searchType=${scri.searchType}"
					+ "&keyword=${scri.keyword}"
					+ "&t_r_num="+$(this).attr("data-t_r_num");

			}
		})

// 		var deleteYN2 = confirm("삭제하시겠습니까?");
// 			if(deleteYN2==true){
	
// // 				formObj2.attr("action","deleteReply");
// // 				formObj2.attr("method","post");
// // 				formObj2.submit();

// 		location.href = "/together/deleteReply?t_num=${detailTogether.t_num}"
// 						+ "&page=${scri.page}"
// 						+ "&perPageNum=${scri.perPageNum}"
// 						+ "&searchType=${scri.searchType}"
// 						+ "&keyword=${scri.keyword}"
// 						+ "&t_r_num="+$(this).attr("data-t_r_num");
// 			}
	});
	//비밀댓글
   $("#replyWriteBtn").click(function(){
      //비밀댓글 파라미터 추가
      var param = $("#replyForm").serialize();
      $.ajax({
         type:"get",
         url:"/together/writeReply",
         data:param,
         success:function(){
        	 window.location.reload(true);
         }
      });
   });
 	//비밀 체크박스
    $("#secretReply_chk").click(function(){
      if($("#secretReply_chk").is(":checked") == true){
      $("#secretReply").val("y");
      }else{
         $("#secretReply").val("n");
      }
    });
	//신청하기
	var t_num = $("#t_num").val();
	var user_id = $("#user_id").val();
  	var t_size = ${detailTogether.t_size };
  	var t_attendee_cnt = ${detailTogether.t_attendee_cnt };
  	var in_user_id = "${login_id}";
  	
	console.log(t_num,user_id,t_size,t_attendee_cnt)
  	
	$("#clickApplication").hide();

	setInterval(okApplication, 3000);

	//신청하기 체크
	var okApplication = function okApplication(user_id, t_num){
		$.ajax("/together/okApplication",{data: {user_id:in_user_id,t_num:t_num}, success:function(re){
			if( re == 1 ){				//
				$("#clickApplication").show();	
				$("#Application").hide();
			}
		}})
	}
	okApplication(user_id, t_num);
	
	// 신청하기 insert
	$(document).on("click","#Application",function(){
// 		var applicationYN = confirm("신청하시겠습니까?");
// 		if(applicationYN==true){
// 			var data = $("#applicationForm").serialize();
// 			console.log(user_id,t_num)
// 			$.ajax("/together/insertApplication",{data:{user_id:user_id, t_num:t_num,t_size:t_size,t_attendee_cnt:t_attendee_cnt,in_user_id:in_user_id}, success:function(re){
// 				alert(re);
// 				if(re === "신청하기 완료"){
// 					$("#clickApplication").show();
// 					$("#Application").hide();	
// 					$("#cntApplication").html(eval($("#cntApplication").html())+1);
// 					window.location.reload();
// 				}
// 			}})
// 		}


		
		var applicationYN = swal({
			title:"신청하시겠습니까??",
			text:"",
			icon:"info",
			buttons:["NO","YES"]
		}).then((YES) => {
			if(YES){
		 			var data = $("#applicationForm").serialize();
		 			console.log(user_id,t_num)
		 			$.ajax("/together/insertApplication",{data:{user_id:user_id, t_num:t_num,t_size:t_size,t_attendee_cnt:t_attendee_cnt,in_user_id:in_user_id}, success:function(re){
		 				swal(re);
		 				if(re === "신청하기 완료"){
		 					$("#clickApplication").show();
		 					$("#Application").hide();	
		 					$("#cntApplication").html(eval($("#cntApplication").html())+1);
		 					window.location.reload();
		 				}
		 			}})
			}

		})
			
	})
	
	// 신청하기 delete 신청하기 한번 더 누르면 신청취소
	$(document).on("click","#clickApplication",function(){
		var d_user_id = '${login_id}';
		$.ajax("/together/deleteApplication",{data: {user_id:d_user_id, t_num:t_num,in_user_id:d_user_id},success: function(re){
			if( re == 1 ){
				$("#clickApplication").hide();
				$("#Application").show();
				$("#cntApplication").html(eval($("#cntApplication").html())-1);
				alert("신청취소 완료");
			}
			
		}})
		
	})
});
</script>
</head>
<body>
	<div class="basic-form" style="padding: 50px; padding-bottom: 15px;">
		<form id="detailForm" name="detailForm" role="form" method="get">
			<input type="hidden" id="token" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			<!-- scri의 값을 보관하기 위해서 form태그안에 타입 hidden -->
			<input type="hidden" id="user_id" name="user_id"
				value="${detailTogether.user_id }"> <input type="hidden"
				id="t_num" name="t_num" value="${detailTogether.t_num }" /> <input
				type="hidden" id="t_size" name="t_size"
				value="${detailTogether.t_size }" /> <input type="hidden"
				id="t_attendee_cnt" name="t_attendee_cnt"
				value="${detailTogether.t_attendee_cnt }" /> <input type="hidden"
				id="page" name="page" value="${scri.page }" /> <input type="hidden"
				id="perPageNum" name="perPageNum" value="${scri.perPageNum }" /> <input
				type="hidden" id="searchType" name="searchType"
				value="${scri.searchType }" /> <input type="hidden" id="keyword"
				name="keyword" value="${scri.keyword }" /> <input type="hidden"
				name="in_user_id" value="${login_id }">
			<div class="col-lg-12" style="background-color: white;">
				<div class="read-content">
					<div class="media pt-5">
						<img src="../img/togetherImg/crown.png" height="50" width="50"
							alt="" style="margin-top: 10px; margin-left: 20px;">
						<div class="media-body" style="float: left;">
							<h2 class="m-b-3">
								<div name="t_user_id"
									style="margin-top: 20px; margin-left: 10px; float: left;">${detailTogether.user_id}</div>
								<span class="badge badge-pill badge-primary"
									style="font-size: 15px; margin-top: 25px; margin-left: 10px;">모임장</span>
							</h2>
						</div>
						<div class="col-lg-2" style="float: left;">
							<div class="card">
								<div class="bootstrap-modal">
									<!-- Button trigger modal -->
									<button type="button" class="btn btn-primary"
										data-toggle="modal" data-target="#exampleModalLong"
										style="border: none; float: right; width: 100%;">참가자
										보기</button>
									<!-- Modal -->
									<div class="modal fade" id="exampleModalLong">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title">참가자 List</h5>
													<button type="button" class="close" data-dismiss="modal">
														<span>&times;</span>
													</button>
												</div>
												<div class="modal-body">
													<div id="userApplication">
														<form role="form">
															<input type="hidden" id="token"
																name="${_csrf.parameterName}" value="${_csrf.token}" />
															<table width="30%">
																<tr>
																	<td>현재 참여자</td>
																</tr>
																<c:forEach var="userList" items="${userList}"
																	varStatus="status">
																	<tr>
																		<td id="${userList.user_id}">${userList.user_id}</td>
																	</tr>
																</c:forEach>
															</table>
														</form>
													</div>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-secondary"
														data-dismiss="modal"
														style="background-color: #4AD4C7; border: none;">Close</button>
												</div>
												
												 
												
												
												<section id="m_animal">
												<div class="modal-header"  id="modal-h">
													<button type="button" class="close" data-dismiss="modal">
														<span>&times;</span>
													</button>
												</div>
												
												<div class="modal-body">
														<table id="animalApplication" style="text-align: center; width: 100%;">
																											
														</table>
												</div>
												</section>
											</div>
										</div>
									</div>


									<c:set var="login_id" value="${login_id }" />
									<c:set var="dt_user_id" value="${detailTogether.user_id }" />

									<c:if test="${login_id ne dt_user_id}">
										<button id="Application" class="btn btn-primary" type="button"
											style="width: 100%; border: 0; margin-top: 5px; float: right;">신청하기</button>
										<button id="clickApplication" class="btn btn-primary"
											style="width: 100%; border: 0; margin-top: 5px;">신청취소</button>
										<c:out
											value="<p id='cntApplication'>${together.t_attendee_cnt }</p>"
											escapeXml="false" />
									</c:if>

								</div>
							</div>
						</div>
					</div>
					<hr>
					<div class="media mb-4 mt-1">
						<div class="media-body">
							<span class="float-right"
								style="padding-top: 4px; padding-right: 1%;"><fmt:formatDate
									value="${detailTogether.t_open_date}" pattern="yyyy-MM-dd" /></span>
							<span class="label label-pill label-secondary"
								style="float: left; padding-left: 20px; padding-right: 20px;">제&nbsp;&nbsp;&nbsp;목</span>
							<h3 class="m-0 text-primary"
								style="float: left; padding-top: 2px;">&nbsp;&nbsp;&nbsp;${detailTogether.t_title }</h3>
						</div>
					</div>
					<hr>
					<p>${detailTogether.t_detail }</p>
					<hr>
					<div class="row m-b-30">
						<div class="card-body">
							<div class="bootstrap-label">
								<span class="label label-pill label-secondary">모임 장소</span><span>&nbsp;&nbsp;&nbsp;${detailTogether.t_place }</span><br>
								<span class="label label-pill label-secondary">참가 인원</span><span>&nbsp;&nbsp;&nbsp;${detailTogether.t_attendee_cnt }
									/ ${detailTogether.t_size }</span><br> <span
									class="label label-pill label-secondary">모임 날짜</span><span>&nbsp;&nbsp;&nbsp;${detailTogether.t_date }</span>
							</div>
							<!-- btn start -->
							
					<div class="d-flex justify-content-between pt-3 mt-5 mb-1 border-top">
						<c:if test="${login_id eq detailTogether.user_id }">
                    	<div>
                    		<a id="update_btn" href="#" class="label gradient-1 text-white px-2 mr-1"><i class="fa fa-pencil"></i> 수정</a>
                    		<a id="delete_btn" href="#" class="label gradient-9 text-white"><i class="fa fa-close"></i> 삭제</a>
                    	</div>
                    	</c:if>
                    	<div>
                        	<a id="list_btn" href="#" class="label gradient-4 text-white"><i class="fa fa-list"></i> 목록</a>
                    	</div>
                    </div>	
							<!-- btn end -->
						</div>
					</div>
					
				</div>
			</div>
<%-- 			<c:if test="${login_id eq detailTogether.user_id }">
				<button type="button" id="update_btn" class="btn mb-1 btn-primary"
					style="border: none; width: 150px;">글 수정</button>
				<button type="button" id="delete_btn" class="btn mb-1 btn-danger"
					style="border: none; width: 150px;">글 삭제</button>
			</c:if>
			<button class="btn mb-1 btn-primary" type="submit" id="list_btn"
				style="border: none; width: 150px;">목록</button> --%>
		</form>

	</div>

	<form id="replyForm" method="get">
		<input type="hidden" id="token" name="${_csrf.parameterName}"
			value="${_csrf.token}" /> <input type="hidden" id="t_num"
			name="t_num" value="${detailTogether.t_num }" /> <input
			type="hidden" id="page" name="page" value="${scri.page }" /> <input
			type="hidden" id="perPageNum" name="perPageNum"
			value="${scri.perPageNum }" /> <input type="hidden" id="searchType"
			name="searchType" value="${scri.searchType }" /> <input
			type="hidden" id="keyword" name="keyword" value="${scri.keyword }" />
		<div>
			<div class="col-xl-12" style="padding: 50px; padding-top: 0;">
				<div class="card">
					<div class="card-body">
						<div class="form-group">
							<%-- 					<label id="c_user_id" for="c_user_id">${login_id }</label> --%>
							<input type="text" id="c_user_id" name="c_user_id"
								readonly="readonly" value="${login_id }"
								style="border: none; border-right: 0px; padding-bottom: 10px; border-top: 0px; boder-left: 0px; boder-bottom: 0px;" />
							<textarea class="form-control" name="t_r_content"
								id="t_r_content" cols="30" rows="2" placeholder="댓글을 입력하세요."></textarea>
						</div>
						<input type="checkbox" id="secretReply_chk">&nbsp;&nbsp;&nbsp;비밀댓글
						<input type="hidden" id="secretReply" name="secret_reply">
						<button class="btn btn-primary px-3 ml-4"
							style="float: right; background-color: #4AD4C7; border: none;"
							id="replyWriteBtn">댓글 달기</button>
					</div>
				</div>
			</div>
		</div>



		<div class="col-xl-12"
			style="padding: 50px; padding-top: 0; padding-bottom: 0;" id="reply">
			<div class="card" id="replyList"
				style="background-color: #f2f2f9; display: block;">
				<c:forEach items="${replyList}" var="replyList">
					<div class="card-body"
						style="background-color: white; border-radius: 10px;">
						<div class="d-sm-flex justify-content-between mb-2"
							style="float: left;"></div>
						<h5 class="mb-sm-0" style="padding-top: 5px;">${replyList.user_id}</h5>
						<fmt:formatDate value="${replyList.regdate}" pattern="yyyy-MM-dd" />
						<p style="margin-top: 20px;">
							<!-- 비밀여부체크, 로그인 완성되면 함께가요 작성자,댓글작성자도 추가해야됨 -->
							<c:if test="${replyList.secret_reply ne 'y' }">
									${replyList.t_r_content }	
								</c:if>

							<c:if test="${replyList.secret_reply eq 'y'}">
								<c:if test="${login_id eq 'manager' }">
										${replyList.t_r_content }
									</c:if>

								<!-- 									댓글 작성자 -->
								<c:set var="user_id" value="${replyList.user_id }" />
								<!-- 									로그인 아이디 -->
								<c:set var="login_id" value="${login_id }" />
								<!-- 									함께가요 원본글 작성자 -->
								<c:set var="dt_user_id" value="${detailTogether.user_id }" />

								<c:if
									test="${user_id eq login_id || login_id eq dt_user_id || user_id eq login_id}">
										${replyList.t_r_content }
									</c:if>
									비밀댓글입니다<input type="image" src="/img/togetherImg/locker.jpg"
									width="15" height="15" />
							</c:if>
						</p>
						<div style="float: right;">
							<c:if test="${login_id eq replyList.user_id }">
								<a class="replyUpdateBtn" data-t_r_num="${replyList.t_r_num}"><i
									class="mdi mdi-message-draw" style="font-size: xx-large"></i></a>
								<a class="replyDeleteBtn" data-t_r_num="${replyList.t_r_num}"><i
									class="mdi mdi-file-excel-box" style="font-size: xx-large"></i></a>
							</c:if>
						</div>
					</div>
					<hr>
				</c:forEach>
			</div>
		</div>
	</form>

	<%@include file="../footer.jsp"%>
</body>
</html>
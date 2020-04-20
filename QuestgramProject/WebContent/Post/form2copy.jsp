<%@page import="data.dto.BoardDto"%>
<%@page import="data.dto.FollowDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.UserDto"%>
<%@page import="data.dao.CommentDao"%>
<%@page import="data.dao.BoardDao"%>
<%@page import="data.dao.FollowDao"%>
<%@page import="data.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" content="width=device-width, initial-scale=1">
 
<title>Questgram</title>
<style type="text/css">
 .modal-header, h4, .close {
    background-color: #5cb85c;
    color:white !important;
    text-align: center;
    font-size: 30px;
  }
  .modal-footer {
    background-color: #f9f9f9;
  }
  
  ul{
  	float: left;
  margin-left: -40px;
  width: 435px;
  
  }
  
  li {
  	list-style-type: none;
  	float: left;
  	cursor: pointer;
  	
  	
  
  }

</style>
<link rel="stylesheet" href="./css/style2.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	//하트 클릭.
/* $("#heart").click(function(){
	
		$(this).attr('src','./image/red.png');
	}); */
	
	$('#heart').on({
	   'click':function(){
			var src=($(this).attr('src')==='./image/heart.png')
			 ?'./image/red.png'
		     :'./image/heart.png';
			$(this).attr('src',src);
		}
	
	}); // 하트 클릭 
	
    $(document).ready(function(){
		  $("#trigger").click(function(){
		    $("#myModal").modal();
		  });
		}); //모달 열기
	
		
// 팔로우 여기에 작성하겠습니다 BY 김령주
	
// 팔로우 여기까지입니다 BY 김령주
});


</script>
</head>
<body>
<%
	FollowDao fdao = new FollowDao();
	BoardDao bdao = new BoardDao();
	CommentDao cdao = new CommentDao();
	
	// 유저 식별 & 정보 가져오기
	String thisId = "3";
	// 임의로 줬지만, 원래는 앞 페이지에서 넘어온 프로필id값
	// ex)  String thisId = request.getParameter("thisId");
	
//	**********팔로우 영역 구현*********
	String userId = (String)session.getAttribute("userid");
	
	String now = fdao.followNow(thisId, userId);	//팔로우 여부
	List<FollowDto> werlist = fdao.getFollowers(thisId);	// 보던 프로필의 팔로워들
	List<FollowDto> inglist = fdao.getFollowings(thisId);	// 보던 프로필의 팔로잉들
//	**********팔로우 영역 끝*********


//	**********게시글 영역 구현*********
	String boardId = "start";	// 최초 실행 값
	
	List<BoardDto> blist = bdao.getAllDatas(userId, boardId);
%>	
	<input type="hidden" id="boardsize" name="boardsize" value="<%=blist.size()%>">
	<input type="hidden" id="userId" name="userId" value="<%=userId%>">
	
<%	for (BoardDto dto: blist) {		
		String bnow = fdao.followNow(dto.getUser_id(), userId);
%>		
		<!-- 게시글, -->
		  <div class="post-container">
		  <input type="hidden" name="postnum" class="postnum" value="<%=dto.getId()%>">
		    <div class="wrap">

		      <div class="post">
		      
		       <!--뉴스피드 헤드-->
		        <div class="post-header" style="border: solid; border-width: 1px;"align="right" >
		        
		         <!-- 프로필사진 -->
		          <a href="#" class="profile">
		          <img src="./image/0.gif" alt="" align=""></a>
		          
		          <!-- 작성자 이름,팔로우,더보기 버튼까지  -->
		          <div class="head" style="; overflow : inherit; position: relative; top:40%">
		        
		          <a href="#" style="float: left;">작성자 <%=dto.getNickname() %>(<%=dto.getName() %>)</a>
			
			<!-- 팔로우 여기에 작성하겠습니다 BY 김령주 -->
					<span id="btnFollow" style="cursor: pointer;"
						userId="<%=userId %>" thisId="<%=dto.getUser_id() %>" now="<%=bnow%>"><%=bnow %></span>
			<!-- 여기까지 팔로우 작업이었습니다 BY 김령주 -->
		          
		          <a href="#"><img src="./image/more.PNG" width="60px" height="30px" id="trigger" 
		              name="trigger" class="trigger" alt="" style="float: right;"></a>
		              
		              <div class="modal fade" id="myModal" role="dialog">
		    <div class="modal-dialog">
		    
		      <!-- Modal content-->
		      <div class="modal-content">
		      
		        <div class="modal-body" style="padding:40px 50px;">
		          <form role="form">
		      			<button type="button" class="btn btn-default btn-block">게시물로 이동</button>
		                <button type="button" class="btn btn-default btn-block">링크 복사</button>
		                <button type="button" class="btn btn-default btn-block">공유하기</button>
		                <button type="button" class="btn btn-default btn-block">보관</button>
		                <button type="button" class="btn btn-default btn-block">수정</button>
		                <button type="button" class="btn btn-default btn-block">삭제</button>
		                <button type="button" class="btn btn-default btn-block">댓글 기능 해제</button>
		          </form>
		        </div>
		     </div>
		      
		    </div>
		  </div> <!-- modal 끝 -->
		              
		          </div><!-- head -->
		          
		        
		        
		        </div> <!-- 뉴스피드 헤드 끝 -->
		         <div class="text-container" align="right" style="border-width: 1px;">
		             <!-- 프로필사진 -->
		          <a href="#" class="profile">
		          <img src="./image/0.gif" alt="" align=""></a>
		             <a href="#" style="display: block; overflow: inherit; position: relative; top: 11%; float: left;" >작성자: <%=dto.getNickname() %></a>
		                <span style="float: left; margin: 0px 20px 20px 20px;">
		                   4월9일 목요일 오후4시 스토리보드 발표.
			              4월21일 화요일 중간프로젝트 발표.<br>
			              <%=dto.getContent() %>
		                </span>
		                <time style="float: left; opacity: 0.7; clear: both; margin: 10px 20px 20px 20px; font-size: 10px;">n일전 / 작성일: <%=dto.getCreated_at() %></time>
		             
		             
		         
		          </div> 
		          	<!-- 버튼 컨테이너 -->
		         <div class="btn1" align="right" style="border-width: 1px;">
		           <ul class="btn-container">
		          	
		          	<!-- 좋아요 버튼 -->
		            <li><a href="#"><img src="./image/heart.png" width="42px" height="32px" id="heart" class="heart" name="heart" alt="" ></li>
		            
		            <!-- 댓글달기 버튼 -->
		            <li><a href="#"><img src="./image/balloon.png" width="41px" height="32px" alt=""></a></li>
		            
		            <!-- 공유하기 버튼 -->
		            <li><a href="#"><img src="./image/plane.png" width="42px" height="32px" alt=""></a></li>
		            
		             <!-- 북마크 버튼 -->
		             <a href="#"><img src="./image/bookmark.png" width="43px" height="32px" id="bookmark" class="bookmark" name="bookmark" alt="" style="float: right;"></a>
		           
		          </ul>
		          	<!-- 좋아요 버튼 -->
		              <div class="like-container" style="overflow: inherit; float: left; margin-left: 10px;">
		            <a href="#">좋아요 <%=dto.getLike_count() %>개</a>
		              </div>
		              <time style="float: left; opacity: 0.7; clear: both; margin-left: 10px;">n일 전</time>
		              
		         </div> <!-- 버튼 컨테이너 -->
		         
		         <!-- 댓글 -->
		         <div class="ans" align="right" style="border-width: 1px;">
		         	<!-- 댓글을 달 텍스트에리어 -->
		            <textarea name="comment" placeholder="댓글 달기..." 
		            style="float: left;width:350px; margin-top: 16px; margin-bottom: 3px; height: 25px; border: none;"></textarea>
		            
		            <!-- 댓글 게시하기 버튼 -->
		            
		            <button type="submit" class="gesi" 
		            style="border: none; color: #0095f6; cursor: pointer; opacity: 0.7; margin-top: 16px; height: 25px; margin-right: 3px;">
		                게시</button>
		         </div>
		          
		     
		        
		         <div class="sajin" style="width:598px;
			           height: 598px;">
		          <img src="./image/ramgi.jpeg" align="left" class="sajinimg" style="width:598px; 
			            height: 598px;" alt="">
			            
			            
		        </div>
		        </div>
		        </div>
		        </div>
		
		
<%	}
	

		// 전체출력 후 "더보기" 버튼 구현
		
%>		<button type="button" id="more" style="font-weight: bold;">더보기</button>
		<script type="text/javascript">
			$("#more").on("click", function() {
				var size = $("#boardsize").val();
				var last = $(".postnum").eq(size-1).val();
				var userId = $("#userId").val();
				console.log(size, last, userId);
				
				$.ajax({
					type: "post",
					dataType: "xml",
					data: {"userId": userId, "boardId": last},
					url: "form2copyaction.jsp",
					success: function(data) {
						var str = "";	// html 출력문에 넣을 텍스트
						
						$(data).find("data").each(function(i) {
							var dt = $(this);		// 한 줄짜리 데이터
							var boardId = dt.find("boardId").text();
							var userId = dt.find("userId").text();
							var content = dt.find("content").text();
							var commentCount = dt.find("commentCount").text();
							var likeCount = dt.find("likeCount").text();
							var viewCount = dt.find("viewCount").text();
							var shareCount = dt.find("shareCount").text();
							var createdAt = dt.find("createdAt").text();
							var name = dt.find("name").text();
							var nickname = dt.find("nickname").text();
							var profileImg = dt.find("profileImg").text();
							var originName = dt.find("originName").text();
							var saveName = dt.find("saveName").text();
							
							str += "<h2>여기에 게시글의 태그를 그대로 써 주시면 됩니다</h2>";
							str += "예시: <br>";
							str += "boardId : " + boardId;
						});
						// $(영역).html(str);
					}
				});
			});
		</script>
<%		
//	**********게시글 영역 끝***********
%>

	

        
        
         
          
        
        
        <!-- ------------------------------------------- -->
        
        
      


<main>

	<div class="container">

		<div class="gallery">

			<div class="gallery-item" tabindex="0">

				<img src="./image/0.gif" class="gallery-image" alt="">

				<div class="gallery-item-info">

					<ul>
						<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 56</li>
						<li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 2</li>
					</ul>

				</div>

			</div>

			<div class="gallery-item" tabindex="0">

				<img src="./image/0.gif" class="gallery-image" alt="">

				<div class="gallery-item-info">

					<ul>
						<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 89</li>
						<li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 5</li>
					</ul>

				</div>

			</div>

			<div class="gallery-item" tabindex="0">

				<img src="./image/0.gif" class="gallery-image" alt="">

				<div class="gallery-item-type">

					<span class="visually-hidden">Gallery</span><i class="fas fa-clone" aria-hidden="true"></i>

				</div>

				<div class="gallery-item-info">

					<ul>
						<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 42</li>
						<li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 1</li>
					</ul>

				</div>

			</div>

			<div class="gallery-item" tabindex="0">

				<img src="./image/0.gif" class="gallery-image" alt="">

				<div class="gallery-item-type">

					<span class="visually-hidden">Video</span><i class="fas fa-video" aria-hidden="true"></i>

				</div>

				<div class="gallery-item-info">

					<ul>
						<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 38</li>
						<li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 0</li>
					</ul>

				</div>

			</div>

			<div class="gallery-item" tabindex="0">

				<img src="./image/0.gif" class="gallery-image" alt="">

				<div class="gallery-item-type">

					<span class="visually-hidden">Gallery</span><i class="fas fa-clone" aria-hidden="true"></i>

				</div>

				<div class="gallery-item-info">

					<ul>
						<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 47</li>
						<li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 1</li>
					</ul>

				</div>

			</div>

			<div class="gallery-item" tabindex="0">

				<img src="./image/0.gif" class="gallery-image" alt="">

				<div class="gallery-item-info">

					<ul>
						<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 94</li>
						<li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 3</li>
					</ul>

				</div>

			</div>

			<div class="gallery-item" tabindex="0">

				<img src="./image/0.gif" class="gallery-image" alt="">

				<div class="gallery-item-type">

					<span class="visually-hidden">Gallery</span><i class="fas fa-clone" aria-hidden="true"></i>

				</div>

				<div class="gallery-item-info">

					<ul>
						<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 52</li>
						<li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 4</li>
					</ul>

				</div>

			</div>

			<div class="gallery-item" tabindex="0">

				<img src="./image/0.gif" class="gallery-image" alt="">

				<div class="gallery-item-info">

					<ul>
						<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 66</li>
						<li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 2</li>
					</ul>

				</div>

			</div>

			<div class="gallery-item" tabindex="0">

				<img src="./image/0.gif" class="gallery-image" alt="">

				<div class="gallery-item-type">

					<span class="visually-hidden">Gallery</span><i class="fas fa-clone" aria-hidden="true"></i>

				</div>

				<div class="gallery-item-info">

					<ul>
						<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 45</li>
						<li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 0</li>
					</ul>

				</div>

			</div>

			<div class="gallery-item" tabindex="0">

				<img src="./image/0.gif" class="gallery-image" alt="">

				<div class="gallery-item-info">

					<ul>
						<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 34</li>
						<li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 1</li>
					</ul>

				</div>

			</div>

			<div class="gallery-item" tabindex="0">

				<img src="./image/0.gif" class="gallery-image" alt="">

				<div class="gallery-item-info">

					<ul>
						<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 41</li>
						<li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 0</li>
					</ul>

				</div>

			</div>

			<div class="gallery-item" tabindex="0">

				<img src="./image/0.gif" class="gallery-image" alt="">

				<div class="gallery-item-type">

					<span class="visually-hidden">Video</span><i class="fas fa-video" aria-hidden="true"></i>

				</div>

				<div class="gallery-item-info">

					<ul>
						<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 30</li>
						<li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 2</li>
					</ul>

				</div>

			</div>

		</div>
		<!-- End of gallery -->

		<!-- <div class="loader"></div> -->

	</div>
	<!-- End of container -->

</main>
  
  

</body>
</html>
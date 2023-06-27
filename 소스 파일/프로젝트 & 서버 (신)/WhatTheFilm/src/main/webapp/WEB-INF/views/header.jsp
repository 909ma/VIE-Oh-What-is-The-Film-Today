<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="wrap">
	<header id="header">

		<!--  <h1>
			<a href="#"> <em><img id="mainLogo"
					src="${pageContext.request.contextPath}/resources/image/main logo.png"
					alt="main logo" width="150" height="50" /></em>

			</a>
		</h1>  -->
		<div class="header_area box_inner clear">
			<h1>
				<a href="javascript:;">VIE</a>
			</h1>
			<p class="openMOgnb">
				<a href="#"><b class="hdd">메뉴열기</b> <span></span> <span></span>
					<span></span> </a>
			</p>

			<!-- header_cont -->

			<div class="header_cont">
				<br><br>
				<nav>
					<ul class="gnb clear">
						<li><a href="/big3" class="openAll1"><i class="fa solid fa-ranking-star icon" aria-hidden="true" style="color:#white;font-size:25px;"></i>&nbsp;&nbsp;&nbsp;BIG3</a></li>
						<li><a href="javascript:;" class="openAll2"><i class="fa-regular fa-clipboard icon" aria-hidden="true" style="color:#white;font-size:27px;"></i>&nbsp;자유게시판</a>
							<div class="gnb_depth gnb_depth2_2">
								<ul class="submenu_list">
									<li><a href="/announcement/list">공지사항</a></li>
									<li><a href="/freeboard">자유게시판</a></li>
								</ul>
							</div></li>
						<li><a href="javascript:;" class="openAll3"><i class="fa-solid fa-video icon" aria-hidden="true" style="color:#white;font-size:27px;"></i>&nbsp;영화투어</a>
							<div class="gnb_depth gnb_depth2_3">
								<ul class="submenu_list">
									<li><a href="/SearchMovie">영화찾기</a></li>
									<li><a href="/recommend?audiacc=10000000">영화평점</a></li>
								</ul>
							</div></li>
						<li><a href="javascript:;" class="openAll4"><i class="fa-solid fa-magnifying-glass icon" aria-hidden="true" style="color:#white;font-size:27px;"></i>&nbsp;영화조회</a>
							<div class="gnb_depth gnb_depth2_4">
								<ul class="submenu_list">
									<li><a href="/dailyMovie">상영작통계</a></li>
									<li><a href="/HowMuchDailyMovie">개봉작통계</a></li>
								</ul>
							</div></li>
					</ul>
				</nav>
				<p class="closePop">
					<a href="javascript:;"></a>
				</p>
			</div>
			<!-- //header_cont -->
		</div>
	</header>

	<div id="container">
		<div class="main_rolling_pc">
			<div class="visualRoll">
				<ul class="viewImgList">
					<li class="imglist0">
						<div class="roll_content">
							<a href="/board"> <img class="responsive-img" src="${pageContext.request.contextPath}/resources/image/head_crimecity1.jpg" alt="1위" ></a>
							<!-- <p class="roll_txtline">경북산업직업전문학교</p> -->
						</div>
					</li>
					<li class="imglist1">
						<div class="roll_content">
							<a href="/board"> <img class="responsive-img" src="${pageContext.request.contextPath}/resources/image/head_spiderman.jpg" alt="2위" ></a>
							<!-- <p class="roll_txtline">아 오늘 영화 뭐 보지?</p> -->
						</div>
					</li>
					<li class="imglist2">
						<div class="roll_content">
							<a href="/board"> <img class="responsive-img" src="${pageContext.request.contextPath}/resources/image/head_indiana3.jpg" alt="3위" ></a>
							<!-- <p class="roll_txtline">VIE</p> -->
						</div>
					</li>
				</ul>

				<div class="rollbtnArea">
					<ul class="rollingbtn">
						<li class="seq butt0"><a href="#butt"><img src="${pageContext.request.contextPath}/resources/image/btn_rollbutt_on.png" alt="1번" ></a></li>
						<li class="seq butt1"><a href="#butt"><img src="${pageContext.request.contextPath}/resources/image/btn_rollbutt_off.png" alt="2번" ></a></li>
						<li class="seq butt2"><a href="#butt"><img src="${pageContext.request.contextPath}/resources/image/btn_rollbutt_off.png" alt="3번" ></a></li>
						<li class="rollstop"><a href="#" class="stop"><img src="${pageContext.request.contextPath}/resources/image/btn_roll_stop.png" alt="멈춤" /></a></li>
						<li class="rollplay"><a href="#" class="play"><img src="${pageContext.request.contextPath}/resources/image/btn_roll_play.png" alt="재생" /></a></li>
					</ul>
				</div> <!-- // rollbtnArea -->
				
			</div> <!--// visualRoll -->
		</div> <!--  // main_rolling_pc  -->
		<div class="main_rolling_mobile">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<a href="javascript:;"><img src="${pageContext.request.contextPath}/resources/image/head_crimecity1.jpg" alt="..."></a>
					</div>
					<div class="swiper-slide">
						<a href="javascript:;"><img src="${pageContext.request.contextPath}/resources/image/head_spiderman.jpg" alt="..."></a>
					</div>
					<div class="swiper-slide">
						<a href="javascript:;"><img src="${pageContext.request.contextPath}/resources/image/head_indiana3.jpg" alt="..."></a>
					</div>
				</div>
				<div class="swiper-pagination"></div>
				<div class="rollbtnArea">
					<ul class="rollingbtn">
						<li class="seq butt0"><a href="#butt"><img src="${pageContext.request.contextPath}/resources/image/btn_rollbutt_on.png" alt="1번" ></a></li>
						<li class="seq butt1"><a href="#butt"><img src="${pageContext.request.contextPath}/resources/image/btn_rollbutt_off.png" alt="2번" ></a></li>
						<li class="seq butt2"><a href="#butt"><img src="${pageContext.request.contextPath}/resources/image/btn_rollbutt_off.png" alt="3번" ></a></li>
						<li class="rollstop"><a href="#" class="stop"><img src="${pageContext.request.contextPath}/resources/image/btn_roll_stop.png" alt="멈춤" /></a></li>
						<li class="rollplay"><a href="#" class="play"><img src="${pageContext.request.contextPath}/resources/image/btn_roll_play.png" alt="재생" /></a></li>
					</ul>
				</div>
			</div>
			
		</div>
	</div>
</div>

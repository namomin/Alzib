<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>알바추천</title>
<link href="recommend.css" rel="stylesheet" type="text/css">
<style>
		.nav{
			text-align: left;
			margin-left: 15%;
			width: 20%;
			border-radius: 10px;
			border: 1px solid #689ADE;
			padding: 15px;
			color: #689ADE;
			margin-bottom: 15px;
		}

		a{
			color: #689ADE;
			text-decoration: none;
		}

		a:hover{
			color:#CADCF4;
		}
</style>
</head>

<body>
<div class="wrap">
<div class="nav">
		<span><a href="main.jsp">홈</a> > <a href="recommend.jsp">알바추천</a></span>
</div>
	<div class="head_wrap">
		<div class="head_title">
			<span id="title">나에게 꼭 맞는 알바 추천받기</span><br><br>
			<span>문항은 총 36개로 소요시간은 15분 내외</span><br>
			<span>자신에게 적합한 알바를 추천받기 위해선 문항에 솔직하게 답변해주세요.</span>
		</div>
	</div>	

<form name="recommend" action="recommendResult.jsp" method="post">
	<div class="question_wrap">
		
		<div class="question">
			<span class="q">1. 내가 사는 곳은?</span><br>
			<div class="choice">
				<table>
					<tr>
						<td>
							<span class="a">
								<select id="area">
									<option value="chungnam">천안</option>
            					</select>
								<select id="district" onchange="changeDongGroup()">
									<option value="chungnam_s">서북구</option>
									<option value="chungnam_e">동남구</option>
								</select>
								<select name="Dong">
								<optgroup id="dongGroup1" label="서북구">
									<option value="36.817153,127.114144" style="display:none;"></option>
									<option value="36.817153,127.114144">두정동</option>
									<option value="36.810065,127.142840">백석동</option>
									<option value="36.819352,127.125172">부대동</option>
									<option value="36.814919,127.142734">불당동</option>
									<option value="36.792273,127.116334">성거읍</option>
									<option value="36.834647,127.102732">성성동</option>
									<option value="36.826215,127.136540">성정동</option>
									<option value="36.768938,127.142470">성환읍</option>
									<option value="36.810452,127.111012">신당동</option>
									<option value="36.816102,127.125325">쌍용동</option>
									<option value="36.810732,127.123554">업성동</option>
									<option value="36.827044,127.150050">와촌동</option>
									<option value="36.767202,127.134297">입장면</option>
									<option value="36.762238,127.117218">직산읍</option>
									<option value="36.824218,127.115394">차암동</option>
								</optgroup>
								<optgroup id="dongGroup2" label="동남구">
									<option value="36.805877,127.129896">안서동</option>
									<option value="36.792896,127.154356">안평동</option>
									<option value="36.789136,127.148836">연무동</option>
									<option value="36.784649,127.160478">영성동</option>
									<option value="36.795370,127.138540">오룡동</option>
									<option value="36.792008,127.146733">원성동</option>
									<option value="36.797668,127.136274">유천동</option>
									<option value="36.797581,127.154657">진봉동</option>
									<option value="36.792647,127.133992">진성동</option>
									<option value="36.791614,127.140546">차룡동</option>
									<option value="36.793220,127.150777">청당동</option>
									<option value="36.787980,127.150800">청수동</option>
									<option value="36.783912,127.143612">탑립동</option>
									<option value="36.790595,127.143717">풍곡동</option>
									<option value="36.796632,127.140988">호명동</option>
								</optgroup>
								</select>											
							</span>
						</td>
					</tr>
				</table>
			</div>
		</div>

		
		<div class="question">
			<span class="q">2. 바쁘게 일하고 일한만큼 급여를 받고 싶다.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice2-1" name="a1" value="0"><label for="choice2-1" class="custom-radio"></label>
							<input type="radio" id="choice2-2" name="a1" value="1"><label for="choice2-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">3. 급여만 만족스럽다면 바빠도 힘든 곳에서도 일할 자신이 있다.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice3-1" name="a2" value="0"><label for="choice3-1" class="custom-radio"></label>
							<input type="radio" id="choice3-2" name="a2" value="1"><label for="choice3-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">4. 이동할 때 에너지를 많이 소모하는 편이다.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice4-1" name="b1" value="0"><label for="choice4-1" class="custom-radio"></label>
							<input type="radio" id="choice4-2" name="b1" value="1"><label for="choice4-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">5. 원하던 일자리가 대중교통으로 오래 이동해야하는 곳에 위치해 있다면,<br>차라리 원하던 곳이 아니더라도 집근처의 직장을 다닐것이다.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice5-1" name="b2" value="0"><label for="choice5-1" class="custom-radio"></label>
							<input type="radio" id="choice5-2" name="b2" value="1"><label for="choice5-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">6. 버스로 3정거장 정도의 거리는 버스를 타는것 보다 걸어가는 것이<br>교통비도 아끼고 운동도 되기 때문에 더 선호한다.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice6-1" name="b3" value="0"><label for="choice6-1" class="custom-radio"></label>
							<input type="radio" id="choice6-2" name="b3" value="1"><label for="choice6-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">7. 밤일때 일의 효율이 좋다.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice7-1" name="c1" value="0"><label for="choice7-1" class="custom-radio"></label>
							<input type="radio" id="choice7-2" name="c1" value="1"><label for="choice7-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">8. 평일에 일하고 주말에는 자신만의 시간을 가져야한다고 생각한다.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice8-1" name="c2" value="0"><label for="choice8-1" class="custom-radio"></label>
							<input type="radio" id="choice8-2" name="c2" value="1"><label for="choice8-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">9. 일찍 일어나서 하루를 알차게 보내고 싶다.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice9-1" name="c3" value="0"><label for="choice9-1" class="custom-radio"></label>
							<input type="radio" id="choice9-2" name="c3" value="1"><label for="choice9-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">10. 한가지 일을 진득하게 오래 잘 할 수 있다.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice10-1" name="d1" value="0"><label for="choice10-1" class="custom-radio"></label>
							<input type="radio" id="choice10-2" name="d1" value="1"><label for="choice10-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">11. 다양한 경험을 하는 것을 선호한다.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice11-1" name="d2" value="0"><label for="choice11-1" class="custom-radio"></label>
							<input type="radio" id="choice11-2" name="d2" value="1"><label for="choice11-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">12. 환경이 자주 변하는 것보다 익숙한 곳에 있는것을 더 선호한다.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice12-1" name="d3" value="0"><label for="choice12-1" class="custom-radio"></label>
							<input type="radio" id="choice12-2" name="d3" value="1"><label for="choice12-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">13. 평소 다양한 사람들과 교류하는 것을 선호하는 편이다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice13-1" name="cate13" value="1"><label for="choice13-1" class="custom-radio"></label>
							<input type="radio" id="choice13-2" name="cate13" value="2"><label for="choice13-2" class="custom-radio"></label>
							<input type="radio" id="choice13-3" name="cate13" value="3"><label for="choice13-3" class="custom-radio"></label>
							<input type="radio" id="choice13-4" name="cate13" value="4"><label for="choice13-4" class="custom-radio"></label>
							<input type="radio" id="choice13-5" name="cate13" value="5"><label for="choice13-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">14. 역할을 분담해 팀활동 하는 것을 선호하는 편이다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice14-1" name="cate14" value="1"><label for="choice14-1" class="custom-radio"></label>
							<input type="radio" id="choice14-2" name="cate14" value="2"><label for="choice14-2" class="custom-radio"></label>
							<input type="radio" id="choice14-3" name="cate14" value="3"><label for="choice14-3" class="custom-radio"></label>
							<input type="radio" id="choice14-4" name="cate14" value="4"><label for="choice14-4" class="custom-radio"></label>
							<input type="radio" id="choice14-5" name="cate14" value="5"><label for="choice14-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">15. 혼자 일하는 것보다 활발한 동료들과 함께 일하는 것이 더 좋다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice15-1" name="cate15" value="1"><label for="choice15-1" class="custom-radio"></label>
							<input type="radio" id="choice15-2" name="cate15" value="2"><label for="choice15-2" class="custom-radio"></label>
							<input type="radio" id="choice15-3" name="cate15" value="3"><label for="choice15-3" class="custom-radio"></label>
							<input type="radio" id="choice15-4" name="cate15" value="4"><label for="choice15-4" class="custom-radio"></label>
							<input type="radio" id="choice15-5" name="cate15" value="5"><label for="choice15-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">16. 돌발상황이 발생해도 침착하게 바로 대처할 수 있다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice16-1" name="cate16" value="1"><label for="choice16-1" class="custom-radio"></label>
							<input type="radio" id="choice16-2" name="cate16" value="2"><label for="choice16-2" class="custom-radio"></label>
							<input type="radio" id="choice16-3" name="cate16" value="3"><label for="choice16-3" class="custom-radio"></label>
							<input type="radio" id="choice16-4" name="cate16" value="4"><label for="choice16-4" class="custom-radio"></label>
							<input type="radio" id="choice16-5" name="cate16" value="5"><label for="choice16-5" class="custom-radio"></label>
						</td>
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">17. 배려심이 많은편이다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice17-1" name="cate17" value="1"><label for="choice17-1" class="custom-radio"></label>
							<input type="radio" id="choice17-2" name="cate17" value="2"><label for="choice17-2" class="custom-radio"></label>
							<input type="radio" id="choice17-3" name="cate17" value="3"><label for="choice17-3" class="custom-radio"></label>
							<input type="radio" id="choice17-4" name="cate17" value="4"><label for="choice17-4" class="custom-radio"></label>
							<input type="radio" id="choice17-5" name="cate17" value="5"><label for="choice17-5" class="custom-radio"></label>
						</td>
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">18. 남들앞에서 발표를 할 때 마이크 없이도 큰 목소리로 발표할 수 있다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice18-1" name="cate18" value="1"><label for="choice18-1" class="custom-radio"></label>
							<input type="radio" id="choice18-2" name="cate18" value="2"><label for="choice18-2" class="custom-radio"></label>
							<input type="radio" id="choice18-3" name="cate18" value="3"><label for="choice18-3" class="custom-radio"></label>
							<input type="radio" id="choice18-4" name="cate18" value="4"><label for="choice18-4" class="custom-radio"></label>
							<input type="radio" id="choice18-5" name="cate18" value="5"><label for="choice18-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">19. 내 기분에 상관없이 남에게 항상 친절을 유지할 수 있다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice19-1" name="cate19" value="1"><label for="choice19-1" class="custom-radio"></label>
							<input type="radio" id="choice19-2" name="cate19" value="2"><label for="choice19-2" class="custom-radio"></label>
							<input type="radio" id="choice19-3" name="cate19" value="3"><label for="choice19-3" class="custom-radio"></label>
							<input type="radio" id="choice19-4" name="cate19" value="4"><label for="choice19-4" class="custom-radio"></label>
							<input type="radio" id="choice19-5" name="cate19" value="5"><label for="choice19-5" class="custom-radio"></label>
						</td>
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">20. 스트레스를 받는 상황에서 침착함을 유지할 수 있다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice20-1" name="cate20" value="1"><label for="choice20-1" class="custom-radio"></label>
							<input type="radio" id="choice20-2" name="cate20" value="2"><label for="choice20-2" class="custom-radio"></label>
							<input type="radio" id="choice20-3" name="cate20" value="3"><label for="choice20-3" class="custom-radio"></label>
							<input type="radio" id="choice20-4" name="cate20" value="4"><label for="choice20-4" class="custom-radio"></label>
							<input type="radio" id="choice20-5" name="cate20" value="5"><label for="choice20-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">21. 구조화된 상황에서 안정을 느낀다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice21-1" name="cate21" value="1"><label for="choice21-1" class="custom-radio"></label>
							<input type="radio" id="choice21-2" name="cate21" value="2"><label for="choice21-2" class="custom-radio"></label>
							<input type="radio" id="choice21-3" name="cate21" value="3"><label for="choice21-3" class="custom-radio"></label>
							<input type="radio" id="choice21-4" name="cate21" value="4"><label for="choice21-4" class="custom-radio"></label>
							<input type="radio" id="choice21-5" name="cate21" value="5"><label for="choice21-5" class="custom-radio"></label>
						</td>		
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">22. 엑셀, 한글 같은 기본적인 문서편집 툴을 다룰 수 있다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice22-1" name="cate22" value="1"><label for="choice22-1" class="custom-radio"></label>
							<input type="radio" id="choice22-2" name="cate22" value="2"><label for="choice22-2" class="custom-radio"></label>
							<input type="radio" id="choice22-3" name="cate22" value="3"><label for="choice22-3" class="custom-radio"></label>
							<input type="radio" id="choice22-4" name="cate22" value="4"><label for="choice22-4" class="custom-radio"></label>
							<input type="radio" id="choice22-5" name="cate22" value="5"><label for="choice22-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>

			</div>
		</div>
		
		<div class="question">
			<span class="q">23. 작업을 체계화 하는것을 좋아한다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice23-1" name="cate23" value="1"><label for="choice23-1" class="custom-radio"></label>
							<input type="radio" id="choice23-2" name="cate23" value="2"><label for="choice23-2" class="custom-radio"></label>
							<input type="radio" id="choice23-3" name="cate23" value="3"><label for="choice23-3" class="custom-radio"></label>
							<input type="radio" id="choice23-4" name="cate23" value="4"><label for="choice23-4" class="custom-radio"></label>
							<input type="radio" id="choice23-5" name="cate23" value="5"><label for="choice23-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>

			</div>
		</div>
		
		<div class="question">
			<span class="q">24. 목표 지향적인 업무 방식을 선호하는 편이다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice24-1" name="cate24" value="1"><label for="choice24-1" class="custom-radio"></label>
							<input type="radio" id="choice24-2" name="cate24" value="2"><label for="choice24-2" class="custom-radio"></label>
							<input type="radio" id="choice24-3" name="cate24" value="3"><label for="choice24-3" class="custom-radio"></label>
							<input type="radio" id="choice24-4" name="cate24" value="4"><label for="choice24-4" class="custom-radio"></label>
							<input type="radio" id="choice24-5" name="cate24" value="5"><label for="choice24-5" class="custom-radio"></label>
						</td>		
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>

			</div>
		</div>
		
		<div class="question">
			<span class="q">25. 새로운 아이디어나 관점에 대한 수용능력이 높은 편이다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice25-1" name="cate25" value="1"><label for="choice25-1" class="custom-radio"></label>
							<input type="radio" id="choice25-2" name="cate25" value="2"><label for="choice25-2" class="custom-radio"></label>
							<input type="radio" id="choice25-3" name="cate25" value="3"><label for="choice25-3" class="custom-radio"></label>
							<input type="radio" id="choice25-4" name="cate25" value="4"><label for="choice25-4" class="custom-radio"></label>
							<input type="radio" id="choice25-5" name="cate25" value="5"><label for="choice25-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>

			</div>
		</div>
		
		<div class="question">
			<span class="q">26. 정리 정돈하는 것을 좋아한다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice26-1" name="cate26" value="1"><label for="choice26-1" class="custom-radio"></label>
							<input type="radio" id="choice26-2" name="cate26" value="2"><label for="choice26-2" class="custom-radio"></label>
							<input type="radio" id="choice26-3" name="cate26" value="3"><label for="choice26-3" class="custom-radio"></label>
							<input type="radio" id="choice26-4" name="cate26" value="4"><label for="choice26-4" class="custom-radio"></label>
							<input type="radio" id="choice26-5" name="cate26" value="5"><label for="choice26-5" class="custom-radio"></label>
						</td>			
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">27. 수학적인 능력을 가지고 있다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice27-1" name="cate27" value="1"><label for="choice27-1" class="custom-radio"></label>
							<input type="radio" id="choice27-2" name="cate27" value="2"><label for="choice27-2" class="custom-radio"></label>
							<input type="radio" id="choice27-3" name="cate27" value="3"><label for="choice27-3" class="custom-radio"></label>
							<input type="radio" id="choice27-4" name="cate27" value="4"><label for="choice27-4" class="custom-radio"></label>
							<input type="radio" id="choice27-5" name="cate27" value="5"><label for="choice27-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">28. 다른 사람의 행동을 이끌고 통제하는 활동을 선호하는 편이다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice28-1" name="cate28" value="1"><label for="choice28-1" class="custom-radio"></label>
							<input type="radio" id="choice28-2" name="cate28" value="2"><label for="choice28-2" class="custom-radio"></label>
							<input type="radio" id="choice28-3" name="cate28" value="3"><label for="choice28-3" class="custom-radio"></label>
							<input type="radio" id="choice28-4" name="cate28" value="4"><label for="choice28-4" class="custom-radio"></label>
							<input type="radio" id="choice28-5" name="cate28" value="5"><label for="choice28-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">29. 주도적으로 남들을 이끌 수 있다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice29-1" name="cate29" value="1"><label for="choice29-1" class="custom-radio"></label>
							<input type="radio" id="choice29-2" name="cate29" value="2"><label for="choice29-2" class="custom-radio"></label>
							<input type="radio" id="choice29-3" name="cate29" value="3"><label for="choice29-3" class="custom-radio"></label>
							<input type="radio" id="choice29-4" name="cate29" value="4"><label for="choice29-4" class="custom-radio"></label>
							<input type="radio" id="choice29-5" name="cate29" value="5"><label for="choice29-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">30. 설득력을 있는 의사표현을 이용해서 다른사람과의 대화를 이끌어 갈 수 있다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice30-1" name="cate30" value="1"><label for="choice30-1" class="custom-radio"></label>
							<input type="radio" id="choice30-2" name="cate30" value="2"><label for="choice30-2" class="custom-radio"></label>
							<input type="radio" id="choice30-3" name="cate30" value="3"><label for="choice30-3" class="custom-radio"></label>
							<input type="radio" id="choice30-4" name="cate30" value="4"><label for="choice30-4" class="custom-radio"></label>
							<input type="radio" id="choice30-5" name="cate30" value="5"><label for="choice30-5" class="custom-radio"></label>
						</td>		
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">31. 내가 가진 지식을 남에게 설명하는 것을 잘한다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice31-1" name="cate31" value="1"><label for="choice31-1" class="custom-radio"></label>
							<input type="radio" id="choice31-2" name="cate31" value="2"><label for="choice31-2" class="custom-radio"></label>
							<input type="radio" id="choice31-3" name="cate31" value="3"><label for="choice31-3" class="custom-radio"></label>
							<input type="radio" id="choice31-4" name="cate31" value="4"><label for="choice31-4" class="custom-radio"></label>
							<input type="radio" id="choice31-5" name="cate31" value="5"><label for="choice31-5" class="custom-radio"></label>
						</td>
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">32. 다른 사람과 함께 학습하는것을 좋아한다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice32-1" name="cate32" value="1"><label for="choice32-1" class="custom-radio"></label>
							<input type="radio" id="choice32-2" name="cate32" value="2"><label for="choice32-2" class="custom-radio"></label>
							<input type="radio" id="choice32-3" name="cate32" value="3"><label for="choice32-3" class="custom-radio"></label>
							<input type="radio" id="choice32-4" name="cate32" value="4"><label for="choice32-4" class="custom-radio"></label>
							<input type="radio" id="choice32-5" name="cate32" value="5"><label for="choice32-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">33. 수중에 돈이 떨어져서 일자리를 구해야할때 나는 바싹 벌고 나서 일을 그만둘 것이다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice33-1" name="cate33" value="1"><label for="choice33-1" class="custom-radio"></label>
							<input type="radio" id="choice33-2" name="cate33" value="2"><label for="choice33-2" class="custom-radio"></label>
							<input type="radio" id="choice33-3" name="cate33" value="3"><label for="choice33-3" class="custom-radio"></label>
							<input type="radio" id="choice33-4" name="cate33" value="4"><label for="choice33-4" class="custom-radio"></label>
							<input type="radio" id="choice33-5" name="cate33" value="5"><label for="choice33-5" class="custom-radio"></label>
						</td>		
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">34. 오랜 시간 반복적인 작업을 수행할 수 있다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice34-1" name="cate34" value="1"><label for="choice34-1" class="custom-radio"></label>
							<input type="radio" id="choice34-2" name="cate34" value="2"><label for="choice34-2" class="custom-radio"></label>
							<input type="radio" id="choice34-3" name="cate34" value="3"><label for="choice34-3" class="custom-radio"></label>
							<input type="radio" id="choice34-4" name="cate34" value="4"><label for="choice34-4" class="custom-radio"></label>
							<input type="radio" id="choice34-5" name="cate34" value="5"><label for="choice34-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">35. 일의 성과를 바로바로 확인할 수 있는 것을 좋아한다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice35-1" name="cate35" value="1"><label for="choice35-1" class="custom-radio"></label>
							<input type="radio" id="choice35-2" name="cate35" value="2"><label for="choice35-2" class="custom-radio"></label>
							<input type="radio" id="choice35-3" name="cate35" value="3"><label for="choice35-3" class="custom-radio"></label>
							<input type="radio" id="choice35-4" name="cate35" value="4"><label for="choice35-4" class="custom-radio"></label>
							<input type="radio" id="choice35-5" name="cate35" value="5"><label for="choice35-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">36. 몸 쓰는일에 자신이 있다.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">그렇지<br>않다</span></td>
						<td>
							<input type="radio" id="choice36-1" name="cate36" value="1"><label for="choice36-1" class="custom-radio"></label>
							<input type="radio" id="choice36-2" name="cate36" value="2"><label for="choice36-2" class="custom-radio"></label>
							<input type="radio" id="choice36-3" name="cate36" value="3"><label for="choice36-3" class="custom-radio"></label>
							<input type="radio" id="choice36-4" name="cate36" value="4"><label for="choice36-4" class="custom-radio"></label>
							<input type="radio" id="choice36-5" name="cate36" value="5"><label for="choice36-5" class="custom-radio"></label>
						</td>		
						<td><span class="a">그렇다</span></td>
					</tr>
				</table>
			</div>
		</div>
		
	</div>

	
	<div class="bottom">
		<input type="submit" value="결과확인">
	</div>
	</form>
</div>
<script>
    function changeDongGroup() {
        const districtSelect = document.getElementById("district");
        const dongGroup1 = document.getElementById("dongGroup1");
        const dongGroup2 = document.getElementById("dongGroup2");

        if (districtSelect.value === "chungnam_s") {
            dongGroup1.style.display = "block";
            dongGroup2.style.display = "none";
        } else if (districtSelect.value === "chungnam_e") {
            dongGroup1.style.display = "none";
            dongGroup2.style.display = "block";
        }
    }

    // 페이지 로드 시 초기화
    changeDongGroup();
</script>
</body>
</html>

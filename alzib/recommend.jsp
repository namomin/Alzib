<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>�˹���õ</title>
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
		<span><a href="main.jsp">Ȩ</a> > <a href="recommend.jsp">�˹���õ</a></span>
</div>
	<div class="head_wrap">
		<div class="head_title">
			<span id="title">������ �� �´� �˹� ��õ�ޱ�</span><br><br>
			<span>������ �� 36���� �ҿ�ð��� 15�� ����</span><br>
			<span>�ڽſ��� ������ �˹ٸ� ��õ�ޱ� ���ؼ� ���׿� �����ϰ� �亯���ּ���.</span>
		</div>
	</div>	

<form name="recommend" action="recommendResult.jsp" method="post">
	<div class="question_wrap">
		
		<div class="question">
			<span class="q">1. ���� ��� ����?</span><br>
			<div class="choice">
				<table>
					<tr>
						<td>
							<span class="a">
								<select id="area">
									<option value="chungnam">õ��</option>
            					</select>
								<select id="district" onchange="changeDongGroup()">
									<option value="chungnam_s">���ϱ�</option>
									<option value="chungnam_e">������</option>
								</select>
								<select name="Dong">
								<optgroup id="dongGroup1" label="���ϱ�">
									<option value="36.817153,127.114144" style="display:none;"></option>
									<option value="36.817153,127.114144">������</option>
									<option value="36.810065,127.142840">�鼮��</option>
									<option value="36.819352,127.125172">�δ뵿</option>
									<option value="36.814919,127.142734">�Ҵ絿</option>
									<option value="36.792273,127.116334">������</option>
									<option value="36.834647,127.102732">������</option>
									<option value="36.826215,127.136540">������</option>
									<option value="36.768938,127.142470">��ȯ��</option>
									<option value="36.810452,127.111012">�Ŵ絿</option>
									<option value="36.816102,127.125325">�ֿ뵿</option>
									<option value="36.810732,127.123554">������</option>
									<option value="36.827044,127.150050">���̵�</option>
									<option value="36.767202,127.134297">�����</option>
									<option value="36.762238,127.117218">������</option>
									<option value="36.824218,127.115394">���ϵ�</option>
								</optgroup>
								<optgroup id="dongGroup2" label="������">
									<option value="36.805877,127.129896">�ȼ���</option>
									<option value="36.792896,127.154356">����</option>
									<option value="36.789136,127.148836">������</option>
									<option value="36.784649,127.160478">������</option>
									<option value="36.795370,127.138540">���浿</option>
									<option value="36.792008,127.146733">������</option>
									<option value="36.797668,127.136274">��õ��</option>
									<option value="36.797581,127.154657">������</option>
									<option value="36.792647,127.133992">������</option>
									<option value="36.791614,127.140546">���浿</option>
									<option value="36.793220,127.150777">û�絿</option>
									<option value="36.787980,127.150800">û����</option>
									<option value="36.783912,127.143612">ž����</option>
									<option value="36.790595,127.143717">ǳ�</option>
									<option value="36.796632,127.140988">ȣ��</option>
								</optgroup>
								</select>											
							</span>
						</td>
					</tr>
				</table>
			</div>
		</div>

		
		<div class="question">
			<span class="q">2. �ٻڰ� ���ϰ� ���Ѹ�ŭ �޿��� �ް� �ʹ�.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice2-1" name="a1" value="0"><label for="choice2-1" class="custom-radio"></label>
							<input type="radio" id="choice2-2" name="a1" value="1"><label for="choice2-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">3. �޿��� ���������ٸ� �ٺ��� ���� �������� ���� �ڽ��� �ִ�.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice3-1" name="a2" value="0"><label for="choice3-1" class="custom-radio"></label>
							<input type="radio" id="choice3-2" name="a2" value="1"><label for="choice3-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">4. �̵��� �� �������� ���� �Ҹ��ϴ� ���̴�.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice4-1" name="b1" value="0"><label for="choice4-1" class="custom-radio"></label>
							<input type="radio" id="choice4-2" name="b1" value="1"><label for="choice4-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">5. ���ϴ� ���ڸ��� ���߱������� ���� �̵��ؾ��ϴ� ���� ��ġ�� �ִٸ�,<br>���� ���ϴ� ���� �ƴϴ��� ����ó�� ������ �ٴҰ��̴�.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice5-1" name="b2" value="0"><label for="choice5-1" class="custom-radio"></label>
							<input type="radio" id="choice5-2" name="b2" value="1"><label for="choice5-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">6. ������ 3������ ������ �Ÿ��� ������ Ÿ�°� ���� �ɾ�� ����<br>����� �Ƴ��� ��� �Ǳ� ������ �� ��ȣ�Ѵ�.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice6-1" name="b3" value="0"><label for="choice6-1" class="custom-radio"></label>
							<input type="radio" id="choice6-2" name="b3" value="1"><label for="choice6-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">7. ���϶� ���� ȿ���� ����.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice7-1" name="c1" value="0"><label for="choice7-1" class="custom-radio"></label>
							<input type="radio" id="choice7-2" name="c1" value="1"><label for="choice7-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">8. ���Ͽ� ���ϰ� �ָ����� �ڽŸ��� �ð��� �������Ѵٰ� �����Ѵ�.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice8-1" name="c2" value="0"><label for="choice8-1" class="custom-radio"></label>
							<input type="radio" id="choice8-2" name="c2" value="1"><label for="choice8-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">9. ���� �Ͼ�� �Ϸ縦 ������ ������ �ʹ�.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice9-1" name="c3" value="0"><label for="choice9-1" class="custom-radio"></label>
							<input type="radio" id="choice9-2" name="c3" value="1"><label for="choice9-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">10. �Ѱ��� ���� �����ϰ� ���� �� �� �� �ִ�.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice10-1" name="d1" value="0"><label for="choice10-1" class="custom-radio"></label>
							<input type="radio" id="choice10-2" name="d1" value="1"><label for="choice10-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">11. �پ��� ������ �ϴ� ���� ��ȣ�Ѵ�.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice11-1" name="d2" value="0"><label for="choice11-1" class="custom-radio"></label>
							<input type="radio" id="choice11-2" name="d2" value="1"><label for="choice11-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">12. ȯ���� ���� ���ϴ� �ͺ��� �ͼ��� ���� �ִ°��� �� ��ȣ�Ѵ�.</span><br>
			<div class="choice_two">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice12-1" name="d3" value="0"><label for="choice12-1" class="custom-radio"></label>
							<input type="radio" id="choice12-2" name="d3" value="1"><label for="choice12-2" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">13. ��� �پ��� ������ �����ϴ� ���� ��ȣ�ϴ� ���̴�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice13-1" name="cate13" value="1"><label for="choice13-1" class="custom-radio"></label>
							<input type="radio" id="choice13-2" name="cate13" value="2"><label for="choice13-2" class="custom-radio"></label>
							<input type="radio" id="choice13-3" name="cate13" value="3"><label for="choice13-3" class="custom-radio"></label>
							<input type="radio" id="choice13-4" name="cate13" value="4"><label for="choice13-4" class="custom-radio"></label>
							<input type="radio" id="choice13-5" name="cate13" value="5"><label for="choice13-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">14. ������ �д��� ��Ȱ�� �ϴ� ���� ��ȣ�ϴ� ���̴�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice14-1" name="cate14" value="1"><label for="choice14-1" class="custom-radio"></label>
							<input type="radio" id="choice14-2" name="cate14" value="2"><label for="choice14-2" class="custom-radio"></label>
							<input type="radio" id="choice14-3" name="cate14" value="3"><label for="choice14-3" class="custom-radio"></label>
							<input type="radio" id="choice14-4" name="cate14" value="4"><label for="choice14-4" class="custom-radio"></label>
							<input type="radio" id="choice14-5" name="cate14" value="5"><label for="choice14-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">15. ȥ�� ���ϴ� �ͺ��� Ȱ���� ������ �Բ� ���ϴ� ���� �� ����.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice15-1" name="cate15" value="1"><label for="choice15-1" class="custom-radio"></label>
							<input type="radio" id="choice15-2" name="cate15" value="2"><label for="choice15-2" class="custom-radio"></label>
							<input type="radio" id="choice15-3" name="cate15" value="3"><label for="choice15-3" class="custom-radio"></label>
							<input type="radio" id="choice15-4" name="cate15" value="4"><label for="choice15-4" class="custom-radio"></label>
							<input type="radio" id="choice15-5" name="cate15" value="5"><label for="choice15-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">16. ���߻�Ȳ�� �߻��ص� ħ���ϰ� �ٷ� ��ó�� �� �ִ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice16-1" name="cate16" value="1"><label for="choice16-1" class="custom-radio"></label>
							<input type="radio" id="choice16-2" name="cate16" value="2"><label for="choice16-2" class="custom-radio"></label>
							<input type="radio" id="choice16-3" name="cate16" value="3"><label for="choice16-3" class="custom-radio"></label>
							<input type="radio" id="choice16-4" name="cate16" value="4"><label for="choice16-4" class="custom-radio"></label>
							<input type="radio" id="choice16-5" name="cate16" value="5"><label for="choice16-5" class="custom-radio"></label>
						</td>
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">17. ������� �������̴�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice17-1" name="cate17" value="1"><label for="choice17-1" class="custom-radio"></label>
							<input type="radio" id="choice17-2" name="cate17" value="2"><label for="choice17-2" class="custom-radio"></label>
							<input type="radio" id="choice17-3" name="cate17" value="3"><label for="choice17-3" class="custom-radio"></label>
							<input type="radio" id="choice17-4" name="cate17" value="4"><label for="choice17-4" class="custom-radio"></label>
							<input type="radio" id="choice17-5" name="cate17" value="5"><label for="choice17-5" class="custom-radio"></label>
						</td>
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">18. ����տ��� ��ǥ�� �� �� ����ũ ���̵� ū ��Ҹ��� ��ǥ�� �� �ִ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice18-1" name="cate18" value="1"><label for="choice18-1" class="custom-radio"></label>
							<input type="radio" id="choice18-2" name="cate18" value="2"><label for="choice18-2" class="custom-radio"></label>
							<input type="radio" id="choice18-3" name="cate18" value="3"><label for="choice18-3" class="custom-radio"></label>
							<input type="radio" id="choice18-4" name="cate18" value="4"><label for="choice18-4" class="custom-radio"></label>
							<input type="radio" id="choice18-5" name="cate18" value="5"><label for="choice18-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">19. �� ��п� ������� ������ �׻� ģ���� ������ �� �ִ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice19-1" name="cate19" value="1"><label for="choice19-1" class="custom-radio"></label>
							<input type="radio" id="choice19-2" name="cate19" value="2"><label for="choice19-2" class="custom-radio"></label>
							<input type="radio" id="choice19-3" name="cate19" value="3"><label for="choice19-3" class="custom-radio"></label>
							<input type="radio" id="choice19-4" name="cate19" value="4"><label for="choice19-4" class="custom-radio"></label>
							<input type="radio" id="choice19-5" name="cate19" value="5"><label for="choice19-5" class="custom-radio"></label>
						</td>
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">20. ��Ʈ������ �޴� ��Ȳ���� ħ������ ������ �� �ִ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice20-1" name="cate20" value="1"><label for="choice20-1" class="custom-radio"></label>
							<input type="radio" id="choice20-2" name="cate20" value="2"><label for="choice20-2" class="custom-radio"></label>
							<input type="radio" id="choice20-3" name="cate20" value="3"><label for="choice20-3" class="custom-radio"></label>
							<input type="radio" id="choice20-4" name="cate20" value="4"><label for="choice20-4" class="custom-radio"></label>
							<input type="radio" id="choice20-5" name="cate20" value="5"><label for="choice20-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">21. ����ȭ�� ��Ȳ���� ������ ������.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice21-1" name="cate21" value="1"><label for="choice21-1" class="custom-radio"></label>
							<input type="radio" id="choice21-2" name="cate21" value="2"><label for="choice21-2" class="custom-radio"></label>
							<input type="radio" id="choice21-3" name="cate21" value="3"><label for="choice21-3" class="custom-radio"></label>
							<input type="radio" id="choice21-4" name="cate21" value="4"><label for="choice21-4" class="custom-radio"></label>
							<input type="radio" id="choice21-5" name="cate21" value="5"><label for="choice21-5" class="custom-radio"></label>
						</td>		
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">22. ����, �ѱ� ���� �⺻���� �������� ���� �ٷ� �� �ִ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice22-1" name="cate22" value="1"><label for="choice22-1" class="custom-radio"></label>
							<input type="radio" id="choice22-2" name="cate22" value="2"><label for="choice22-2" class="custom-radio"></label>
							<input type="radio" id="choice22-3" name="cate22" value="3"><label for="choice22-3" class="custom-radio"></label>
							<input type="radio" id="choice22-4" name="cate22" value="4"><label for="choice22-4" class="custom-radio"></label>
							<input type="radio" id="choice22-5" name="cate22" value="5"><label for="choice22-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>

			</div>
		</div>
		
		<div class="question">
			<span class="q">23. �۾��� ü��ȭ �ϴ°��� �����Ѵ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice23-1" name="cate23" value="1"><label for="choice23-1" class="custom-radio"></label>
							<input type="radio" id="choice23-2" name="cate23" value="2"><label for="choice23-2" class="custom-radio"></label>
							<input type="radio" id="choice23-3" name="cate23" value="3"><label for="choice23-3" class="custom-radio"></label>
							<input type="radio" id="choice23-4" name="cate23" value="4"><label for="choice23-4" class="custom-radio"></label>
							<input type="radio" id="choice23-5" name="cate23" value="5"><label for="choice23-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>

			</div>
		</div>
		
		<div class="question">
			<span class="q">24. ��ǥ �������� ���� ����� ��ȣ�ϴ� ���̴�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice24-1" name="cate24" value="1"><label for="choice24-1" class="custom-radio"></label>
							<input type="radio" id="choice24-2" name="cate24" value="2"><label for="choice24-2" class="custom-radio"></label>
							<input type="radio" id="choice24-3" name="cate24" value="3"><label for="choice24-3" class="custom-radio"></label>
							<input type="radio" id="choice24-4" name="cate24" value="4"><label for="choice24-4" class="custom-radio"></label>
							<input type="radio" id="choice24-5" name="cate24" value="5"><label for="choice24-5" class="custom-radio"></label>
						</td>		
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>

			</div>
		</div>
		
		<div class="question">
			<span class="q">25. ���ο� ���̵� ������ ���� ����ɷ��� ���� ���̴�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice25-1" name="cate25" value="1"><label for="choice25-1" class="custom-radio"></label>
							<input type="radio" id="choice25-2" name="cate25" value="2"><label for="choice25-2" class="custom-radio"></label>
							<input type="radio" id="choice25-3" name="cate25" value="3"><label for="choice25-3" class="custom-radio"></label>
							<input type="radio" id="choice25-4" name="cate25" value="4"><label for="choice25-4" class="custom-radio"></label>
							<input type="radio" id="choice25-5" name="cate25" value="5"><label for="choice25-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>

			</div>
		</div>
		
		<div class="question">
			<span class="q">26. ���� �����ϴ� ���� �����Ѵ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice26-1" name="cate26" value="1"><label for="choice26-1" class="custom-radio"></label>
							<input type="radio" id="choice26-2" name="cate26" value="2"><label for="choice26-2" class="custom-radio"></label>
							<input type="radio" id="choice26-3" name="cate26" value="3"><label for="choice26-3" class="custom-radio"></label>
							<input type="radio" id="choice26-4" name="cate26" value="4"><label for="choice26-4" class="custom-radio"></label>
							<input type="radio" id="choice26-5" name="cate26" value="5"><label for="choice26-5" class="custom-radio"></label>
						</td>			
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">27. �������� �ɷ��� ������ �ִ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice27-1" name="cate27" value="1"><label for="choice27-1" class="custom-radio"></label>
							<input type="radio" id="choice27-2" name="cate27" value="2"><label for="choice27-2" class="custom-radio"></label>
							<input type="radio" id="choice27-3" name="cate27" value="3"><label for="choice27-3" class="custom-radio"></label>
							<input type="radio" id="choice27-4" name="cate27" value="4"><label for="choice27-4" class="custom-radio"></label>
							<input type="radio" id="choice27-5" name="cate27" value="5"><label for="choice27-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">28. �ٸ� ����� �ൿ�� �̲��� �����ϴ� Ȱ���� ��ȣ�ϴ� ���̴�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice28-1" name="cate28" value="1"><label for="choice28-1" class="custom-radio"></label>
							<input type="radio" id="choice28-2" name="cate28" value="2"><label for="choice28-2" class="custom-radio"></label>
							<input type="radio" id="choice28-3" name="cate28" value="3"><label for="choice28-3" class="custom-radio"></label>
							<input type="radio" id="choice28-4" name="cate28" value="4"><label for="choice28-4" class="custom-radio"></label>
							<input type="radio" id="choice28-5" name="cate28" value="5"><label for="choice28-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">29. �ֵ������� ������ �̲� �� �ִ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice29-1" name="cate29" value="1"><label for="choice29-1" class="custom-radio"></label>
							<input type="radio" id="choice29-2" name="cate29" value="2"><label for="choice29-2" class="custom-radio"></label>
							<input type="radio" id="choice29-3" name="cate29" value="3"><label for="choice29-3" class="custom-radio"></label>
							<input type="radio" id="choice29-4" name="cate29" value="4"><label for="choice29-4" class="custom-radio"></label>
							<input type="radio" id="choice29-5" name="cate29" value="5"><label for="choice29-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">30. ������� �ִ� �ǻ�ǥ���� �̿��ؼ� �ٸ�������� ��ȭ�� �̲��� �� �� �ִ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice30-1" name="cate30" value="1"><label for="choice30-1" class="custom-radio"></label>
							<input type="radio" id="choice30-2" name="cate30" value="2"><label for="choice30-2" class="custom-radio"></label>
							<input type="radio" id="choice30-3" name="cate30" value="3"><label for="choice30-3" class="custom-radio"></label>
							<input type="radio" id="choice30-4" name="cate30" value="4"><label for="choice30-4" class="custom-radio"></label>
							<input type="radio" id="choice30-5" name="cate30" value="5"><label for="choice30-5" class="custom-radio"></label>
						</td>		
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">31. ���� ���� ������ ������ �����ϴ� ���� ���Ѵ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice31-1" name="cate31" value="1"><label for="choice31-1" class="custom-radio"></label>
							<input type="radio" id="choice31-2" name="cate31" value="2"><label for="choice31-2" class="custom-radio"></label>
							<input type="radio" id="choice31-3" name="cate31" value="3"><label for="choice31-3" class="custom-radio"></label>
							<input type="radio" id="choice31-4" name="cate31" value="4"><label for="choice31-4" class="custom-radio"></label>
							<input type="radio" id="choice31-5" name="cate31" value="5"><label for="choice31-5" class="custom-radio"></label>
						</td>
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">32. �ٸ� ����� �Բ� �н��ϴ°��� �����Ѵ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice32-1" name="cate32" value="1"><label for="choice32-1" class="custom-radio"></label>
							<input type="radio" id="choice32-2" name="cate32" value="2"><label for="choice32-2" class="custom-radio"></label>
							<input type="radio" id="choice32-3" name="cate32" value="3"><label for="choice32-3" class="custom-radio"></label>
							<input type="radio" id="choice32-4" name="cate32" value="4"><label for="choice32-4" class="custom-radio"></label>
							<input type="radio" id="choice32-5" name="cate32" value="5"><label for="choice32-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">33. ���߿� ���� �������� ���ڸ��� ���ؾ��Ҷ� ���� �ٽ� ���� ���� ���� �׸��� ���̴�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice33-1" name="cate33" value="1"><label for="choice33-1" class="custom-radio"></label>
							<input type="radio" id="choice33-2" name="cate33" value="2"><label for="choice33-2" class="custom-radio"></label>
							<input type="radio" id="choice33-3" name="cate33" value="3"><label for="choice33-3" class="custom-radio"></label>
							<input type="radio" id="choice33-4" name="cate33" value="4"><label for="choice33-4" class="custom-radio"></label>
							<input type="radio" id="choice33-5" name="cate33" value="5"><label for="choice33-5" class="custom-radio"></label>
						</td>		
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">34. ���� �ð� �ݺ����� �۾��� ������ �� �ִ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice34-1" name="cate34" value="1"><label for="choice34-1" class="custom-radio"></label>
							<input type="radio" id="choice34-2" name="cate34" value="2"><label for="choice34-2" class="custom-radio"></label>
							<input type="radio" id="choice34-3" name="cate34" value="3"><label for="choice34-3" class="custom-radio"></label>
							<input type="radio" id="choice34-4" name="cate34" value="4"><label for="choice34-4" class="custom-radio"></label>
							<input type="radio" id="choice34-5" name="cate34" value="5"><label for="choice34-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">35. ���� ������ �ٷιٷ� Ȯ���� �� �ִ� ���� �����Ѵ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice35-1" name="cate35" value="1"><label for="choice35-1" class="custom-radio"></label>
							<input type="radio" id="choice35-2" name="cate35" value="2"><label for="choice35-2" class="custom-radio"></label>
							<input type="radio" id="choice35-3" name="cate35" value="3"><label for="choice35-3" class="custom-radio"></label>
							<input type="radio" id="choice35-4" name="cate35" value="4"><label for="choice35-4" class="custom-radio"></label>
							<input type="radio" id="choice35-5" name="cate35" value="5"><label for="choice35-5" class="custom-radio"></label>
						</td>	
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="question">
			<span class="q">36. �� �����Ͽ� �ڽ��� �ִ�.</span><br>
			<div class="choice">
				<table>
					<tr>
						<td><span class="a">�׷���<br>�ʴ�</span></td>
						<td>
							<input type="radio" id="choice36-1" name="cate36" value="1"><label for="choice36-1" class="custom-radio"></label>
							<input type="radio" id="choice36-2" name="cate36" value="2"><label for="choice36-2" class="custom-radio"></label>
							<input type="radio" id="choice36-3" name="cate36" value="3"><label for="choice36-3" class="custom-radio"></label>
							<input type="radio" id="choice36-4" name="cate36" value="4"><label for="choice36-4" class="custom-radio"></label>
							<input type="radio" id="choice36-5" name="cate36" value="5"><label for="choice36-5" class="custom-radio"></label>
						</td>		
						<td><span class="a">�׷���</span></td>
					</tr>
				</table>
			</div>
		</div>
		
	</div>

	
	<div class="bottom">
		<input type="submit" value="���Ȯ��">
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

    // ������ �ε� �� �ʱ�ȭ
    changeDongGroup();
</script>
</body>
</html>

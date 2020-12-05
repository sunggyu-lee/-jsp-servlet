<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스탭관리</title>
</head>
<body>
<table style='border:1px solid green'>
<tr>
   <td style='border:1px solid green'>
      <select id=selStaff size=20 style='width:300px'></select>
   </td>
   <td style='border:1px solid green' valign=top>
      <table>
      <input type=hidden id=crup size=30>
      <tr height=40px>
         <td>이름:&nbsp;<input type=text id=txtnick size=30></td>
      </tr>
      <tr height=40px>
         <td>모바일:&nbsp;<input type=text id=txtmobile size=20></td>
      </tr>
      <tr height=40px>
         <td>성별:&nbsp;<input type=radio id=female name=gender>여성
            <input type=radio id=male name=gender>남성
      </tr>
      <tr height=40px>
         <td><input type=button id=btnInsert value='등록'>&nbsp;
            <input type=button id=btnDelete value='삭제'>&nbsp;
            <input type=button id=btnReset value='비우기'>
      </tr>
      </table>
   </td>
</tr>
</table>
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.ready(function(){//페이지 로딩시 (저장된 스태프 목록들을 불러옴)
	$.get('staffSelect',{},function(data){
    	ti='<option value=no>닉네임 | 모바일번호 | 성별</option>';
        $('#selStaff').prepend(ti);
    	$.each(data,function(ndx,value){
            name='<option value='+value["staffid"]+'>'+value["nick"]+' | '+value["mobile"]+
            ' | '+value["gender"]+'</option>';
             $('#selStaff').append(name);
       })
	},'json')
	$('#crup').val("cr")
	return false
})

.on('click','#btnInsert',function(){//등록버튼 눌렀을 때
	if($("#txtnick").val()==""){//이름 빈칸 여부 체크
		alert('이름은 필수로 입력해야합니다.')
		$("#txtnick").focus()
		return false
	}
	if($("#txtmobile").val()==""){//모바일 빈칸 여부 체크
		alert('모바일번호는 필수로 입력해야합니다.')
		$("#txtmobile").focus()
		return false
	}
	if($("#female").prop('checked')==false && $("#male").prop('checked')==false){//성별 미선택 여부 체크
		alert('성별을 선택하세요')
		return false
	}
	if($('#crup').val()=='cr'){//cr이면 등록
		result = confirm('스태프를 추가 하시겠습니까?')
		if(result){//예 눌렀을때
			if($("#female").prop('checked')==true){//여자면 F로 남자면 M으로 변환하기
				gen="F"
			}else{
				gen="M"
			}
			$.get('staffInsert',{nick:$("#txtnick").val(),mobile:$('#txtmobile').val(),gender:gen},'json')
			alert('스태프가 추가되었습니다.')
			location.reload();
			return false
		}else{//아니오 눌렀을때
			alert('취소하였습니다.')
			$("#btnReset").trigger('click')
			return false
		}
	}else{//up면 수정
		result = confirm('스태프정보를 수정 하시겠습니까?')
		if(result){//예 눌렀을시
			//gender=$('input:radio[name=gender]:checked').attr('id')
			//gender=substr(0,1)
			if($("#female").prop('checked')==true){//여자면 F로 남자면 M으로 변환하기
				gen="F"
			}else{
				gen="M"
			}
			$.get('staffUpdate',{nick:$("#txtnick").val(),mobile:$('#txtmobile').val(),
				  gender:gen,staffid:$('#selStaff option:checked').val()},'json')
			alert('스태프정보가 수정되었습니다.')
			location.reload();
			return false
		}else{//아니오 눌렀을때
			alert('취소하였습니다.')
			$("#btnReset").trigger('click')
			return false
		}
	}
})

.on('click','#btnDelete',function(){//삭제버튼 클릭했을때
	if($("#txtnick").val()==""){//이름 빈칸 여부 체크
		alert('이름은 필수로 입력해야합니다.')
		$("#txtnick").focus()
		return false
	}
	if($("#txtmobile").val()==""){//모바일 빈칸 여부 체크
		alert('모바일번호는 필수로 입력해야합니다.')
		$("#txtmobile").focus()
		return false
	}
	if($("#female").prop('checked')==false && $("#male").prop('checked')==false){//성별 미선택 여부 체크
		alert('성별을 선택하세요')
		return false
	}
	result = confirm('스태프정보를 삭제 하시겠습니까?')
	if(result){//예 눌렀을시
		$.get('staffDelete',{staffid:$('#selStaff option:checked').val()},'json')
		alert('스태프정보가 삭제되었습니다.')
		location.reload();
		return false
	}else{//아니오 눌렀을시
		alert('취소하였습니다.')
		$("#btnReset").trigger('click')
		return false
	}
})

.on('click','#selStaff',function(){//스태프 목록을 클릭했을때
	console.log($('#selStaff option:checked').val())
	
	if($('#selStaff option:checked').val()!="no" && $('#selStaff option:checked').val()!=""){
		$('#crup').val("up")
		a=$('#selStaff option:checked').text();
		ar=a.split(' | ');
		sName=(ar[0])
		$('#txtnick').val(ar[0])
		$('#txtmobile').val(ar[1])
		if(ar[2]=="F"){
			$("#female").prop('checked',true)
		}else{
			$("#male").prop('checked',true)
		}
		return false
	}else{
		$("#btnReset").trigger('click')
	}
})

.on('click','#btnReset',function(){//비우기 버튼 클릭시 작동
	$('#txtnick').val("")
	$('#txtmobile').val("")
	$("input[name=gender]").prop('checked',false)
	$('#crup').val("cr")
	return false
})
</script>
</html>
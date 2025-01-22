//////////////////////////insert_boss & alba//////////////////////////

function checkID() {
  var BId = insert_boss.BId.value;

  if (BId == "") {
    alert("아이디를 입력해 주세요");
    insert_boss.BId.focus();
    return;
  }

  window.open("CheckId.jsp?BId=" + BId, "win", "width=255, height=145, scrollbars=no, resizable=no");
}

function checkID() {
  var AId = insert_alba.AId.value;

  if (AId == "") {
    alert("아이디를 입력해 주세요");
    insert_alba.AId.focus();
    return;
  }

  window.open("CheckId.jsp?AId=" + AId, "win", "width=255, height=145, scrollbars=no, resizable=no");
}



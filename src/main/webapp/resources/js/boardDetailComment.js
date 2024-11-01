 console.log("boardDetailComment.js in");
 console.log("vscode 연동 성공");

 document.getElementById('cmtAddBtn').addEventListener('click', ()=>{
    const cmtText = document.getElementById('cmtText');
    const cmtWriter = document.getElementById('cmtWriter');

    if(cmtText.value == null || cmtText.value == ''){
        alert('댓글을 입력해 주세요.');
        cmtText.focus(); // cmtText로 커서를 옮겨줌. value한테 포커스를 줄 수 없고 객체한테 줌.
        return false;
    }
    let cmtData = {
        bno: bnoVal,
        writer: cmtWriter.innerText,
        content: cmtText.value
    }
    console.log(cmtData);
    postCommentToServer(cmtData).then(result=>{
        if(result == '1'){
            alert("댓글 등록 성공")
            cmtText.value="";
            // 댓글 뿌리기
            spreadCommentList(bnoVal);
        }
    })

 });

 function spreadCommentList(bno, page=1){
    getCommentListFromServer(bno, page).then(result =>{
        console.log("ph>",result);
            // 댓글 뿌리기
        const ul = document.getElementById('cmtListArea');
        if(result.cmtList.length > 0){
            if(page == 1){
                ul.innerHTML=""; // 반복 전에 기존 샘플 버리기 (더보기 버튼에 의한 누적 불가능)
            }
            for(let cvo of result.cmtList){
                let li = `<li class="list-group-item" data-cno=${cvo.cno}>`;
                li += `<div class="ms-2 me-auto">`;
                li += `<div class="fw-bold">${cvo.writer}</div>`;
                li += `${cvo.content}</div>`;
                li += `<span class="badge text-bg-primary rounded-pill">${cvo.regDate}</span>`;
                //수정 삭제 버튼 추가
                li += `<button type="button" data-cno=${cvo.cno} class="btn btn-outline-warning btn-sm mod" data-bs-toggle="modal" data-bs-target="#myModal">%</button>`;
                li += `<button type="button" data-cno=${cvo.cno} class="btn btn-outline-danger btn-sm del">X</button>`;
                li += `</li>`;
                ul.innerHTML += li; 
            }
            // 더보기 버튼 코드
            let moreBtn = document.getElementById("moreBtn");
            // 더보기 버튼이 표시되는 조건
            // result = ph > pgvo > pageNo = 1 / realEndPage = 2  현재 내 페이지보다 리얼엔드페이지(전체 페이지)가 더 뒤에 있다면(더 많다면) 버튼을 표시.
            if(result.pgvo.pageNo < result.realEndPage){
                // style.visibility = "hidden":숨김 / "visible" : 표시
                moreBtn.style.visibility = "visible"; // 버튼 표시
                moreBtn.dataset.page = page+1; // 1페이지 증가
            }else{
                // 현재 페이지가 전체보다 작지 않다면.. 같거나 크다면...
                moreBtn.style.visibility = "hidden"; // 숨김
            }

        }else{
            ul.innerHTML = `<div class="list-group-item">Comment List Empty</div>`
        }
    })
 }

//수정 삭제
document.addEventListener('click', (e)=>{
    // console.log(e.target);
    //내가 클릭한 버튼의 객체를 모달창으로 전달
    if(e.target.classList.contains('mod')){
        // 내가 클릭한 버튼의 li 가져오기
        // closest : 가장 가까운(나를 포함한) 태그 (부모태그)
        let li = e.target.closest('li');
        //console.log(li);
        //nextSibling : 한 부모 안에서의 다음 형제 값 찾기 
        let cmtText = li.querySelector('.fw-bold').nextSibling;
        console.log(cmtText);
        document.getElementById('cmtTextMod').value = cmtText.nodeValue;
        let cno = li.dataset.cno;
        let cmtWriter = li.querySelector('.fw-bold').innerText;
        document.getElementById('cmtWriterMod').innerHTML = `no.${cno}  <b>${cmtWriter}</b>`;
        //cmtModBtn =>  cno 값을 dataset으로 달기
        document.getElementById('cmtModBtn').setAttribute("data-cno", cno);

    }

    if(e.target.id == 'cmtModBtn'){
        let cmtData = {
            cno: e.target.dataset.cno,
            content: document.getElementById('cmtTextMod').value
        };
        console.log(cmtData);
        updateCommentToServer(cmtData).then(result=>{
            if(result == '1'){
                alert("댓글 수정 성공");
            }else{
                alert("댓글 수정 실패")
            }
            //모달창 닫기 : btn-close라는 객체를 클릭해라
            document.querySelector('.btn-close').click();
            // 댓글 뿌리기
            spreadCommentList(bnoVal);
        })
    }

    if(e.target.classList.contains('del')){
        // cno만 있으면 됨.
        let li = e.target.closest('li');
        let cno = li.dataset.cno;

        removeCommentToServer(cno).then(result =>{
            if(result == '1'){
                alert("댓글 삭제 성공");
            }else{
                alert("댓글 삭제 실패")
            }
            // 댓글 뿌리기
            spreadCommentList(bnoVal);
        })
    }

    if(e.target.id == 'moreBtn'){
        let page = parseInt(e.target.dataset.page);
        spreadCommentList(bnoVal, page); 
    }

})



async function updateCommentToServer(cmtData) {
    try {
        const url = "/comment/modify";
        const config={
            method: "put",
            headers:{
                'Content-type': 'application/json; charset=utf-8'
            },
            body: JSON.stringify(cmtData)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();   //isOk
        return result;
    } catch (error) {
        console.log(error);
    }
}

//delete메서드 사용
async function removeCommentToServer(cno) {
    try {
        const url = "/comment/"+cno;
        const config = {
            method: 'delete'
        }
        const resp = await fetch(url, config);
        // const resp = await fetch("/comment/"+cno, {method:'delete'});
        const result = await resp.text();   //isOk
        return result;

    } catch (error) {
        console.log(error);
    }
}

//get메서드는 생략가능. 
async function getCommentListFromServer(bno, page) {
    try {
        const resp = await fetch("/comment/"+bno+"/"+page);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

 async function postCommentToServer(cmtData) {
    try {
        const url = "/comment/post";
        const config = {
            method : "post",
            headers:{
                'Content-type': 'application/json; charset=utf-8'
            },
            body: JSON.stringify(cmtData)
        };
        const resp = await fetch(url, config);
        console.log(resp);
        const result = await resp.text(); // isOk
        return result;
    } catch (error) {
        console.log(error);
    }
 }


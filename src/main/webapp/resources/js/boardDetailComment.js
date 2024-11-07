console.log("boardDetailComment.js in");
console.log("vscode 연동 성공");

document.getElementById('cmtAddBtn').addEventListener('click',()=>{
    const cmtText = document.getElementById('cmtText');
    const cmtWriter = document.getElementById('cmtWriter');

    if(cmtText.value == null || cmtText.value == ''){
        alert('댓글을 입력해 주세요.');
        cmtText.focus();
        return false;
    }
    let cmtData = {
        bno : bnoVal,
        writer : cmtWriter.value,
        content : cmtText.value
    }
    console.log(cmtData);
    postCommentToServer(cmtData).then(result =>{
        if(result == '1'){
            alert("댓글 등록 성공");
            cmtText.value="";
            //댓글 뿌리기
        }
    })
})

function spreadCommentList(bno){
    getCommentListFromServer(bno).then(result =>{
        // 댓글 뿌리기
        const ul = document.getElementById('cmtListArea');
        if(result.length > 0){
            ul.innerHTML="";
            for(let cvo of result){
                let li = `<li class="list-group-item" data-cno=${cvo.cno}>`;
                li += `<div class="ms-2 me-auto">`;
                li += `<div class="fw-bold">${cvo.writer}</div>`;
                li += `${cvo.content}`;
                li += `</div>`;
                li += `<span class="badge text-bg-primary rounded-pill">${cvo.regDate}</span>`;
                li += `</li>`;
                ul.innerHTML += li;
            }
        }else{
            ul.innerHTML = `<li class="list-group-item">Comment List Empty</li>`;
        }
    })
}

async function getCommentListFromServer(bno) {
    try {
        const resp = await fetch("/comment/" + bno);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

async function postCommentToServer(cmtData){
    try {
        const url = "/comment/post";
        const config = {
            method: "post",
            headers:{
                'Content-Type':'application/json; charset=utf-8'
            },
            body: JSON.stringify(cmtData)
        };
        const resp = await fetch(url, config);
        console.log(resp);
        const result = await resp.text();   // isOk
        return result;
    } catch (error) {
        console.log(error);
    }
}
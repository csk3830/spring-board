console.log("boardModify.js in!!!!")

//파일 삭제
document.addEventListener('click', (e)=>{
    if(e.target.classList.contains('file-x')){
        let uuid = e.target.dataset.uuid; 

        removeFileToServer(uuid).then(result =>{
            if(result == '1'){
                e.target.closest('li').remove();
                alert("파일 삭제 성공");
            } else{
                alert("파일 삭제 실패");
            }
        })
    }
})



//delete메서드 사용
async function removeFileToServer(uuid) {
    try {
        const url = "/board/file/"+uuid;
        const config = {
            method: 'delete'
        }
        const resp = await fetch(url, config);
        const result = await resp.text();   //isOk
        return result;

    } catch (error) {
        console.log(error);
    }
}
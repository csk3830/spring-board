# SPRING BOARD

이 프로젝트는 **Spring**, **MySQL**, **javaScript** 등을 사용하여 구축된 게시판 시스템입니다. 기본적인 게시판 CRUD 기능과 댓글 및 첨부파일 업로드, 로그인 및 관리자 페이지 기능을 제공합니다.

## 주요 기능

- **게시판 CRUD**: 게시글을 작성, 조회, 수정, 삭제할 수 있습니다.
  - 게시글은 작성자만 수정/삭제할 수 있습니다.
- **게시글 검색**: 게시글 제목, 내용, 작성자 등으로 게시글을 검색할 수 있습니다.
- **첨부파일 업로드**: 게시글 작성 시 파일을 첨부하고, 업로드된 파일을 다운로드할 수 있습니다.
  - 파일 크기 제한: 20MB
  - 파일 갯수 제한: 3개
  - 지원 파일 형식: `.exe`, `.jar`, `.msi`, `.dll`, `.sh`, `.bat`을 제외한 모든 파일
- **댓글 CRUD**: 게시글에 댓글을 작성하고, 수정 및 삭제할 수 있습니다. 
  - 댓글은 작성자만 수정/삭제할 수 있습니다.
- **사용자 로그인 및 권한 관리**: **Spring Security**를 이용한 로그인 및 사용자 인증, 역할 기반 권한 부여.
  - **비회원**: 게시글 조회
  - **일반 회원**: 게시글 및 댓글 작성/조회, 회원 정보 수정
  - **관리자**: 게시글 및 댓글 작성/조회, 회원 정보 수정, 회원 리스트 조회
- **관리자 페이지**: 관리자는 회원 리스트 조회가 가능합니다.

## 기술 스택

- **Frontend**: JSP, CSS, javaScript, Bootstrap
- **Backend**: Spring Framework, MySQL, MyBatis

![SpringBoard](https://github.com/user-attachments/assets/47a44ce3-4692-49e2-a43d-d8eed7526822)

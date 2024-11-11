package com.ezen.spring.handler;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.tika.Tika;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.ezen.spring.domain.FileVO;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@Component
public class FileHandler {
	
	// 저장 경로
	private final String UP_DIR = "D:\\_myProject\\_java\\_fileUpload";
	
	public List<FileVO> uploadFiles(MultipartFile[] files){
		
		List<FileVO> flist = new ArrayList<>();
		LocalDate date = LocalDate.now();
		log.info(">>>> date >>{}", date.toString());
		String today = date.toString();
		today = today.replace("-", File.separator); // 2024\11\01  win(\)  mac(/)
		
		//D:\\_myProject\\_java\\_fileUpload\\2024\\11\\01
		File folders = new File(UP_DIR, today);
		
		//폴더 생성(있으면 생성안함.) : mkdir (1개만 생성)  mkdirs(하위폴더까지 생성)
		if(!folders.exists()) {
			folders.mkdirs();
		}
		
		//files 를 가지고 flist 생성
		for(MultipartFile file : files) {
			FileVO fvo = new FileVO();
			fvo.setSaveDir(today);  // 2024\\11\\01
			fvo.setFileSize(file.getSize());
			//String fileName = file.getOriginalFilename();
			//경로를 포함하는 이름이라면...
			String fileName = file.getOriginalFilename().substring(
					file.getOriginalFilename().lastIndexOf(File.separator)+1);
			log.info("fileName {}", fileName);
			fvo.setFileName(fileName);
			
			UUID uuid = UUID.randomUUID();
			String uuidStr = uuid.toString();
			fvo.setUuid(uuidStr);
			
			//---- fvo 생성완료  > bno / file_type(File 객체로 전달해야 해서 저장 후 확인)
			// 디스크에 저장 => 저장할 객체(File)를 생성 > 저장
			String fullFileName = uuidStr+"_"+fileName;
			File storeFile = new File(folders, fullFileName);

			try {
				file.transferTo(storeFile); //저장
				//썸네일 저장 => 이미지만 가능
				//이미지인지 확인
				if(isImageFile(storeFile)) {
					fvo.setFileType(1);  //이미지 파일만 1
					//썸네일 생성
					File thumbNail = new File(folders, uuidStr+"_th_"+fileName);
					Thumbnails.of(storeFile).size(100, 100).toFile(thumbNail);
				}
				
			} catch (Exception e) {
				log.info("파일 저장 오류");
				e.printStackTrace();
			}
			
			//for문 안에 있어야 함.
			flist.add(fvo);
		}
		
		
		return flist;
	}
	
	private boolean isImageFile(File storeFile) throws IOException {
		String mimeType = new Tika().detect(storeFile); //  file의 내부요소 type "image/jpeg"
		return mimeType.startsWith("image") ? true : false;
	}
}

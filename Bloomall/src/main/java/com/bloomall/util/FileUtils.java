package com.bloomall.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;

public class FileUtils {
	
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception{
		
		System.out.println("=====uploadFile() called=====");
		
		// 파일명 설정 (uuid_파일명)
		UUID uuid = UUID.randomUUID();	// 파일명 중복 방지
		String savedName = uuid.toString() + "_" + originalName;
		
		// 파일 경로 (날짜경로) - ex) \\2020\\10
		String savedPath = calcPath(uploadPath);
		
		// 설정정보를 바탕으로 빈 파일 생성
		File target = new File(uploadPath + savedPath, savedName);
		
		// 만든 파일에 데이터 사용
		FileCopyUtils.copy(fileData, target);
		
		// 확장자명 가져오기
		String formatName = originalName.substring(originalName.lastIndexOf(".")+ 1);
		String uploadFileName = null;
		
		// 이미지파일인지 일반파일인지 구분확인
		// 이미지 파일일 경우, 썸네일 생성
		if(MediaUtils.getMediaType(formatName) != null) {
			uploadFileName = makeThumbNail(uploadPath, savedPath, savedName);
		}else {
		// 일반 파일일 경우, 아이콘 생성
			uploadFileName = makeIcon(uploadPath, savedPath, savedName);
		}
		
		return uploadFileName;
	}

	// 날짜 폴더 경로 설정
	/*
	 * @Params
	 * uploadPath : 기본 파일 업로드 경로
	 * 
	 * @return
	 * String : 생성된 날짜 폴더 경로(예 - \\2020\\10)
	 */
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		
		/* 날짜 경로 : 년/월/일 형태 */
		// 년
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		// 년 + 월
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
//		// 년 + 월 + 일
//		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
//		System.out.println("=====calcPath() result : " + datePath + "=====");
		System.out.println("=====calcPath() result : " + monthPath + "=====");
		
		// 경로별 모든 폴더 생성
//		makeDir(uploadPath, yearPath, monthPath, datePath);
		
		// 연도+월 폴더만 생성
		makeDir(uploadPath, yearPath, monthPath);
		
		return monthPath;
	}
	
	// 날짜 폴더 생성
	/*
	 * 가변 매개변수 활용
	 * 
	 * String uploadPath	: 기본파일 업로드 폴더 경로
	 * String... paths		: 생성할 폴더 경로들
	 */
	private static void makeDir(String uploadPath, String... paths) {
		// 마지막 매개변수 폴더의 존재여부 확인 - 존재하면 return
		if(new File(paths[paths.length - 1]).exists()) {
			return;
		}
		
		// 매개변수로 들어온 경로의 모든 폴더 생성
		for(String path: paths) {
			File dirPath = new File(uploadPath + path);
			// 해당 폴더가 존재하지 않을 경우,
			if(!dirPath.exists()) {
				// 폴더 생성
				dirPath.mkdir();
			}
		}
	}

	// 썸네일 생성 - 이미지 파일
	/*
	 * String uploadPath	: 기본 파일 업로드 경로
	 * String path			: 날짜 경로
	 * String fileName		: UUID_originalName
	 * 
	 * @return
	 * String : 날짜 경로 + s_ + fileName
	 * ex) \\2020\\10\\uuid_s_fileName
	 * 
	 */
	private static String makeThumbNail(String uploadPath, String path, String fileName) throws Exception {
		
		BufferedImage sourceImage = ImageIO.read(new File(uploadPath + path, fileName));
		// 썸네일 높이 80px, 너비 맞춤
		BufferedImage destImage = Scalr.resize(sourceImage, 110, 150);
		
		// 썸네일 생성 준비
		String thumbNailName = uploadPath + path + File.separator + "s_" + fileName;
		File newFile = new File(thumbNailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		
		// 썸네일 생성
		ImageIO.write(destImage, formatName.toUpperCase(), newFile);

		// 생성된 썸네일 경로의 subString 반환
		System.out.println("=====makeThumNail() thumbNail : " + thumbNailName + "=====");
		
		return thumbNailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	// 아이콘 생성 - 일반파일
	/*
	 * String uploadPath	: 기본 파일 업로드 경로
	 * String path			: 날짜 경로
	 * String fileName		: UUID_originalName
	 * 
	 * @return
	 * String : 날짜 경로 + fileName
	 * ex) \\2020\\10\\03\\uuid_fileName
	 * 
	 */
	private static String makeIcon(String uploadPath, String path, String fileName) {
		
		String iconName = uploadPath + path + File.separator + fileName;
		
		// 생성된 아이콘 경로의 subString 반환
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}


	// 파일 가져오기 - 웹프로젝트 외부영역에서 파일을 가져와 ResponseEntity로 변환
	/*
	 * String uploadPath	: 외부 폴더 업로드 경로
	 * String fileName		: 가져오는 파일명
	 * 
	 * ResponseEntity<byte[]> : 가져온 파일정보와 HTTP 상태코드 리턴
	 * 
	 */
	public static ResponseEntity<byte[]> getFile(String uploadPath, String fileName) throws Exception{
		
		InputStream input = null;
		byte[] fileData = null;
		ResponseEntity<byte[]> entity = null;
		
		try {
			// 파일의 확장자로 파일의 종류 확인
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			// 파일명이 이미지 파일 종류인지 체크
			MediaType type = MediaUtils.getMediaType(formatName);
			
			// 파일 헤더 설정
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(type);
			
			// 파일 가져오기
			input = new FileInputStream(uploadPath + fileName);
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(input), headers, HttpStatus.OK);
			
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			input.close();
		}
		
		return entity;
	}


	// 이미지 파일 삭제
	/*
	 * String uploadPath	: 파일 경로
	 * String fileName		: 삭제할 파일명
	 * 
	 */
	public static void deleteFile(String uploadPath, String fileName) {
		
		// 날짜경로 + UUID_fileName
		String front = fileName.substring(0, 9);	// 날짜 경로
		String end = fileName.substring(11);		// UUID_fileName
		String original = front + end;
		
		// 원본 파일 삭제
		new File(uploadPath + original.replace('/', File.separatorChar)).delete();
		// 썸네일 파일 삭제
		new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
	}


	/* 썸네일 파일명 => 원본 파일명
	 * ex) /2020/10/s_UUID파일명 -> /2020/10/UUID파일명
	 */
	public static String thumbToOriginalName(String thumbNailName) {
		
		String front = thumbNailName.substring(0, 9);	// 날짜 경로
		String end = thumbNailName.substring(11);		// UUID_fileName
				
		return front + end;
	}

}

package com.example.demo.dao;

import java.util.List;

import com.example.demo.vo.Pic_BoardVo;
import com.example.demo.vo.Pic_Board_FileVo;

public interface M_PicboardDao {
	
//	픽보드 리스트 
	List<Pic_BoardVo> picboaard_list();

//	픽보드파일 리스트
	List<Pic_Board_FileVo> picboardfile_list();
}

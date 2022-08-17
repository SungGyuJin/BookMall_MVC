package com.mine.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.mine.mapper.AdminMapper;
import com.mine.model.AttachImageVO;

import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class AttachFileCheckTask {

	@Autowired
	private AdminMapper mapper;
	
	private String getFolderYesterDay() {
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			Calendar cal = Calendar.getInstance();
			
			cal.add(Calendar.DATE, -1);
			
			String str = sdf.format(cal.getTime());
			
			return str.replace("-", File.separator);
			
	}
	
}

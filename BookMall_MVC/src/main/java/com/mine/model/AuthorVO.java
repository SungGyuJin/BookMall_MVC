package com.mine.model;

import java.sql.Date;

public class AuthorVO {

	// 작가 아이디
	private int authorId;

	// 작가이름
	private String authorName;

	// 국가 id
	private String nationId;

	// 작가 국가
	private String nationName;

	// 작가 소개
	private String authorIntro;

	// 등록날짜
	private Date regDate;

	// 수정날짜
	private Date updateDate;

	public int getAuthorId() {
		return authorId;
	}

	public void setAuthorId(int authorId) {
		this.authorId = authorId;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public String getNationId() {
		return nationId;
	}

	public void setNationId(String nationId) {
		this.nationId = nationId;

		if (nationId.equals("01")) {
			this.nationName = "국내";
		} else {
			this.nationName = "국외";
		}
	}

	public String getNationName() {
		return nationName;
	}

	public void setNationName(String nationName) {
		this.nationName = nationName;
	}

	public String getAuthorIntro() {
		return authorIntro;
	}

	public void setAuthorIntro(String authorIntro) {
		this.authorIntro = authorIntro;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

}

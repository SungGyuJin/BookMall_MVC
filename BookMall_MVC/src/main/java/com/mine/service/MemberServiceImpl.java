package com.mine.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mine.mapper.MemberMapper;
import com.mine.model.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberMapper membermapper;

	@Override
	public void memberJoin(MemberVO member) throws Exception {

		membermapper.memberJoin(member);
	}

	@Override
	public int idCheck(String memberId) throws Exception {

		return membermapper.idCheck(memberId);
	}

	@Override
	public MemberVO memberLogin(MemberVO member) throws Exception {

		return membermapper.memberLogin(member);
	}

	@Override
	public MemberVO getMemberInfo(String memberId) {

		return membermapper.getMemberInfo(memberId);
	}

}

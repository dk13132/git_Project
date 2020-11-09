package mc.myInfo.Service;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mc.myInfo.Dto.MyInfoDto;

public class MyInfoDao extends SqlSessionDaoSupport {

	// 비밀번호 체크
	public MyInfoDto confirmPw(MyInfoDto dto) throws Exception {
		return getSqlSession().selectOne("myInfo.selectPassword", dto);
	}

	// 내 정보 변경
	public void udtInfo(MyInfoDto dto) throws Exception {
		getSqlSession().update("myInfo.updateInfo", dto);
	}
	
	public void udtInfoPt(MyInfoDto dto) throws Exception {
		getSqlSession().update("myInfo.updatePhoto", dto);
	}

	// 비밀번호 변경
	public void udtPw(MyInfoDto dto) throws Exception {
		System.out.println("###### 비밀번호 변경 dao");
		getSqlSession().update("myInfo.updatePassword", dto);
	}
	
	// 기존 비밀번호 검증 카운트
	public int countPw(MyInfoDto dto) throws Exception {
		return getSqlSession().selectOne("myInfo.countOldPassword", dto);
	}

	// 내정보 select값
	public MyInfoDto sltInfo(MyInfoDto dto) throws Exception {
		return getSqlSession().selectOne("myInfo.selectInfo", dto);
	}
	


}

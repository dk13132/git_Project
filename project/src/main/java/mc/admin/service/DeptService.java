package mc.admin.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;

import mc.admin.model.AnnualVo;
import mc.admin.model.AttenDto;
import mc.admin.model.AttenListModel;
import mc.admin.model.DeptDto;
import mc.admin.model.DeptInfo;
import mc.admin.model.DeptListModel;
import mc.admin.model.emName;


@Service
public class DeptService {
	
	@Autowired
	DeptDao dao;
	
	public DeptListModel list(int pageNum, int per){
		int count = dao.count();
		if(count == 0) {
			return new DeptListModel();
		}
		
		int start = (pageNum - 1) * per;	
		List<DeptDto> list = dao.getList(start, per);
		
		Paging p = new Paging().paging(pageNum, count, per);
		
		return new DeptListModel(list,pageNum,p.totalPageCount,start,p,count);
	}
	
	public int deleteUser(int dept_no) { 
		
		return dao.deleteUser(dept_no); 
	}
	
	public void insertDept(DeptDto d) {
		int i = d.getDept_no();
		dao.insertDept(d);	
	}
	
	
	public List<Map<String,Object>> getDept(String d) {
		return dao.getDept(d);
	}
	
	
	public DeptDto updateUser(int dept_no) {
		return dao.updateUser(dept_no);
	}
	
	public void update(DeptDto d) {
		
		dao.update(d);	
	}
	
	
	public void setDao(DeptDao dao) {
		this.dao = dao;
	}
	
	public List<DeptDto> selectDepts(){
		return dao.selectDepts();
	}
	
	public List<Map<String,Object>> selectpositions(int dept_no) {
		return dao.selectpositions(dept_no);
	}
	
	
	public List<Map<String,Object>> selectNames(DeptInfo e) {
		return dao.selectNames(e);
	}
	
	public List<Map<String,Object>> selectNo(DeptInfo e) {
		return dao.selectNo(e);
	}
	
	public List<Map<String,Object>> selectPush(DeptInfo info) {
		return dao.selectPush(info);
	}
	
	
	public int  update_auto(emName e) {
		return dao.update_auto(e);
	}
	
	public AttenListModel attenList(int pageNum, int per, @DateTimeFormat(pattern="yyyy-MM-dd")Date start_time){
		
		int count = dao.count1(start_time);
		
		if(count == 0) {
			return new AttenListModel();
		}
		
		int start = (pageNum - 1) * per;
		
		List<AttenDto> list = dao.getAttrList(start, per, start_time);
		
		Paging1 p = new Paging1().paging1(pageNum, count, per);
		
		return new AttenListModel(list,pageNum,p.totalPageCount,start,p,count);
	}
	
	public void updateAttr(AttenDto d) {
		
		dao.updateAttr(d);
	}
	
	public AttenDto attrForm(int attendance_no) {
		
		return dao.attrForm(attendance_no);
	}
	
	public AttenListModel attenList1(int pageNum, int per, @DateTimeFormat(pattern="yyyy-MM-dd")AttenDto a){
		
		int count = dao.count2(a);
		
		if(count == 0) {
			return new AttenListModel();
		}
		
		int start = (pageNum - 1) * per;
		
		List<AttenDto> list = dao.getAttrList1(start, per, a);
		
		Paging1 p = new Paging1().paging1(pageNum, count, per);
		
		return new AttenListModel(list,pageNum,p.totalPageCount,start,p,count);
	}
	
	public double getAnnual(AttenDto d) {
		
		return dao.getAnnual(d);
		
	}
	
	public void setAnnual(AnnualVo an) {
		
		dao.setAnnual(an);
		
	}
	
	public String getDeName(int dept_no){
		
		return dao.getDeName(dept_no);
		
	}

	
	

	
	
	
}

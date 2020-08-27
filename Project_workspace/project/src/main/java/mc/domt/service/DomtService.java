package mc.domt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mc.domt.model.DomtApprovalDto;
import mc.domt.model.DomtAutoDto;
import mc.domt.model.DomtDto;
import mc.domt.model.Domt_P_ApprovalDto;
import mc.domt.model.EmployeeDto;
import mc.domt.model.domtListModel;

@Service
public class DomtService {

		@Autowired
		DomtDao domtdao;
		
//		public List<DomtDto> appDomt_domt_listselect(String employee_no){
//			return domtdao.appDomt_domt_listselect(employee_no);
//		}
//		public List<DomtDto> appDomt_domt_listselect2(String employee_no){
//			return domtdao.appDomt_domt_listselect2(employee_no);
//		}
		public List<DomtDto> appDomt_domt_imok_list(String employee_no){
			return domtdao.appDomt_domt_imok_list(employee_no);
		}
		//페이징처리
		public domtListModel list(int pageNum, int per, String employee_no) {
			int count = domtdao.count(employee_no);
			if (count == 0) {
				return new domtListModel();
			}
			int start = (pageNum - 1) * per;
			List<DomtDto> list = domtdao.getList(start, per, employee_no);
			Paging p = new Paging().paging(pageNum, count, per);
			return new domtListModel(list, pageNum, p.totalPageCount, start, p, count);
		}
		//페이징처리2
		public domtListModel list2(int pageNum, int per, String employee_no) {
			int count = domtdao.count2(employee_no);
			if (count == 0) {
				return new domtListModel();
			}
			int start = (pageNum - 1) * per;
			List<DomtDto> list = domtdao.getList2(start, per, employee_no);
			Paging p = new Paging().paging(pageNum, count, per);
			return new domtListModel(list, pageNum, p.totalPageCount, start, p, count);
		}
		
		public List<EmployeeDto> appDomt_domt_employee_add_listselect(){
			return domtdao.appDomt_domt_employee_add_listselect();  
		}

		public List<Map<String,Object>> appDomt_domt_employee_add_listselect_two(EmployeeDto emdto){
			return domtdao.appDomt_domt_employee_add_listselect_two(emdto);
		}
		public EmployeeDto appDomt_domt_employee_add_listselect_thr(int employee_no){
			return domtdao.appDomt_domt_employee_add_listselect_thr(employee_no);
		}
		//���繮���� �ڵ�
		public DomtAutoDto appDomt_domt_auto(String employee_no){
			return domtdao.appDomt_domt_auto(employee_no);  
		}
		// document_no + 1
		public int appDomt_domt_auto_Nemder(){
			return domtdao.appDomt_domt_auto_Nemder();  
		}
		// approval_no + 1 
		public int insert_app_app_auto_Nemder(){
			return domtdao.insert_app_app_auto_Nemder();  
		}
		//결재문서 인서트
		public int insert_app_domt(DomtDto domtdto){
			return domtdao.insert_app_domt(domtdto);  
		}
		//결재라인 인서트
		public int insert_app_domt_app(DomtApprovalDto domtapp, int[] employee_no1){
			int a = 0;
			for(int i =0; i < employee_no1.length; i++) {
				domtapp.setEmployee_no(employee_no1[i]);
				a += domtdao.insert_app_domt_app(domtapp);  
			}
			return a;
		}
		//결재승인/반려하기
		public void insert_app_domt_app_up(DomtDto domtdto){
			domtdao.insert_app_domt_app_up(domtdto); 
		}
		
		//결재보기
		public Domt_P_ApprovalDto domtViewPage_domt(int document_no){
			return domtdao.domtViewPage_domt(document_no);  
		}
		public List<Domt_P_ApprovalDto> domtViewPage_appline(int document_no){
			return domtdao.domtViewPage_appline(document_no);  
		}
		
		//결재승인/반려하기
		public void imok(DomtApprovalDto domt_app_no){
			domtdao.imok(domt_app_no); 
		}
		//결재승인/반려하기
		public void imno(DomtApprovalDto domt_app_no){
			domtdao.imno(domt_app_no); 
		}

		
}

package com.messbill.Service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

import com.messbill.Entity.Bill;
import com.messbill.Entity.Student;
import com.messbill.Repository.AttendanceRepository;
import com.messbill.Repository.BillRepository;
import com.messbill.Repository.StudentRepository;

public class BillService {

    private BillRepository billRepository = new BillRepository();
    private AttendanceRepository attendanceRepository = new AttendanceRepository();
    private StudentRepository studentRepository = new StudentRepository();

    private static final double BREAKFAST_RATE = 50.0;
    private static final double LUNCH_RATE = 80.0;
    private static final double DINNER_RATE = 60.0;

    public Bill findBillByStudentAndMonth(Integer studentId, String month, Integer year) {
        return billRepository.findBillByStudentAndMonth(studentId, month, year);
    }
    
    public List<Bill> getAllBills() {
        return billRepository.getAllBills();
    }

    public Bill generateBill(Integer studentId, String month, Integer year) {
    	
    	Student std =
    	        studentRepository
    	        .findById(studentId);

    	if(std == null){

    	    throw new RuntimeException(
    	            "Student not found");
    	}

    	if(!"Active".equalsIgnoreCase(
    	        std.getStatus())){

    	    throw new RuntimeException(
    	            "Inactive student cannot generate bill");
    	}

        Integer breakfastCount = attendanceRepository.countMealByStudentMonthYear(studentId, month, year, "Breakfast");
        Integer lunchCount = attendanceRepository.countMealByStudentMonthYear(studentId, month, year, "Lunch");
        Integer dinnerCount = attendanceRepository.countMealByStudentMonthYear(studentId, month, year, "Dinner");

        if (breakfastCount == 0 && lunchCount == 0 && dinnerCount == 0) {
            return null;
        }

        Double breakfastAmount = breakfastCount * BREAKFAST_RATE;
        Double lunchAmount = lunchCount * LUNCH_RATE;
        Double dinnerAmount = dinnerCount * DINNER_RATE;

        Double totalAmount = breakfastAmount + lunchAmount + dinnerAmount;

        int monthNumber = getMonthNumber(month);
        if (monthNumber == 0) {
            return null;
        }

        LocalDate dueDate = LocalDate.of(year, monthNumber, 1)
                .plusMonths(1)
                .withDayOfMonth(5);

        Student student = studentRepository.findById(studentId);
        if (student == null) {
            return null;
        }

        Bill bill = new Bill();
        bill.setStudent(student);
        bill.setMonth(month);
        bill.setYear(year);
        bill.setLateFee(0.0);

        bill.setDueDate(
                YearMonth.from(LocalDate.now())
                        .plusMonths(1)
                        .atDay(5)
        );
        bill.setBreakfastCount(breakfastCount);
        bill.setLunchCount(lunchCount);
        bill.setDinnerCount(dinnerCount);
        bill.setTotalAmount(totalAmount);
        bill.setDueDate(dueDate);
        bill.setStatus("Pending");
        bill.setGeneratedDate(LocalDate.now());

        billRepository.saveBill(bill);
        
        ActivityService activityService = new ActivityService();
        activityService.saveActivity("Bill Generated", "Success");

        return bill;
    }

    private int getMonthNumber(String month) {
        if (month == null) return 0;

        switch (month.toLowerCase()) {
            case "january": return 1;
            case "february": return 2;
            case "march": return 3;
            case "april": return 4;
            case "may": return 5;
            case "june": return 6;
            case "july": return 7;
            case "august": return 8;
            case "september": return 9;
            case "october": return 10;
            case "november": return 11;
            case "december": return 12;
            default: return 0;
        }
    }
    public List<Bill> searchBills( String keyword,String month,Integer year,String billStatus,String studentStatus) {

        return billRepository.searchBills(
                keyword,
                month,
                year,
                billStatus,
                studentStatus);
    }
    
    public Bill findBillById(Integer billId) {
        return billRepository.findBillById(billId);
    }
    
   


    
    
    
    
    public Long getTotalBillsCount() {
        return billRepository.countAllBills();
    }

    public Long getPendingBillsCount() {
        return billRepository.countPendingBills();
    }

    public Long getPaidBillsCount() {
        return billRepository.countPaidBills();
    }

    public Long getTotalBreakfastCount() {
        return billRepository.getTotalBreakfastCount();
    }

    public Long getTotalLunchCount() {
        return billRepository.getTotalLunchCount();
    }

    public Long getTotalDinnerCount() {
        return billRepository.getTotalDinnerCount();
    }

    public Long getBillsCountByMonthAndYear(String month, Integer year) {
        return billRepository.getBillsCountByMonthAndYear(month, year);
    }
    

    public Long getPaidBillsCountByMonthAndYear(String month, Integer year) {
        return billRepository.getPaidBillsCountByMonthAndYear(month, year);
        }

    public Long getPendingBillsCountByMonthAndYear(String month, Integer year) {
        return billRepository.getPendingBillsCountByMonthAndYear(month, year);
    }

    public Double getTotalAmountByMonthAndYear(String month, Integer year) {
        return billRepository.getTotalAmountByMonthAndYear(month, year);
    }

  

   
    public Long getBillsCountByDepartment(String department) {
        return billRepository.countBillsByDepartment(department);
    }

    public Long getPaidBillsCountByDepartment(String department) {
        return billRepository.countPaidBillsByDepartment(department);
    }

    public Long getPendingBillsCountByDepartment(String department) {
        return billRepository.countPendingBillsByDepartment(department);
    }
    
    public Long getOverdueBillsCount() {
        return billRepository.getOverdueBillsCount();
    }

    public Double getTotalBillAmount() {
        return billRepository.getTotalBillAmount();
    }

    public Double getTotalLateFeeAmount() {
        return billRepository.getTotalLateFeeAmount();
    }

    public Double getLateFeeByMonthAndYear(String month, Integer year) {
        return billRepository.getLateFeeByMonthAndYear(month, year);
    }
}
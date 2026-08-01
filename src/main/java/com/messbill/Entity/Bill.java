package com.messbill.Entity;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "bill")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Bill {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer billId;

    @ManyToOne
    private Student student;

    private String month;
    private Integer year;

    private Integer breakfastCount;
    private Integer lunchCount;
    private Integer dinnerCount;

    private Double lateFee = 0.0;
    
    private Double totalAmount;

    private LocalDate dueDate;

    private String status;

    private LocalDate generatedDate;
}
package com.messbill.Entity;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "student",
uniqueConstraints = {
		@UniqueConstraint(columnNames = "email"),
		@UniqueConstraint(columnNames = "rollNo"),
		@UniqueConstraint(columnNames = "phone"),
		@UniqueConstraint(columnNames = "parentPhone"),
       
    }
)
@Data
@NoArgsConstructor
@AllArgsConstructor


public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer studentId;

    @NotBlank(message = "Name is required")
   
    private String name;

    @NotBlank(message = "Roll number is required")
    @Column(nullable = false,unique = true)
    private String rollNo;

    @NotBlank(message = "Gender is required")
    private String gender;
    
    @NotBlank(message = "Department is required")
    private String department;

    @NotNull(message = "Phone is required")
    @Column(nullable = false, unique = true)
    private Long phone;

    @NotNull(message = "Parent phone is required")
    @Column(nullable = false)
    private Long parentPhone;

    @NotBlank(message = "Email is required")
    @Email(message = "Enter valid email")
    @Column(nullable = false, unique = true)
    private String email;

    @NotBlank(message = "Year is required")
    private String year;

    @NotBlank(message = "Hostel room number is required")
    private String hostelRoomNo;

    @NotBlank(message = "Status is required")
    private String status;

}
//
//  Student.swift
//  Malsha_C0871063_gpaApp
//
//  Created by Malsha Lambton on 2022-10-25.
//

import Foundation

struct Student {
    var studentID : String
    var firstName : String
    var lastName : String
    var semesterOneGPA : Double
    var semesterTwoGPA : Double
    var semesterThreeGPA : Double
    
    init(studentID: String, firstName: String, lastName: String, semesterOneGPA: Double, semesterTwoGPA: Double, semesterThreeGPA: Double) {
        self.studentID = studentID
        self.firstName = firstName
        self.lastName = lastName
        self.semesterOneGPA = semesterOneGPA
        self.semesterTwoGPA = semesterTwoGPA
        self.semesterThreeGPA = semesterThreeGPA
    }
}

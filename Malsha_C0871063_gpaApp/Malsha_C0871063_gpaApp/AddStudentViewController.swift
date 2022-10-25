//
//  AddStudentViewController.swift
//  Malsha_C0871063_gpaApp
//
//  Created by Malsha Lambton on 2022-10-25.
//

import UIKit

class AddStudentViewController: UIViewController {

    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var studentIDText: UITextField!
    
    var delegate : StudentListViewController?
    var studentList : [Student] = []
    
    @IBAction func saveSutent() {
        
        if studentIDText.text == ""{
            showAlert(title: "Error", actionTitle: "OK", message: "Please provide a studenID", preferredStyle: .alert)
                return
        }else if firstNameText.text == ""{
            showAlert(title: "Error", actionTitle: "OK", message: "Please provide a first name", preferredStyle: .alert)
                return
        }else if lastNameText.text == ""{
            showAlert(title: "Error", actionTitle: "OK", message: "Please provide a last name", preferredStyle: .alert)
                return
        }else{
            let alert = UIAlertController(title:"Register User" , message:"Are you sure?" , preferredStyle: .alert)
            let action = UIAlertAction(title: "No Way!", style: .cancel)
            
            let save = UIAlertAction(title: "Yes, I'm Sure!", style: .default , handler:  {_ in
                if self.checkStudentIDAvailable(){
                    let message =  self.firstNameText.text! + " is now a student"
                    
                    let newStudent = Student(studentID: self.studentIDText.text!, firstName: self.firstNameText.text!, lastName: self.lastNameText.text!,semesterOneGPA: 0.0, semesterTwoGPA: 0.0, semesterThreeGPA: 0.0)
                    self.studentList.append(newStudent)
                    self.showAlert(title: "New Contact Saved", actionTitle: "OK", message: message, preferredStyle: .alert)
                    self.lastNameText.text = ""
                    self.firstNameText.text = ""
                    self.studentIDText.text = ""
                }else {
                    self.showAlert(title: "Error", actionTitle: "OK", message: "StudentID is not available. Please provide a different ID", preferredStyle: .alert)
                }
            })
            alert.addAction(action)
            alert.addAction(save)
            present(alert, animated: true)
        }
    }
    
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func showAlert(title : String, actionTitle : String, message : String, preferredStyle : UIAlertController.Style){
        
        let alert = UIAlertController(title:title , message:message , preferredStyle: preferredStyle)
        let action = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.updateStudentList(with: studentList)
    }

    private func checkStudentIDAvailable() -> Bool {
        if self.studentList.first(where: {$0.studentID == self.studentIDText.text}) != nil {
            return false
        }else{
            return true
        }
    }
}

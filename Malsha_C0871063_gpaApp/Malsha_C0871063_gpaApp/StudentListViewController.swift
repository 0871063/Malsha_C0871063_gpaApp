//
//  ViewController.swift
//  Malsha_C0871063_gpaApp
//
//  Created by Malsha Lambton on 2022-10-25.
//

import UIKit

class StudentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var studentTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var studentList : [Student] = []
    var filteredData : [Student] = []
    var searchActive: Bool  = false
    var semesterList : [Semester] = []
    
    override func viewDidLoad() {
        semesterList.append(Semester(semesterID: 1, courseOne: "Jave Programming", courseTwo: "Swift Development", courseThree: "iOS Programming", courseFour: "Android Development", courseFive: "Database Design"))
        semesterList.append(Semester(semesterID: 2, courseOne: "DBMS", courseTwo: "Advanced Swift Development", courseThree: "React Native Development", courseFour: "Advanced Android Development", courseFive: "Flutter Development"))
        semesterList.append(Semester(semesterID: 3, courseOne: "Xamarin Development", courseTwo: " SwiftUI Development", courseThree: "Advanced React Native", courseFour: "Web Development", courseFive: "Advanced Flutter Development"))
    }
    //MARK: TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchActive){
            return filteredData.count
        }else
        {
            return studentList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell",
                                                 for: indexPath) as! StudentCell
        var student : Student
        if (searchActive){
            student = self.filteredData[indexPath.row]
        }else{
            student = self.studentList[indexPath.row]
        }
        let cgpa = updateCGAP(student: student)
        let cgpaString = String(format: "%.1f", cgpa)
        cell.name?.text = student.firstName + " " + student.lastName
        cell.cgpa?.text = cgpaString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let semesterView = storyboard.instantiateViewController(withIdentifier: "SemesterSelectionViewController") as! SemesterSelectionViewController
        if (searchActive){
            semesterView.selectedStudent = self.filteredData[indexPath.row]
        }else{
            semesterView.selectedStudent = self.studentList[indexPath.row]
        }
        semesterView.semesterList = self.semesterList
        semesterView.delegate = self
        navigationController?.pushViewController(semesterView, animated: true)
    }
    
    //MARK: Navigation Delegates
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? AddStudentViewController {
            nextViewController.delegate = self
            nextViewController.studentList = self.studentList
        }
    }
    
    //MARK: SearchBar Delegates
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? studentList : studentList.filter {(student: Student) -> Bool in
            return student.firstName.lowercased()
                .contains(searchText.lowercased()) || student.lastName.lowercased()
                .contains(searchText.lowercased())
        }
        studentTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    //MARK: Functions
    func updateStudentList(with studentList : [Student]){
        self.studentList.removeAll()
        self.studentList = studentList
        studentTableView.reloadData()
    }
    
    func updateStudent(with student : Student){
        if let row = self.studentList.firstIndex(where: {$0.studentID == student.studentID}) {
            self.studentList[row] = student
        }
        studentTableView.reloadData()
    }
    
    private func updateCGAP(student : Student) -> Double {
        let cgps = (student.semesterOneGPA + student.semesterTwoGPA + student.semesterThreeGPA)/3.0
        return cgps
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchActive = false
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        studentTableView.reloadData()
    }
}

class StudentCell: UITableViewCell {
    @IBOutlet var name : UILabel?
    @IBOutlet var cgpa : UILabel?
}

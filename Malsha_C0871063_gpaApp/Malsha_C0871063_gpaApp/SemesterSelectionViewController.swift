//
//  SemesterSelectionViewController.swift
//  Malsha_C0871063_gpaApp
//
//  Created by Malsha Lambton on 2022-10-25.
//

import UIKit

class SemesterSelectionViewController: UIViewController {
    
    @IBOutlet weak var semesterThreeBtn: UIButton!
    @IBOutlet weak var semsterTwoBtn: UIButton!
    @IBOutlet weak var semesterOneBtn: UIButton!
    var selectedStudent : Student?
    var delegate : StudentListViewController?
    var semesterList : [Semester] = []
    
    override func viewWillAppear(_ animated: Bool) {
        if selectedStudent?.semesterOneGPA == 0.0 {
            semesterOneBtn.isEnabled = true
        }else{
            semesterOneBtn.isEnabled = false
        }
        if selectedStudent?.semesterTwoGPA == 0.0 {
            semsterTwoBtn.isEnabled = true
        }else{
            semsterTwoBtn.isEnabled = false
        }
        if selectedStudent?.semesterThreeGPA == 0.0 {
            semesterThreeBtn.isEnabled = true
        }else{
            semesterThreeBtn.isEnabled = false
        }
    }
    
    @IBAction func semesterOneSelection() {
        navigateToGPAPage(semester: 1)
    }
    
    @IBAction func semesterTwoSelection() {
        navigateToGPAPage(semester: 2)
    }
    
    @IBAction func semesterThreeSelection() {
        navigateToGPAPage(semester: 3)
    }
    
    private func navigateToGPAPage(semester : Int){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let calculateGPAView = storyboard.instantiateViewController(withIdentifier: "CalculateGPAViewController") as! CalculateGPAViewController
        calculateGPAView.selectedStudent = self.selectedStudent
        calculateGPAView.selectedSemester = semester
        calculateGPAView.delegate = self.delegate
        calculateGPAView.semesterList = self.semesterList
        navigationController?.pushViewController(calculateGPAView, animated: true)
    }
}

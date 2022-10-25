//
//  CalculateGPAViewController.swift
//  Malsha_C0871063_gpaApp
//
//  Created by Malsha Lambton on 2022-10-25.
//
import UIKit
import AVFoundation

class CalculateGPAViewController: UIViewController {
  
    @IBOutlet weak var courseOne: UITextField!
    @IBOutlet weak var courseTwo: UITextField!
    @IBOutlet weak var courseThree: UITextField!
    @IBOutlet weak var courseFour: UITextField!
    @IBOutlet weak var courseFive: UITextField!
    @IBOutlet weak var courseOneLbl: UILabel!
    @IBOutlet weak var courseTwoLbl: UILabel!
    @IBOutlet weak var courseThreeLbl: UILabel!
    @IBOutlet weak var courseFourLbl: UILabel!
    @IBOutlet weak var courseFiveLbl: UILabel!
    
    var selectedStudent : Student?
    var player: AVAudioPlayer?
    var selectedSemester : Int?
    var semesterList : [Semester] = []
    
    weak var delegate: StudentListViewController?
    
    override func viewDidLoad() {
        if let semesterID = selectedSemester {
            if let semester = semesterList.first(where: {$0.semesterID == semesterID}) {
                courseOneLbl.text = semester.courseOne
                courseTwoLbl.text = semester.courseTwo
                courseThreeLbl.text = semester.courseThree
                courseFourLbl.text = semester.courseFour
                courseFiveLbl.text = semester.courseFive
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        player?.stop()
    }
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func calculateGPA() {
        if courseOne.text == ""{
            showAlert(title: "Error", actionTitle: "OK", message: "Please provide a marks for " + courseOneLbl.text! + " subject", preferredStyle: .alert)
                return
        }else if courseFive.text == ""{
            showAlert(title: "Error", actionTitle: "OK", message: "Please provide a marks for " + courseTwoLbl.text! + " subject", preferredStyle: .alert)
                return
        }else if courseFour.text == ""{
            showAlert(title: "Error", actionTitle: "OK", message: "Please provide a marks for " + courseThreeLbl.text! + " subject", preferredStyle: .alert)
                return
        }else if courseThree.text == ""{
            showAlert(title: "Error", actionTitle: "OK", message: "Please provide a marks for " + courseFourLbl.text! + " subject", preferredStyle: .alert)
                return
        }else if courseTwo.text == ""{
            showAlert(title: "Error", actionTitle: "OK", message: "Please provide a marks for " + courseFiveLbl.text! + " subject", preferredStyle: .alert)
                return
        }else{
            let androidGPA = getGPAValue(marks: Int(courseOne.text ?? "0") ?? 0)
            let swiftGPA = getGPAValue(marks: Int(courseFive.text ?? "0") ?? 0)
            let iosGPA = getGPAValue(marks: Int(courseFour.text ?? "0") ?? 0)
            let dbGPA = getGPAValue(marks: Int(courseThree.text ?? "0") ?? 0)
            let javaGPA = getGPAValue(marks: Int(courseTwo.text ?? "0") ?? 0)
            
            let gpa = (androidGPA + swiftGPA + iosGPA + dbGPA + javaGPA) / 5.0
            
            if gpa > 2.8 {
                playSound()
            }
            let gpaString = String(format: "%.1f", gpa)
            
            updateStudentGPA(gpa: Double(gpaString) ?? 0.0)
            
            showAlert(title: "GPA ", actionTitle: "OK", message: "Your GPA value is \(gpaString)", preferredStyle: .alert)
            courseTwo.text = ""
            courseThree.text = ""
            courseFour.text = ""
            courseFive.text = ""
            courseOne.text = ""
        }
    }
    
    private func showAlert(title : String, actionTitle : String, message : String, preferredStyle : UIAlertController.Style){
        
        let alert = UIAlertController(title:title , message:message , preferredStyle: preferredStyle)
        let action = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    //MARK: Sudent GPA Functions
    private func getGPAValue(marks : Int) -> Double {
         if (94 <= marks && marks <= 100 ){
             return 4.0
        }else if (87 <= marks && marks <= 93 ){
            return 3.7
        }else if (80 <= marks && marks <= 86 ){
            return 3.5
        }else if (77 <= marks && marks <= 79 ){
            return 3.2
        }else if (73 <= marks && marks <= 76 ){
            return 3.0
        }else if (70 <= marks && marks <= 72 ){
            return 2.7
        }else if (67 <= marks && marks <= 69 ){
            return 2.3
        }else if (63 <= marks && marks <= 66 ){
            return 2.0
        }else if (60 <= marks && marks <= 62 ){
            return 1.7
        }else if (50 <= marks && marks <= 59 ){
            return 1.0
        }else if (0 <= marks && marks <= 49 ){
            return 0.0
        }
        else{
            return 0.0
        }
    }
    
    private func updateStudentGPA(gpa : Double){
        let semester = selectedSemester ?? 0
        switch semester {
        case 1:
            selectedStudent?.semesterOneGPA = gpa
        case 2:
            selectedStudent?.semesterTwoGPA = gpa
        case 3:
            selectedStudent?.semesterThreeGPA = gpa
        default:
            break
        }
    }

    //MARK: Player Function
    func playSound() {
        player?.stop()
        
        guard let url = Bundle.main.url(forResource: "clap", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.updateStudent(with: selectedStudent!)
    }
}

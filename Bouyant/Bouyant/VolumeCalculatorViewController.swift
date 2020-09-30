//
//  VolumeCalculatorViewController.swift
//  Bouyant
//
//  Created by Lambda_School_Loaner_204 on 9/30/20.
//

import UIKit

enum GuildFactor: Float {
    case Beginner = 0.50
    case BegInter = 0.46 // (0.49 - 0.43)
    case Intermediate = 0.40 // (0.42 - 0.38)
    case InterAdv = 0.37 // (0.38 - 0.36)
    case Advanced = 0.35 // (0.36 - 0.34)
}

class VolumeCalculatorViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var levelPicker: UIPickerView!
    @IBOutlet weak var litersLabel: UILabel!
    @IBOutlet weak var weightSlider: UISlider!

    override func viewDidLoad() {
        levelPicker.delegate = self
        levelPicker.dataSource = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension VolumeCalculatorViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Beginner"
        case 1:
            return "Beginner/Intermediate"
        case 2:
            return "Intermediate"
        case 3:
            return "Intermediate/Advanced"
        case 4:
            return "Advanced"
        default:
            return ""
        }
    }


}

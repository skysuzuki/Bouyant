//
//  WeightPickerViewController.swift
//  Bouyant
//
//  Created by Lambda_School_Loaner_204 on 11/16/20.
//

import UIKit

enum weight: Int {
    case lbs
    case kgs
}

protocol WeightPickerDelegate {
    func choseWeight(_ weight: Double)
}

class WeightPickerViewController: UIViewController {

    @IBOutlet weak var weightPicker: UIPickerView!

    var weightChoice = weight.kgs
    var weightDelegate: WeightPickerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        weightPicker.dataSource = self
        weightPicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        weightDelegate?.choseWeight(weightCalculationFromPicker())
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func weightCalculationFromPicker() -> Double {
        let wholeNum = Double(weightPicker.selectedRow(inComponent: 0) + 80)
        let decimal = Double(weightPicker.selectedRow(inComponent: 1)) * 0.10
        return wholeNum + decimal
    }

}

extension WeightPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        switch component {
        case 0:
            return (300 - 80)
        case 1:
            return 10
        case 2:
            return 2
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        switch component {
        case 0:
            for i in 80...300 {
                return String(row + i)
            }
        case 1:
            for _ in 0...10 {
                return ".\(row)"
            }
        case 2:
            if row == 0 {
                return "lbs"
            } else {
                return "kgs"
            }
        default:
            return ""
        }
        return nil
    }
}

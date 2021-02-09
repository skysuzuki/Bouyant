//
//  WeightPickerViewController.swift
//  Bouyant
//
//  Created by Lambda_School_Loaner_204 on 11/16/20.
//

import UIKit

protocol WeightPickerDelegate {
    func choseWeight(_ weight: Float, _ lbsOrKg: Bool)
}

class WeightPickerViewController: UIViewController {

    @IBOutlet weak var weightPicker: UIPickerView!

    var weightDelegate: WeightPickerDelegate?
    var surfer: Surfer?

    override func viewDidLoad() {
        super.viewDidLoad()

        weightPicker.dataSource = self
        weightPicker.delegate = self
        // Do any additional setup after loading the view.

        guard let surfer = surfer else { return }
        let decimalRow = Int(surfer.weight * 10) % 10
        let wholeNumRow = Int(surfer.weight - (Float(decimalRow) * 0.10)) - 80
        let lbsOrKgRow = surfer.isLbs ? 0 : 1
        weightPicker.selectRow(wholeNumRow, inComponent: 0, animated: false)
        weightPicker.selectRow(decimalRow, inComponent: 1, animated: false)
        weightPicker.selectRow(lbsOrKgRow, inComponent: 2, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        weightDelegate?.choseWeight(weightCalculationFromPicker(),
                                    (weightPicker.selectedRow(inComponent: 2) == 0))
    }

    private func weightCalculationFromPicker() -> Float {
        let wholeNum = Float(weightPicker.selectedRow(inComponent: 0) + 80)
        let decimal = Float(weightPicker.selectedRow(inComponent: 1)) * 0.10
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

//
//  SkillLevelPickerViewController.swift
//  Bouyant
//
//  Created by Lambda_School_Loaner_204 on 11/25/20.
//

import UIKit

protocol SkillLevelDelegate {
    func skillChoice(skillLevel: GuildFactor, skillString: String)
}

class SkillLevelPickerViewController: UIViewController {

    @IBOutlet weak var skillLevelPicker: UIPickerView!

    var skillLevelDelegate: SkillLevelDelegate?
    var pickerRowIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        skillLevelPicker.delegate = self
        skillLevelPicker.dataSource = self
        // Do any additional setup after loading the view.

        skillLevelPicker.selectRow(pickerRowIndex ?? 0, inComponent: 0, animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func viewDidDisappear(_ animated: Bool) {
        let index = skillLevelPicker.selectedRow(inComponent: 0)
        skillLevelDelegate?.skillChoice(skillLevel: GuildFactor.allCases[index],
                                        skillString: skillChoice(index))
    }

    private func skillChoice(_ index: Int) -> String {
        switch index {
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

extension SkillLevelPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GuildFactor.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return skillChoice(row)
    }
}

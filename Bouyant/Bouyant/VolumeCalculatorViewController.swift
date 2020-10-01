//
//  VolumeCalculatorViewController.swift
//  Bouyant
//
//  Created by Lambda_School_Loaner_204 on 9/30/20.
//

import UIKit
import CoreData

class VolumeCalculatorViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var levelPicker: UIPickerView!
    @IBOutlet weak var litersLabel: UILabel!
    @IBOutlet weak var weightSlider: UISlider!

    // MARK: Properties

    private let surferController = SurferController()

    lazy var fetchedResultController: NSFetchedResultsController<Surfer> = {
        let fetchRequest: NSFetchRequest<Surfer> = Surfer.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "weight", ascending: false)]
                                        //NSSortDescriptor(key: "timestamp", ascending: false)]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: moc,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            print("Error fetching: \(error)")
        }
        return frc
    }()

    private var liters: Float = 0.0
    var surfer: Surfer?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        levelPicker.delegate = self
        levelPicker.dataSource = self
        updateViews()
    }

    private func updateViews() {
        if let surfers = fetchedResultController.fetchedObjects,
           surfers.count > 0 {
            surfer = surfers[0]
            if let surfer = surfer {
                weightTextField.text = String(surfer.weight)
                let index = GuildFactor.allCases.firstIndex(of: GuildFactor(rawValue: surfer.guildFactor) ?? GuildFactor.Beginner)
                levelPicker.selectRow(index ?? 0, inComponent: 0, animated: false)
            }
        }

        litersLabel.text = String(format: "%.2f", liters)

    }

    // MARK: IBActions
    @IBAction func calculateTapped(_ sender: Any) {
        guard let weightText = weightTextField.text,
              let weight = Float(weightText) else { return }

        let index = levelPicker.selectedRow(inComponent: 0)
        let guildFactor = GuildFactor.allCases[index]

        if let surfer = surfer {
            surferController.update(for: surfer, weight: weight, guildFactor: guildFactor.rawValue)
        } else {
            surferController.create(weight: weight, guildFactor: guildFactor.rawValue)
        }

        liters = surferController.calculateLiters(weight: weight, guildFactor: guildFactor.rawValue)
        updateViews()
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

// UIPicker DataSource/Delegate
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

// NSFetchedResultsControllerDelegate
extension VolumeCalculatorViewController: NSFetchedResultsControllerDelegate {

}

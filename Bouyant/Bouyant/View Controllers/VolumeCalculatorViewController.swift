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

//    @IBOutlet weak var weightLabel: UILabel!
//    @IBOutlet weak var levelPicker: UIPickerView!
    @IBOutlet weak var litersLabel: UILabel!
//    @IBOutlet weak var weightSlider: UISlider!
//    @IBOutlet weak var lbskgsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var informationTableView: UITableView!

    // MARK: Properties

    private let surferController = SurferController()
    lazy var slideInTransistionDelegate = SlideInPresentationManager()
    //private var liters: Float = 0.0
    private var surfer: Surfer? {
        didSet {
            updateSurferViews()
        }
    }

    private var surfboard: Surfboard?
    private var isLbs: Bool?
    private var calculateButton = UIButton()
    private var skillLevel = "Level"

    lazy var fetchedResultController: NSFetchedResultsController<Surfer> = {
        let fetchRequest: NSFetchRequest<Surfer> = Surfer.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "weight", ascending: false)]
        
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        informationTableView.delegate = self
        informationTableView.dataSource = self
        informationTableView.isScrollEnabled = false
        informationTableView.tableFooterView = UIView()
//        levelPicker.delegate = self
//        levelPicker.dataSource = self
//        lbskgsSegmentedControl.accessibilityIdentifier = "WeightSegmentedControl"
        updateViews()
        setUpSubViews()
    }

    private func updateViews() {
        if let surfers = fetchedResultController.fetchedObjects,
           surfers.count > 0 {
            surfer = surfers[0]
            surfboard = surfer?.surfboard
        } else {
            surfer = surferController.create(weight: 80.0, guildFactor: GuildFactor.Beginner.rawValue, isLbs: true)
        }
        litersLabel.text = String(format: "%.2f", surfboard?.liters ?? 0.0)
    }

    private func updateSurferViews() {
        self.isLbs = surfer!.isLbs
//        if !surfer!.isLbs && lbskgsSegmentedControl.selectedSegmentIndex != 1 {
//            lbskgsSegmentedControl.selectedSegmentIndex = 1
//            weightSlider.maximumValue /= 2.2
//            weightSlider.minimumValue /= 2.2
//        }
//        weightLabel.text = String(surfer!.weight)
//        let index = GuildFactor.allCases.firstIndex(of: GuildFactor(rawValue: surfer!.guildFactor) ?? GuildFactor.Beginner)
//        levelPicker.selectRow(index ?? 0, inComponent: 0, animated: false)
//        weightSlider.value = surfer!.weight
    }

    private func setUpSubViews() {
        view.addSubview(calculateButton)
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.setTitleColor(.systemBlue, for: .normal)
        calculateButton.accessibilityIdentifier = "CalculateButton"
        calculateButton.addTarget(self, action: #selector(calculate), for: .touchUpInside)
        calculateButton.translatesAutoresizingMaskIntoConstraints = false

//        NSLayoutConstraint.activate([
//            calculateButton.topAnchor.constraint(equalTo: levelPicker.bottomAnchor, constant: 20),
//            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            calculateButton.heightAnchor.constraint(equalToConstant: 50),
//            calculateButton.widthAnchor.constraint(equalToConstant: 100)
//        ])
    }

    @objc private func calculate(sender: UIButton) {
//        guard let weightText = weightLabel.text,
//              let weight = Float(weightText),
//              let isLbs = isLbs,
//              let surfer = surfer else { return }
//
//        let index = levelPicker.selectedRow(inComponent: 0)
//        let guildFactor = GuildFactor.allCases[index]
//
//        let liters = guildFactor.rawValue * (isLbs ? (weight / 2.2) : weight)
//
//        if let surfboard = surfboard {
//            surferController.updateSurfboard(for: surfboard, liters: liters)
//        } else {
//            surfboard = surferController.createSurfboard(liters: liters, surfer: surfer)
//        }
//        //liters = surferController.calculateLiters(weight: weight, guildFactor: guildFactor.rawValue, isLbs: isLbs)
//
//        surferController.update(for: surfer, weight: weight, guildFactor: guildFactor.rawValue, isLbs: isLbs)

        updateViews()
    }

    // MARK: IBActions

    @IBAction func updateWeight(_ sender: UISlider) {
        //weightLabel.text = String(format: "%.2f", sender.value)
    }

    @IBAction func convertWeight(_ sender: UISegmentedControl) {
        var convertedWeight: Float = 0.0
//        if sender.selectedSegmentIndex == 0 {
//            guard let weightText = weightLabel.text,
//                  let weight = Float(weightText) else { return }
//            self.isLbs = true
//            convertedWeight = weight * 2.2
//            weightSlider.maximumValue *= 2.2
//            weightSlider.minimumValue *= 2.2
//            weightSlider.setValue(convertedWeight, animated: false)
//        } else if sender.selectedSegmentIndex == 1 {
//            guard let weightText = weightLabel.text,
//                  let weight = Float(weightText) else { return }
//            self.isLbs = false
//            convertedWeight = weight / 2.2
//            weightSlider.maximumValue /= 2.2
//            weightSlider.minimumValue /= 2.2
//            weightSlider.setValue(convertedWeight, animated: false)
//        }
//        weightLabel.text = String(format: "%.2f", convertedWeight)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WeightPickerViewController {
            if segue.identifier == "WeightPickerSegue" {
                slideInTransistionDelegate.direction = .bottom
            }

            destination.transitioningDelegate = slideInTransistionDelegate
            destination.modalPresentationStyle = .custom

        } else if let destination = segue.destination as? SkillLevelPickerViewController {
            if segue.identifier == "SkillLevelSegue" {
                slideInTransistionDelegate.direction = .bottom
            }

            destination.transitioningDelegate = slideInTransistionDelegate
            destination.modalPresentationStyle = .custom
            destination.skillLevelDelegate = self
            destination.pickerRowIndex = GuildFactor.allCases.firstIndex(of: GuildFactor(rawValue: surfer!.guildFactor) ?? GuildFactor.Beginner)
        }
    }

}

// UIPicker DataSource/Delegate
extension VolumeCalculatorViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GuildFactor.allCases.count
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
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

    }
}

extension VolumeCalculatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeightCell", for: indexPath)
            cell.textLabel?.text = "Weight"
            cell.detailTextLabel?.text = "Lbs"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath)
            cell.textLabel?.text = "Skill Level"
            cell.detailTextLabel?.text = skillLevel
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension VolumeCalculatorViewController: SkillLevelDelegate {
    func skillChoice(skillLevel: GuildFactor, skillString: String) {
        self.skillLevel = skillString
        surfer?.guildFactor = skillLevel.rawValue
        self.informationTableView.reloadData()
    }
}

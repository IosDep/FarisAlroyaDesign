//
//  CountriesViewController.swift
//  KEENZALARAB
//
//  Created by Osama Abu hdba on 09/01/2024.
//

import UIKit
import ViewAnimator

protocol SelectCountriesViewControllerDelegate: AnyObject {
    func didFinishChooseCountry(countryName:String, countryId: Int)
}

class CountriesViewController: BaseViewController {
    override var navigationHidingMode: BaseViewController.BarHidingMode {
        .alwaysHidden
    }

    var viewModel = MainViewModel()
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!

    public var selectedCountry: CountryCodeArra?
    public var countryId = 1
    public var selectFirst: Bool = false
    private var countries: [CountryCodeArra] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    weak var delegate: SelectCountriesViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getCountryCodes()
        print(countries.count)

    }


    
    private func getCountryCodes() {

        
        viewModel.getAllCountryCodeKey() { [weak self] success, error in
                if success {
              
                    self?.countries = self?.viewModel.countryCodeArr ?? []
                    print("COOOD",self?.countries)
                    
                    self?.tableView.reloadData()
                    self?.fadeInCells()
                    
                } else if let error = error {
                    // Handle the error, maybe show an alert to the user
                    print("Error occurred during search: \(error.localizedDescription)")
         

                }
            }
        }
    

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CountryTableViewCell.self)
        tableView.rowHeight = 70
        tableView.reloadData()
        fadeInCells()
    }

    private func fadeInCells() {
        let animations = [AnimationType.vector(CGVector(dx: 0, dy: 300))]
        UIView.animate(views: tableView.visibleCells, animations: animations,duration: 0.8, completion: {})
    }

    @IBAction func doneButtonAction(_ sender: Any) {
        show(message: "يرجى اختيار رمز البلد", messageType: .failure)

    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        self.dismiss(animated: true,completion: { [self] in
            delegate?.didFinishChooseCountry( countryName: countries[indexPath.row].country_phone_key ?? "", countryId: countries[indexPath.row].id ?? 0)
        })


    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell: CountryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
             var country = countries[indexPath.row]
             cell.setupCell(with: country)

             return cell
         }
}

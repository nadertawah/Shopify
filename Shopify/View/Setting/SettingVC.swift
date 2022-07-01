//
//  SettingVC.swift
//  Shopify
//
//  Created by Mohamed Azooz on 28/06/2022.
//

import UIKit

class SettingVC: UIViewController {
    
    // OutLets
    @IBOutlet weak var settingTableView: UITableView!
    
    var setting : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Confirm DataSource & Delegate for TableView
        settingTableView.dataSource = self
        settingTableView.delegate = self
        
        // Registration of setting Cell
        settingTableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
        
        setting = [ "Address" , "Currency" , "About us" , "Contact us" ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        settingTableView.reloadData()
    }
    
}



// MARK: - SettingVC DataSource & Delegate Methods
extension SettingVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        if indexPath.row == 1 {
            if let currency = UserDefaults.standard.string(forKey: "Currency") {
                cell.settingLabel.text = "\(setting[indexPath.row]):  \(currency)"
            }
        } else {
            cell.settingLabel.text = setting[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
            let addressVC = AddressVC()
            self.navigationController?.pushViewController(addressVC, animated: true)
        case 1:
            let vc = CurrenciesTableView()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}

//
//  MeVC.swift
//  Shopify
//
//  Created by Nader Said on 21/06/2022.
//

import UIKit

class MeVC: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setUI()
    }


    //MARK: - IBOutlet(s)
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var loginRegisterBtn: UIButton! {didSet{loginRegisterBtn.shopifyBtn(title: "LOGIN/REGISTER")}}
    
    @IBOutlet weak var moreOrdersBtn: UIButton!
    
    @IBOutlet weak var moreWishlistBtn: UIButton!
    
    @IBOutlet weak var ordersTableView: UITableView!
    
    @IBOutlet weak var wishlistTableView: UITableView!
    
    @IBOutlet weak var logoutBtn: UIButton!{didSet{logoutBtn.shopifyBtn(title: "LOGOUT")}}
    
    
    //MARK: - IBAction(s)
    
    @IBAction func moreOrdersBtnPressed(_ sender: Any)
    {
        
    }
    
    @IBAction func moreWishlistBtnPressed(_ sender: Any)
    {
        
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any)
    {
        VM.logout()
    }
    
    //MARK: - Var(s)
    var VM = MeViewModel(dataProvider: API())
    private let labelCellIdentfier = "LabelTableViewCell"
    
    //MARK: - Helper Funcs
    func setUI()
    {
        //TODO: - get customer info and use customer id as a password
        
        
        
        //set title
        title = "Me"
        
        //set delegates
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        
        wishlistTableView.delegate = self
        wishlistTableView.dataSource = self
        
        //register cell
        ordersTableView.register(UINib(nibName: labelCellIdentfier, bundle: nil), forCellReuseIdentifier: labelCellIdentfier)
        
        wishlistTableView.register(UINib(nibName: labelCellIdentfier, bundle: nil), forCellReuseIdentifier: labelCellIdentfier)
        
        //set navbar wishlist and settings buttons
        setNavBarBtns()
        
        //show/hide login or register and logout buttons
        VM.isLoggedIn.bind
        { [weak self] isLoggedIn in
            DispatchQueue.main.async
            {
                self?.updateUILoginRegisterState(isLoggedIn: isLoggedIn ?? false)
                self?.wishlistTableView.reloadData()
                self?.ordersTableView.reloadData()
            }
        }
        
        // bind customer data
        VM.customer.bind { [weak self] customer in
            DispatchQueue.main.async
            {
                self?.welcomeLabel.text = "Welcome, \(customer?.first_name ?? "")"
            }
        }
        
        //TODO: - get wishlist items (if > 4, enable more btn)
        //TODO: - get order history (if > 2, enable more btn)
    }
    
    @IBAction func loginRegisterBtnPressed(_ sender: Any)
    {
        let vc = LoginRegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func updateUILoginRegisterState(isLoggedIn:Bool)
    {
        if isLoggedIn
        {
            UIView.animate(withDuration: 0.5)
            { [weak self] in
                self?.welcomeLabel.alpha = 1
                self?.logoutBtn.alpha = 1
                self?.loginRegisterBtn.alpha = 0
                
            }
            
        }
        else
        {
            UIView.animate(withDuration: 0.5)
            {
                [weak self] in
                self?.welcomeLabel.alpha = 0
                self?.logoutBtn.alpha = 0
                self?.loginRegisterBtn.alpha = 1
            }
        }
    }
    
    func setNavBarBtns()
    {
        let wishlistNavBtn = UIBarButtonItem(image: UIImage(systemName: "heart.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(navigateToWishlist))
        
        
        let settingsNavBtn = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(navigateToSettings))
        
        self.navigationController?.navigationBar.topItem?.setRightBarButtonItems([settingsNavBtn,wishlistNavBtn], animated: true)
    }
    
    @objc func navigateToWishlist()
    {
        
    }
    
    @objc func navigateToSettings()
    {

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        VM.getLoginState()
    }
}

//MARK: - table view delegates
extension MeVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if VM.isLoggedIn.value == true
        {
            if tableView == ordersTableView
            {
                return 2
            }
            else if tableView == wishlistTableView
            {
                return 4
            }
                
        }
        else {return 0}
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == ordersTableView
        {
            guard let cell = ordersTableView.dequeueReusableCell(withIdentifier: labelCellIdentfier) as? LabelTableViewCell else {return UITableViewCell()}
            
            switch indexPath.row
            {
                case 0 :
                    cell.label.text = "Price: 555\nCreated At: \(Date())"
                    break
                
                    
                case 1 :
                    cell.label.text = "Price: 444\nCreated At: \(Date())"
                    break
                
                default:
                    break
            }
            return cell
        }
        else if tableView == wishlistTableView
        {
            guard let cell = wishlistTableView.dequeueReusableCell(withIdentifier: labelCellIdentfier) as? LabelTableViewCell else {return UITableViewCell()}
            
            switch indexPath.row
            {
                case 0 :
                    cell.label.text = "Price: 555\nCreated At: \(Date())"
                    break
                
                case 1 :
                    cell.label.text = "Price: 444\nCreated At: \(Date())"
                    break
                
                case 2 :
                    cell.label.text = "Price: 555\nCreated At: \(Date())"
                    break
                
                    
                case 3 :
                    cell.label.text = "Price: 444\nCreated At: \(Date())"
                    break
                
                default:
                    break
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

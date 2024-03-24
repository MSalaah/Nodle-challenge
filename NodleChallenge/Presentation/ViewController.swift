//
//  ViewController.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblWalletId: UILabel!
    @IBOutlet weak var lblWalletName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewmodel: MainViewModel?
    
    private let cellReuseId = "NfTCell"
    private let alert = UIAlertController(title: nil, message: "", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.barTintColor = .white
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = "My Wallet"

        //TODO: inject dependcies using Resolver
        let assetstUseCase: AssetsUseCassDataSource = AssetsUseCase(repository: WalletRepository(networkService: WalletServiceProvider(), cache: CoreDataWalletQueriesStorage()))
        let walletUseCase: WalletUseCaseDataSource = WalletUseCase(repository: WalletRepository(networkService: WalletServiceProvider(), cache: CoreDataWalletQueriesStorage()))
        viewmodel = MainViewModel(assetsUseCase: assetstUseCase, walletUseCase: walletUseCase)
        
        

        viewmodel?.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewmodel?.details.observe(on: self) { [weak self] _ in self?.updateItems() }
        
        viewmodel?.onAssetsFetched = { [weak self] (name, id) in
            self?.lblWalletName.text = "Wallet Name: \(name)"
            self?.lblWalletId.text = "Wallet ID: \(id)"
        }
        
        setupTableView()
    }
    
    private func updateItems() {
        Task {@MainActor in
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.dataSource = self
    }
    
    @IBAction func showDetailsAction(_ sender: Any) {
        viewmodel?.fetchWalletData()
    }
    
    private func updateLoading(_ loading: Bool) {
        if loading {
            print("Show Loading")
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.isUserInteractionEnabled = false
            activityIndicator.color = .blue
            activityIndicator.startAnimating()
                    
            alert.view.addSubview(activityIndicator)
            
            NSLayoutConstraint.activate([
                alert.view.heightAnchor.constraint(equalToConstant: 95),
                alert.view.widthAnchor.constraint(equalToConstant: 95),
                activityIndicator.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor)
            ])
            
            present(alert, animated: true)
        } else {
            print("Hide Loading")
            alert.dismiss(animated: true)
        }
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as! NfTCell
        cell.name.text = viewmodel?.detailsArray[indexPath.row].title
        cell.value.text = viewmodel?.detailsArray[indexPath.row].value
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel?.detailsArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Details"
         }
        return "Non Fungible Tokens"
    }
}

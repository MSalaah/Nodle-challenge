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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.barTintColor = .white
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = "My Wallet"

        let assetstUseCase: AssetsUseCassDataSource = AssetsUseCase(repository: WalletRepository(networkService: WalletServiceProvider(), cache: CoreDataWalletQueriesStorage()))
        let walletUseCase: WalletUseCaseDataSource = WalletUseCase(repository: WalletRepository(networkService: WalletServiceProvider(), cache: CoreDataWalletQueriesStorage()))
        viewmodel = MainViewModel(assetsUseCase: assetstUseCase, walletUseCase: walletUseCase)
        
        

        viewmodel?.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        
        viewmodel?.onHideSpinner = { [weak self] in
            print("Hide Loading")
        }
        
        viewmodel?.onShowSpinner = { [weak self] in
            print("Show Loading")
        }
        
        viewmodel?.onAssetsFetched = { [weak self] (name, id) in
            self?.lblWalletName.text = "Wallet Name: \(name)"
            self?.lblWalletId.text = "Wallet ID: \(id)"
        }
    }
    
    private func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.register(UINib(nibName: cellReuseId, bundle: nil), forCellReuseIdentifier: cellReuseId)
//        tableView.dataSource = self
//        tableView.delegate = self
    }
    
    private func updateLoading(_ loading: Bool) {
        if loading {
            print("Show Loading")
        } else {
            print("Hide Loading")
        }
    }
    
    
    @IBAction func showDetailsAction(_ sender: Any) {
        viewmodel?.fetchWalletData()
    }
}


//extension ViewController : UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as! MoviesListTableCell
//        let item = viewModel.items.value[indexPath.section][indexPath.row]
//        cell.configure(viewModel: item)
//        
//        return cell
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        viewModel.items.value.count
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.items.value[section].count
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "\(viewModel.items.value[section].first?.releaseYear ?? 0)"
//    }
//}
//
//extension ViewController : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        viewModel.didSelectItem(at: indexPath)
//    }
//}

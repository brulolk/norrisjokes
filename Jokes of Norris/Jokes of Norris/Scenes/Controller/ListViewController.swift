//
//  ListViewController.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 25/09/20.
//

import UIKit
import TinyConstraints

class ListViewController: BaseViewController {

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Tap the magnifying glass to start"
        label.textColor = .black
        label.font = UIFont(name: "System", size: 16)
        return label
    }()
    @IBOutlet weak var tableView: UITableView!
    
    var factViewModel: FactViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        factViewModel.getCategories()
    }
    
    func setupNavigation() {
        let searchItem = UIBarButtonItem(image: UIImage(named: "icSearch"), style: .plain, target: self, action: #selector(searchAction))
        searchItem.tintColor = .white
        let title = UILabel()
        title.text = factViewModel.title
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 20)
        let titleItem = UIBarButtonItem(customView: title)
        
        navigationItem.setRightBarButton(searchItem, animated: true)
        navigationItem.setLeftBarButton(titleItem, animated: false)
    }
    
    func setupView() {
        view.addSubview(label)
        label.centerInSuperview()
        tableView.isHidden = true
    }
    
    func setupTableView() {
        if factViewModel.facts.count == 0 {
            tableView.isHidden = true
            label.isHidden = false
            setupLabel()
        } else {
            label.isHidden = true
            tableView.delegate = self
            tableView.dataSource = self
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
    
    func setupLabel() {
        label.text = factViewModel.messageOfSearch
    }
    
    @objc func searchAction() {
        factViewModel.tappedSearch()
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factViewModel.facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "factCell", for: indexPath) as? FactsTableViewCell {
            cell.fact = factViewModel.facts[indexPath.row]
            cell.setupView()
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "factCell", for: indexPath)
            return cell
        }
    }
    
    
}

extension ListViewController: FactViewModelProtocol {
    
    func reloadTableView() {
        setupTableView()
    }
    
}

extension ListViewController: ShareFactDelegate {
    
    func shareFact(fact: Fact) {
        self.showProgress()
        guard let url = URL(string: fact.url) else {
            showAlert(title: "Sorry", message: "Not found fact in: \(fact.url)")
            return
        }
        let shareItens = [url]
        let activityViewController = UIActivityViewController(activityItems: shareItens, applicationActivities: nil)
        self.hideProgress()
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}

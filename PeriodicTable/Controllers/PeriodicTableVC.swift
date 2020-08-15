//
//  PeriodicTableVC.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 03/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit

class PeriodicTableVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var elements: [Element]!
    var filteredElements: [Element] = []
    var tableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, Element>!
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        configureNavigationController()
        configureSearchController()
        loadData()
        configureTableView()
        configureDataSource()
        updateData(with: elements, animated: false)
    }
    
    private func loadData() {
        DataLoadingManager.shared.loadData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let elements):
                self.elements = elements
            case .failure(let error):
                self.presentPTAlertOnMainThread(title: "Failed to load elements", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    private func configureSearchController() {
        searchController.searchResultsUpdater                   = self
        searchController.obscuresBackgroundDuringPresentation   = false
        searchController.searchBar.placeholder                  = "Search for elements"
        navigationItem.searchController                         = searchController
        navigationItem.hidesSearchBarWhenScrolling              = false
        definesPresentationContext                              = true
    }
    
    
    private func configureTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight                                 = 70
        tableView.separatorStyle                            = .none
        tableView.backgroundColor                           = .clear
        tableView.delegate                                  = self
        tableView.showsVerticalScrollIndicator              = true
        tableView.register(ElementCell.self, forCellReuseIdentifier: ElementCell.reuseID)
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
    
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, element) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: ElementCell.reuseID) as! ElementCell
            cell.set(element: element)
            return cell
        })
    }
    
    
    private func updateData(with elements: [Element], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Element>()
        snapshot.appendSections([.main])
        snapshot.appendItems(elements)
        
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    
    private func configureNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }

}

extension PeriodicTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedElement = dataSource.itemIdentifier(for: indexPath)
        let destVC          = ElementDetailsVC()
        destVC.element      = selectedElement
        destVC.title        = selectedElement?.name
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
    
}

extension PeriodicTableVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        var isSearchBarEmpty: Bool {
            return searchController.searchBar.text?.isEmpty ?? true
        }
        
        if !isSearchBarEmpty {
            filteredElements = elements.filter({ $0.name.lowercased().contains(searchController.searchBar.text!.lowercased()) })
        } else {
            filteredElements = elements
        }
        updateData(with: filteredElements, animated: true)
        
    }
    
        
}

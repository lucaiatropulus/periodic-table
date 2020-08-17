//
//  CalculateMolarMassVC.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 09/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit

class CalculateMolarMassVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var elements: [Element] = []
    var elementsInCompound : [Element] = []
    var atomicValues : [Element : Float] = [:]
    
    var tableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, Element>!
    
    var searchController        = UISearchController(searchResultsController: nil)
    let molarMassView           = PTMolarMassView(frame: .zero)
    let molarMassCategoryView   = PTCategoryView(categoryTitle: "Molar mass")
    let tableViewCategoryView   = PTCategoryView(categoryTitle: "Mass for each element")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    

    private func calculateMolarMass(for compound: String) -> Float {
        
        let finalCompound = Helper.shared.calculateGeneralMolarMass(for: compound)
        var sum: Float = 0
        
        if elements.isEmpty {
            DataLoadingManager.shared.loadData { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let elementsList):
                    self.elements = elementsList
                case .failure(let error):
                    self.presentPTAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }

        for element in elements {
            
            if let value = finalCompound.elementsCount[element.symbol] {
                var mutableValue = value
                
                if mutableValue == "" { mutableValue = "1" }
                
                if atomicValues[element] != nil {
                    atomicValues[element] = atomicValues[element]! + (Float(mutableValue)! * element.atomicMass)
                } else {
                    atomicValues[element] = Float(mutableValue)! * element.atomicMass
                }
                
                if !elementsInCompound.contains(element) {
                    elementsInCompound.append(element)
                }
                
                sum = sum + Float(mutableValue)! * element.atomicMass
            }
            
        }
        
        
        return sum
        
    }
    
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        configureSearchController()
        configureMolarMassCategoryView()
        configureMolarMassView()
        configureTableViewCategoryView()
        configureTableView()
        configureDataSource()
        updateData(with: elementsInCompound, animated: false)
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.delegate                     = self
        searchController.obscuresBackgroundDuringPresentation   = false
        searchController.searchBar.placeholder                  = "Search for a chemical compound"
        navigationItem.searchController                         = searchController
        navigationItem.hidesSearchBarWhenScrolling              = false
        definesPresentationContext                              = true
    }
    
    private func configureMolarMassCategoryView() {
        view.addSubview(molarMassCategoryView)
        NSLayoutConstraint.activate([
        
            molarMassCategoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            molarMassCategoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            molarMassCategoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        ])
    }
    
    private func configureMolarMassView() {
        view.addSubview(molarMassView)

        NSLayoutConstraint.activate([
        
            molarMassView.topAnchor.constraint(equalTo: molarMassCategoryView.bottomAnchor),
            molarMassView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            molarMassView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        ])
    }
    
    private func configureTableViewCategoryView() {
        view.addSubview(tableViewCategoryView)
        
        NSLayoutConstraint.activate([
        
            tableViewCategoryView.topAnchor.constraint(equalTo: molarMassView.bottomAnchor),
            tableViewCategoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewCategoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    
        ])
    }
    
    
    private func configureTableView() {
        
        tableView = UITableView(frame: .zero)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight                                 = 70
        tableView.separatorStyle                            = .none
        tableView.backgroundColor                           = .clear
        tableView.delegate                                  = self
        tableView.showsVerticalScrollIndicator              = true
        tableView.register(MolarMassDetailCell.self, forCellReuseIdentifier: MolarMassDetailCell.reuseID)
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: tableViewCategoryView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, element -> UITableViewCell? in
            guard let self = self else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: MolarMassDetailCell.reuseID) as! MolarMassDetailCell
            cell.set(element: element, atomicValues: self.atomicValues)
            return cell
        })
    }
    
    private func updateData(with elements: [Element], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Element>()
        snapshot.appendSections([.main])
        snapshot.appendItems(elements)
        
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    

}

extension CalculateMolarMassVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let element = dataSource.itemIdentifier(for: indexPath) else { return }
        let destVC = ElementDetailsVC()
        destVC.element = element
        destVC.title = element.name
        navigationController?.pushViewController(destVC, animated: true)
    }
}

extension CalculateMolarMassVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        var isSearchBarEmpty: Bool {
            return searchController.searchBar.text?.isEmpty ?? true
        }
        if !isSearchBarEmpty {
            updateData(with: elementsInCompound, animated: false)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        var isSearchBarEmpty: Bool {
            return searchController.searchBar.text?.isEmpty ?? true
        }
        
        if !isSearchBarEmpty {
            molarMassView.set(value: calculateMolarMass(for: searchBar.text!))
            updateData(with: elementsInCompound, animated: true)
            
        }
        
        elementsInCompound = []
        atomicValues = [:]
        
    }

}

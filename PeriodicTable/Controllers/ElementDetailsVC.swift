//
//  ElementDetailsVC.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 03/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit
import SafariServices

class ElementDetailsVC: UIViewController {
    
    var element: Element!
    
    private let scrollView = UIScrollView()
    private var stackView: UIStackView!
        
    private let generalCategoryView             = PTCategoryView(categoryTitle: CategoryTitles.general)
    private let propertiesCategoryView          = PTCategoryView(categoryTitle: CategoryTitles.properties)
    private let atomicPropertiesCategoryView    = PTCategoryView(categoryTitle: CategoryTitles.atomicProperties)
    private let reactivityCategoryView          = PTCategoryView(categoryTitle: CategoryTitles.reactivity)
    
    private let nameView            = PTPropertyView(propertyName: ElementProperties.name)
    private let symbolView          = PTPropertyView(propertyName: ElementProperties.symbol)
    private let categoryView        = PTPropertyView(propertyName: ElementProperties.category)
    private let appearanceView      = PTPropertyView(propertyName: ElementProperties.appearance)
    private let phaseView           = PTPropertyView(propertyName: ElementProperties.phase)
    private let discoveredbyView    = PTPropertyView(propertyName: ElementProperties.discoveredBy)
    private let namedbyView         = PTPropertyView(propertyName: ElementProperties.namedBy)
    private let electronShellView   = PTPropertyView(propertyName: ElementProperties.electronShell)
    
    private let atomicNumberView    = PTPropertyView(propertyName: ElementProperties.atomicNumber)
    private let atomicMassView      = PTPropertyView(propertyName: ElementProperties.atomicMass)
    private let densityView         = PTPropertyView(propertyName: ElementProperties.density)
    private let meltingPointView    = PTPropertyView(propertyName: ElementProperties.meltingPoint)
    private let boilingPointView    = PTPropertyView(propertyName: ElementProperties.boilingPoint)
    private let periodView          = PTPropertyView(propertyName: ElementProperties.period)
    
    private let electronConfigurationView           = PTPropertyView(propertyName: ElementProperties.electronConfiguration)
    private let electronConfigurationSemanticView   = PTPropertyView(propertyName: ElementProperties.electronConfigurationSemantic)
    
    private let electronegativityView   = PTPropertyView(propertyName: ElementProperties.electronegativity)
    private let electronAffinityView    = PTPropertyView(propertyName: ElementProperties.electronAffinity)
    
    private let wikipediaButtonView     = WikipediaButtonView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        configureNavigationController()
        configureScrollView()
        configureStackView()
        configureGeneralCategory()
        configurePropertiesCategory()
        configureAtomicPropertiesCategory()
        configureReactivityCategory()
        configureWikipediaButton()
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
        
    }
    
    private func configureStackView() {
        stackView = UIStackView(arrangedSubviews: [generalCategoryView, nameView, symbolView, categoryView, appearanceView, phaseView, discoveredbyView, namedbyView, electronShellView, propertiesCategoryView, atomicNumberView, atomicMassView, atomicMassView, densityView, meltingPointView, boilingPointView, periodView, atomicPropertiesCategoryView, electronConfigurationView, electronConfigurationSemanticView, reactivityCategoryView, electronegativityView, electronAffinityView, wikipediaButtonView])
        
        stackView.distribution = .fillProportionally
        stackView.spacing = .zero
        stackView.axis = .vertical
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        
        ])
        }
    
    private func configureGeneralCategory() {
        
        generalCategoryView.constrainToMargins(in: stackView)
        
        nameView.set(propertyValue: element.name)
        nameView.constrainToMargins(in: stackView)
        
        symbolView.set(propertyValue: element.symbol)
        symbolView.constrainToMargins(in: stackView)
        
        categoryView.set(propertyValue: element.category.capitalized)
        categoryView.constrainToMargins(in: stackView)
        
        let appearance = element.appearance != nil ? element.appearance!.capitalized : "Value not provided"
        appearanceView.set(propertyValue: appearance)
        appearanceView.constrainToMargins(in: stackView)
        
        phaseView.set(propertyValue: element.phase)
        phaseView.constrainToMargins(in: stackView)
        
        let discoveredBy = element.discoveredBy != nil ? element.discoveredBy! : "Value not provided"
        discoveredbyView.set(propertyValue: discoveredBy)
        discoveredbyView.constrainToMargins(in: stackView)
        
        let namedBy = element.namedBy != nil ? element.namedBy! : "Value not provided"
        namedbyView.set(propertyValue: namedBy)
        namedbyView.constrainToMargins(in: stackView)
        
        electronShellView.set(propertyValue: Helper.shared.determineElectronShellDistribution(for: element))
        electronShellView.constrainToMargins(in: stackView)
        
    }
    
    private func configurePropertiesCategory() {
        
        propertiesCategoryView.constrainToMargins(in: stackView)
        
        let atomicNumber = String(element.number)
        atomicNumberView.set(propertyValue: atomicNumber)
        atomicNumberView.constrainToMargins(in: stackView)
        
        let atomicMass = String(element.atomicMass)
        atomicMassView.set(propertyValue: atomicMass)
        atomicMassView.constrainToMargins(in: stackView)
        
        let density = element.density != nil ? String(element.density!) : "Value not provided"
        densityView.set(propertyValue: density)
        densityView.constrainToMargins(in: stackView)
        
        let meltingPoint = element.melt != nil ? String(element.melt!) : "Value not provided"
        meltingPointView.set(propertyValue: meltingPoint)
        meltingPointView.constrainToMargins(in: stackView)
        
        
        let boilingPoint = element.boil != nil ? String(element.boil!) : "Value not provided"
        boilingPointView.set(propertyValue: boilingPoint)
        boilingPointView.constrainToMargins(in: stackView)
        
        let period = String(element.period)
        periodView.set(propertyValue: period)
        periodView.constrainToMargins(in: stackView)
        
    }
    
    private func configureAtomicPropertiesCategory() {
        
        atomicPropertiesCategoryView.constrainToMargins(in: stackView)
        
        electronConfigurationView.set(propertyValue: element.electronConfiguration)
        electronConfigurationView.constrainToMargins(in: stackView)
        
        electronConfigurationSemanticView.set(propertyValue: element.electronConfigurationSemantic)
        electronConfigurationSemanticView.constrainToMargins(in: stackView)
        
    }
    
    private func configureReactivityCategory() {
        
        reactivityCategoryView.constrainToMargins(in: stackView)
        
        let electronegativity = element.electronegativityPauling != nil ? String(element.electronegativityPauling!) : "Value not provided"
        electronegativityView.set(propertyValue: electronegativity)
        electronegativityView.constrainToMargins(in: stackView)
        
        let electronAffinity = element.electronAffinity != nil ? String(element.electronAffinity!) : "Value not provided"
        electronAffinityView.set(propertyValue: electronAffinity)
        electronAffinityView.constrainToMargins(in: stackView)
    }
    
    private func configureWikipediaButton() {
        wikipediaButtonView.translatesAutoresizingMaskIntoConstraints = false
        wikipediaButtonView.delegate = self
        
        NSLayoutConstraint.activate([
        
            wikipediaButtonView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            wikipediaButtonView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        
        ])
    }
    
}

extension ElementDetailsVC: WikipediaButtonViewDelegate {
    
    func presentWikipediaPage() {
        guard let url = URL(string: element.source) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    
}

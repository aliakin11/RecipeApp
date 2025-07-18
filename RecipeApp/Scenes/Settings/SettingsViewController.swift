//
//  SettingsViewController.swift
//  NewsApp
//
//  Created by Ali AKIN on 3.07.2025.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {

    //MARK: - Properties
    
    private let viewModel: SettingsViewModel
    
    private let themeKey = "selectedTheme"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    init(viewModel: SettingsViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
       
    }
}

//MARK: - Objective Methods
@objc private extension SettingsViewController {
    
    func didChangeTheme(_ sender: UISegmentedControl) {
        updateThemeMode(to: sender.selectedSegmentIndex)
    }
}


//MARK: - Private Methods

private extension SettingsViewController {
    func configureView() {
        view.backgroundColor = .systemGroupedBackground
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateThemeMode(to mode: Int) {
        UserDefaults.standard.set(mode, forKey: themeKey)
        switch mode {
        case 1:
            view.window?.overrideUserInterfaceStyle = .light
        case 2:
            view.window?.overrideUserInterfaceStyle = .dark
        default :
            view.window?.overrideUserInterfaceStyle = .unspecified
        }
    }
    
    
}

//MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.tintColor = .label
        
        let section = viewModel.sections[indexPath.section]
        let item = section.items[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.textLabel?.textAlignment = .natural
        cell.textLabel?.textColor = .label
        cell.imageView?.image = UIImage(systemName: item.iconName)
        
        switch item.type {
        case .theme:
            let segmentedControl = UISegmentedControl(items: ["Auto","Light", "Dark"])
            segmentedControl.selectedSegmentIndex = viewModel.fetchThemeMode()
            segmentedControl.addTarget(self, action: #selector(didChangeTheme(_:)), for: .valueChanged)
            cell.accessoryView = segmentedControl
        
            
        case .rateApp, .privacyPolicy, .termsOfUse:
            cell.accessoryType = .disclosureIndicator
            
        }
        
        return cell
    }
    
    
}

//
//  FavoritesViewController.swift
//  RecipeApp
//
//  Created by Ali AKIN on 1.07.2025.
//

import UIKit

protocol FavoritesViewModelOutput: AnyObject {
    func updateFavoritesList()
    func showEmptyState(message: String)
}
    

class FavoritesViewController: UIViewController {
    
    
    private let viewModel: FavoritesViewModel
    
    // MARK: - UI Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    private lazy var emptyStateLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 18, weight: .medium)
            label.textColor = .secondaryLabel
            label.textAlignment = .center
            label.isHidden = true
            return label
        }()
    
    init(viewModel: FavoritesViewModel = FavoritesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.output = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        viewModel.fetchFavorites()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(emptyStateLabel)
        
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        emptyStateLabel.snp.makeConstraints { $0.center.equalToSuperview() }
    }
}

extension FavoritesViewController: FavoritesViewModelOutput {
    
    func updateFavoritesList() {
        
        tableView.isHidden = false
        emptyStateLabel.isHidden = true
        tableView.reloadData()
        
    }
    
    func showEmptyState(message: String) {
        
        emptyStateLabel.text = message
        tableView.isHidden = true
        emptyStateLabel.isHidden = false
    }
    
    
}


extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteMeals.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier) as? FavoriteCell else {
            fatalError("Unable to dequeue FavoriteCell")
    }
        
        let meal = viewModel.favoriteMeals[indexPath.row]
        cell.configure(with: meal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
                
        let meal = viewModel.favoriteMeals[indexPath.row]
        
        guard let mealID = meal.idMeal else {
            return
        }
                
        let detailViewModel = DetailViewModel(mealID: mealID)
        let detailVC = DetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}


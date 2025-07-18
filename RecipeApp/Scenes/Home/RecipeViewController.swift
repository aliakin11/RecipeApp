//
//  HomeViewController.swift
//  RecipeApp
//
//  Created by Ali AKIN on 30.06.2025.
//

import UIKit

protocol RecipeViewControllerProtocol: AnyObject {
    func reloadTableView()
    func reloadCollectionView()
}

class RecipeViewController: UIViewController {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let viewModel: RecipeViewModel
    
    // MARK: - UI Components
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.bounces = true
        
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.identifier)
        tableView.rowHeight = 100
        return tableView
    }()
    
    init(viewModel: RecipeViewModel = RecipeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
        viewModel.fetchCategories()
        
    }

}

extension RecipeViewController: RecipeViewControllerProtocol {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
}

// MARK: - Private Methods

private extension RecipeViewController {
    
    func setupUI() {
        
        view.backgroundColor = .systemBackground
        addViews()
        setupConstraints()
        
    }
    
    func addViews() {
        
        view.addSubview(collectionView)
        view.addSubview(tableView)
        
    }
    
    func setupConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
            
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.identifier, for: indexPath) as? RecipeCell else {
            fatalError("Unable to dequeue RecipeCell")
        }
        
        let meal = viewModel.meals[indexPath.row]
        cell.configure(with: meal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meals.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let meal = viewModel.meals[indexPath.row]
        let detailViewModel = DetailViewModel(mealID: meal.idMeal ?? "")
        let detailVC = DetailViewController(viewModel: detailViewModel)
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

// MARK: - UICollectionViewDelegate and UICollectionViewDataSource
extension RecipeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            fatalError("Unable to dequeue CategoryCell")
        }
        
        let category = viewModel.categories[indexPath.item]
        cell.configure(with: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = viewModel.categories[indexPath.item]
        viewModel.fetchRecipes(for: category.strCategory ?? "")
    }
}


#Preview {
    UINavigationController(rootViewController: RecipeViewController())
}

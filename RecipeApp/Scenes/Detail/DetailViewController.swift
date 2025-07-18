//
//  DetailViewController.swift
//  RecipeApp
//
//  Created by Ali AKIN on 3.07.2025.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func reloadData()
}
    

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: DetailViewModel
    
    
    // MARK: - UI Components
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var mealImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var favoriteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonTapped)
        )
        button.tintColor = .systemRed
        return button
    }()
    
    // MARK: - Initializer
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.fetchMealDetails()
        
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
}

extension DetailViewController: DetailViewControllerProtocol {
    @objc func favoriteButtonTapped() {
        viewModel.toggleFavorite()
        updateFavoriteButtonState()
    }
    
    private func updateFavoriteButtonState() {
        let isFavorite = viewModel.isCurrentMealFavorite()
        let iconName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.image = UIImage(systemName: iconName)
    }
        
    
    
    func reloadData() {
            DispatchQueue.main.async { [weak self] in
                guard let self = self,
                      let meal = self.viewModel.meal else { return }
                
                self.titleLabel.text = meal.strMeal
                self.categoryLabel.text = meal.strCategory
                self.instructionsLabel.text = meal.strInstructions
                
                if let imageURL = URL(string: meal.strMealThumb ?? "") {
                    self.mealImageView.kf.setImage(with: imageURL)
                }
                
                self.updateFavoriteButtonState()
            }
        }
}

private extension DetailViewController {
    
    func setupUI() {
        
        view.backgroundColor = .systemBackground
        addViews()
        setupConstraints()
        
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
                
        contentView.addSubview(mealImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(instructionsLabel)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
                
        contentView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                    make.leading.trailing.equalTo(view)
        }
                
        mealImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
                
       titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mealImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
                
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
                
        instructionsLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}

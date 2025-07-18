//
//  FavoriteCell.swift
//  RecipeApp
//
//  Created by Ali AKIN on 10.07.2025.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let identifier = "FavoriteCell"
    
    private var meal: Meal?
    
    // MARK: - UI Components
    private let favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(systemName: "photo.artframe")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Public Methods
extension FavoriteCell {
    func configure(with meal: Meal) {
        self.meal = meal
        titleLabel.text = meal.strMeal
        favoriteImageView.kf.setImage(with: URL(string: meal.strMealThumb ?? ""))
    }
}

// MARK: - Private Methods
private extension FavoriteCell {
    
    func setupUI() {
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        contentView.addSubview(favoriteImageView)
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        
        favoriteImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(80)
            
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(favoriteImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
}


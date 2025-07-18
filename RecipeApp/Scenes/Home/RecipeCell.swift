//
//  RecipeCell.swift
//  RecipeApp
//
//  Created by Ali AKIN on 1.07.2025.
//

import UIKit
import Kingfisher

class RecipeCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "RecipeCell"
    
    private var meal: Meal?
        
    
    // MARK: - UI Elements
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
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

//MARK: Public Methods

extension RecipeCell {
    
    func configure(with meal: Meal) {
        self.meal = meal
        titleLabel.text = meal.strMeal
        recipeImageView.kf.setImage(with: URL(string: meal.strMealThumb ?? ""))
    }
}

private extension RecipeCell {
    
    func setupUI() {
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        
        recipeImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(80)
            
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(recipeImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
}

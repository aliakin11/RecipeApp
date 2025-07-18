//
//  MealCollectionViewCell.swift
//  RecipeApp
//
//  Created by Ali AKIN on 1.07.2025.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    //MARK: UI Components
    private let categoryLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
            didSet {
                backgroundColor = isSelected ? .systemOrange : .secondarySystemBackground
            }
        }
    
    func configure(with category: Category) {
        categoryLabel.text = category.strCategory
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    
}

// MARK: - Private Methods
private extension CategoryCell {
    
    func setupUI() {
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        contentView.addSubview(categoryLabel)
    }
    
    func setupConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(12)
        }
    }
    
    func configureAppearance() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 20
        clipsToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
}



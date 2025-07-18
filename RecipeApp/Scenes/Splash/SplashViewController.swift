//
//  ViewController.swift
//  RecipeApp
//
//  Created by Ali AKIN on 30.06.2025.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    // MARK: - UI Components
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "fork.knife.circle.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe App"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigateToTabBar()
    }

}

// MARK: - Private Methods
private extension SplashViewController {
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(240)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
    
        }
    }
    
    func navigateToTabBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                return
            }
            
            let tabBarController = TabBarController()
            sceneDelegate.window?.rootViewController = tabBarController
            
        }
            
    }
    
    
}

#Preview {
    SplashViewController()
}






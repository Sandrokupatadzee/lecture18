//
//  SecondScreen.swift
//  lecture18
//
//  Created by MacBook Pro on 19.04.24.
//

import UIKit

class SecondScreen: UIViewController {
    
    private let news: News
    
    private let newsBackGroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let newsTime: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 10
        return label
    }()
    
    init(_ news: News) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure(with: news)
        
        self.view.backgroundColor = .white
        title = "Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupUI() {
        view.addSubview(newsBackGroundImage)
        view.addSubview(newsTime)
        view.addSubview(newsTitle)
        
        newsBackGroundImage.translatesAutoresizingMaskIntoConstraints = false
        newsTime.translatesAutoresizingMaskIntoConstraints = false
        newsTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            newsBackGroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            newsBackGroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newsBackGroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newsBackGroundImage.heightAnchor.constraint(equalToConstant: 200),
            
            newsTime.topAnchor.constraint(equalTo: newsBackGroundImage.bottomAnchor, constant: 20),
            newsTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            newsTitle.topAnchor.constraint(equalTo: newsTime.bottomAnchor, constant: 20),
            newsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newsTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
        
        newsBackGroundImage.layer.cornerRadius = 10
        newsBackGroundImage.layer.masksToBounds = true
    }
    
    private func configure(with news: News) {
        newsTime.text = news.time
        newsTitle.text = news.title
        
        guard let imageUrl = URL(string: news.photoUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            guard let self = self, let data = data, let image = UIImage(data: data), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.newsBackGroundImage.image = image
            }
            
        }.resume()
    }
}


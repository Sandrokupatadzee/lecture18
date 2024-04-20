//
//  NewsCell.swift
//  lecture18
//
//  Created by MacBook Pro on 19.04.24.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let identifier = "NewsCell"
    
    private var news: News?
    
    private let newsBackGroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let newsTime: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 4
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with news: News) {
        self.news = news
        newsTime.attributedText = attributedText(for: news.time)
        newsTitle.attributedText = attributedText(for: news.title)

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
    
    private func setupUI() {
        addSubview(newsBackGroundImage)
        addSubview(newsTime)
        addSubview(newsTitle)
        
        newsBackGroundImage.translatesAutoresizingMaskIntoConstraints = false
        newsTime.translatesAutoresizingMaskIntoConstraints = false
        newsTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsBackGroundImage.topAnchor.constraint(equalTo: topAnchor),
            newsBackGroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsBackGroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsBackGroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            newsTime.centerXAnchor.constraint(equalTo: centerXAnchor),
            newsTime.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            
            newsTitle.topAnchor.constraint(equalTo: newsTime.bottomAnchor, constant: 8),
            newsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            newsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
    
    private func attributedText(for text: String) -> NSAttributedString {
            let strokeTextAttributes: [NSAttributedString.Key: Any] = [
                .strokeColor: UIColor.black,
                .foregroundColor: UIColor.white,
                .strokeWidth: -4.0,
                .font: UIFont.boldSystemFont(ofSize: 22)
            ]
            return NSAttributedString(string: text, attributes: strokeTextAttributes)
        }
    
}

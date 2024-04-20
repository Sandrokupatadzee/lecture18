//
//  MainScreen.swift
//  lecture18
//
//  Created by MacBook Pro on 19.04.24.
//

import UIKit

class MainScreen: UIViewController {
    
    private var news: [News] = []
    private let urlString = "https://imedinews.ge/api/categorysidebarnews/get"
    private let spaceBetweenSections: CGFloat = 20.0
    
    private let tableView: UITableView = {
        let screenTableView = UITableView()
        screenTableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        return screenTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "HOT NEWS"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        self.setupUI()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        NetworkService().getData(urlString: urlString) { (result: Result<NewsData, Error>) in
            switch result {
            case .success(let success):
                self.news = success.list
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    // MARK: functions
    
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
            
        ])
    }
}
// MARK: extensions

extension MainScreen: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else {
            fatalError("vai, vai, vai")
        }
        let news = self.news[indexPath.section]
        cell.configure(with: news)
        cell.backgroundColor = UIColor.white
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return spaceBetweenSections
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let selectedNews = self.news[indexPath.section]
        let nextScreen = SecondScreen(selectedNews)
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }
}



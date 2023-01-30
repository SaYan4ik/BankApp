//
//  NewsController.swift
//  BankMap
//
//  Created by Александр Янчик on 24.01.23.
//

import UIKit

class NewsController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var news = [NewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBankNews()
        registrationCell()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func getBankNews() {
        GetBankInfo().getNewsForBank { [weak self] news in
            guard let self else { return }
            self.news = news
            self.tableView.reloadData()
        }
    }
    
    private func registrationCell() {
        let nib = UINib(nibName: NewsCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NewsCell.id)
    }
}

extension NewsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.id, for: indexPath)
        guard let newsCell = cell as? NewsCell else { return cell }
        newsCell.set(news: news[indexPath.row])
        return newsCell
    }
}

extension NewsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = news[indexPath.row].link
        if let url = URL(string: urlString) {
            UIApplication.shared.openURL(url)
        }
    }
}

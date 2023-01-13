//
//  DetailReviewListView.swift
//  Movflix
//
//  Created by Sigit on 13/01/23.
//

import UIKit

class DetailReviewListView: BaseView {
    
    private lazy var reviewTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DetailReviewTableViewCell.self, forCellReuseIdentifier: DetailReviewTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    public var presenter: DetailPresenter?
    public var idMovie: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = DetailConstant.review
        configureConstraint()
        fetchData()
    }
    
    private func configureConstraint() {
        view.addSubview(reviewTableView)
        reviewTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        reviewTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        reviewTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        reviewTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func fetchData() {
        guard let idMovie = idMovie else { return }
        DispatchQueue.global().async {
            self.presenter?.getReviewsMovie(idMovie: idMovie)
        }
    }

}

extension DetailReviewListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.reviews.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailReviewTableViewCell.identifier, for: indexPath) as! DetailReviewTableViewCell
        if let review = presenter?.reviews[indexPath.row] {
            cell.configure(object: review)
        }
        return cell
    }
    
    
}

extension DetailReviewListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DetailReviewListView: PresenterToViewProtocol {
    func successLoadData<T>(object: T?) {
        DispatchQueue.main.async {
            self.reviewTableView.reloadData()
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startActivityIndicator(from: self)
        }
    }
    
    func dismissLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func failedLoadData(Error: Error) {
        DispatchQueue.main.async {
            self.showAlert(message: Error.localizedDescription) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

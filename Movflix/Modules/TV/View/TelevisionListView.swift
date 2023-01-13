//
//  TelevisionListView.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import UIKit
import UIScrollView_InfiniteScroll

class TelevisionListView: BaseView {
    
    private lazy var tvTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    public var presenter: TVListPresenter?
    public var router: TVRouter?
    
    public var category: TVCategory = .onAir
    
    private let activityIndicator = UIActivityIndicatorView()
    private var isLoadMore = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureConstraint()
        initInfiniteScroll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = category.description
        fetchData()
    }
    
    private func configureConstraint() {
        view.addSubview(tvTableView)
        tvTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tvTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tvTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tvTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func fetchData() {
        DispatchQueue.global().async {
            self.presenter?.getListTVShow(category: self.category)
        }
    }
    
    private func initInfiniteScroll() {
        tvTableView.infiniteScrollDirection = .vertical
        tvTableView.addInfiniteScroll { tableView in
            DispatchQueue.global().async {
                self.isLoadMore = true
                self.presenter?.loadMoreTVShow(category: self.category)
            }
        }
    }
    
}

extension TelevisionListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.listTV.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        if let movies = presenter?.listTV[indexPath.row] {
            cell.configure(object: movies)
        }
        return cell
    }
    
    
}

extension TelevisionListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let idTV = presenter?.listTV[indexPath.row].id else { return }
        router?.pushToDetail(from: self, idTV: idTV)
    }
}

extension TelevisionListView: PresenterToViewProtocol {
    func successLoadData<T>(object: T?) {
        DispatchQueue.main.async {
            if self.isLoadMore {
                self.isLoadMore = false
                self.tvTableView.finishInfiniteScroll()
                
                guard let indexPaths = self.presenter?.indexPaths else { return }
                self.tvTableView.beginUpdates()
                self.tvTableView.insertRows(at: indexPaths, with: .fade)
                self.tvTableView.endUpdates()
            } else {
                self.tvTableView.reloadData()
            }
            
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            if !self.isLoadMore {
                self.activityIndicator.startActivityIndicator(from: self)
            }
        }
    }
    
    func dismissLoading() {
        DispatchQueue.main.async {
            if !self.isLoadMore {
                self.activityIndicator.stopAnimating()
            }
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

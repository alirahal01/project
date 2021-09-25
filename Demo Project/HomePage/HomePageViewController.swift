//
//  HomePageViewController.swift
//  Demo Project
//
//  Created by Ali Rahal on 9/25/21.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class TableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class HomePageViewController: UIViewController {
    private let tableView = UITableView()
    private let cellIdentifier = "cellIdentifier"
    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()

    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for university"
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureProperties()
        configureLayout()
        configureReactiveBinding()
    }

    private func configureProperties() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        navigationItem.searchController = searchController
        navigationItem.title = "University finder"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.contentInset.bottom = view.safeAreaInsets.bottom
    }

    private func configureReactiveBinding() {
//        searchController.searchBar.rx.text.asObservable()
//            .map { ($0 ?? "").lowercased() }
//            .map { ImageRequest(tags: "flower") }
//            .flatMapLatest { [unowned self] request -> Observable<[PostModel]> in
////                return self.apiClient.send(apiRequest: request)
//            }
//            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { index, model, cell in
//                print(model)
////                cell.textLabel?.text = model.
////                cell.detailTextLabel?.text = model.comments
//                cell.textLabel?.adjustsFontSizeToFitWidth = true
//            }
//            .disposed(by: disposeBag)

    }
}

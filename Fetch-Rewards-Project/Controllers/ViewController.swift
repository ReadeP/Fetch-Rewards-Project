//
//  ViewController.swift
//  Fetch-Rewards-Project
//
//  Created by Reade Plunkett on 11/10/20.
//

import UIKit
import SnapKit

struct TableViewSection {
    let id: Int
    let items: [Item]
}

class ViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var tableSections = [TableViewSection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        createTableView()

        getItems()
    }

    private func createTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "itemCell")
        tableView.register(ItemTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "itemHeader")
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func getItems() {
        NetworkManager.shared.getItems { result in
            switch result {
            case .success(var items):
                items = items.filter({ $0.name != nil && !$0.name!.isEmpty })

                Set(items.map({ $0.listId })).forEach { section in
                    var sectionItems = items.filter({ $0.listId == section })
                    sectionItems.sort(by: { $0.id < $1.id })
                    self.tableSections.append(TableViewSection(id: section, items: sectionItems))
                }

                self.tableSections.sort(by: { $0.id < $1.id })

                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableSections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        cell.configure(item: tableSections[indexPath.section].items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "itemHeader") as! ItemTableViewHeader
        headerView.configure(section: tableSections[section])
        return headerView
    }

}


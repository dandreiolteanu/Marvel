//
//  UITableView+Reusable.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit

extension UITableView {

    // MARK: - Public Methods
    
    func register<T: UITableViewCell>(cellType: T.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard and that you registered the cell beforehand."
            )
        }
        return cell
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type) {
        register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T? {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T? else {
            fatalError(
                "Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) matching type \(viewType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard and that you registered the header/footer beforehand."
            )
        }
        return headerFooterView
    }
}

extension UITableViewCell: Reusable { }
extension UITableViewHeaderFooterView: Reusable { }

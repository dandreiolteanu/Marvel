//
//  Typealiases.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import UIKit

typealias CharactersListDiffableDataSource = UITableViewDiffableDataSource<CharactersListViewModelImpl.Section, CharacterListCellViewModel>
typealias CharactersListDiffableSnapshot = NSDiffableDataSourceSnapshot<CharactersListViewModelImpl.Section, CharacterListCellViewModel>

typealias BoolReturnClosure = () -> Bool

//
//  Typealiases.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import UIKit

typealias CharactersListDiffableDataSource = UITableViewDiffableDataSource<CharactersListSection, CharactersListSection.Item>
typealias CharactersListDiffableSnapshot = NSDiffableDataSourceSnapshot<CharactersListSection, CharactersListSection.Item>

typealias CharacterDetailsDiffableDataSource = UICollectionViewDiffableDataSource<CharacterDetailsSection, CharacterDetailsSection.Item>
typealias CharacterDetailsDiffableSnapshot = NSDiffableDataSourceSnapshot<CharacterDetailsSection, CharacterDetailsSection.Item>

typealias BoolReturnClosure = () -> Bool

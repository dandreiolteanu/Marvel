//
//  CharacterDetailsCompositionalLayout.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import UIKit

final class CharacterDetailsCompositionalLayout: UICollectionViewCompositionalLayout {
    
    // MARK: - Initialization
    
    init(layoutTypeProvider: @escaping (Int) -> CharacterDetailsSection.LayoutType) {
        super.init(sectionProvider: { index, environment in
            let section = layoutTypeProvider(index).section(environment: environment)
            section.supplementariesFollowContentInsets = false
            return section
        }, configuration: {
            let configuration = UICollectionViewCompositionalLayoutConfiguration()
            configuration.interSectionSpacing = .padding2x
            return configuration
        }())
    }
    
    init(layoutType: CharacterDetailsSection.LayoutType) {
        super.init(sectionProvider: { _, environment in
            let section = layoutType.section(environment: environment)
            section.supplementariesFollowContentInsets = false
            return section
        }, configuration: {
            let configuration = UICollectionViewCompositionalLayoutConfiguration()
            configuration.interSectionSpacing = .padding2x
            return configuration
        }())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - NSCollectionLayoutSection Provider

extension CharacterDetailsSection.LayoutType {
    
    func section(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch self {
        case .squareWithFullWidthList:            
            let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
            let item = NSCollectionLayoutItem(layoutSize: layoutSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        case .fullWidthList(let isHeaderAvailable):
            let estimatedHeight: CGFloat = 44
            
            let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight))
            let item = NSCollectionLayoutItem(layoutSize: layoutSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            if isHeaderAvailable {
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
                let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: TitleCollectionReusableView.reuseIdentifier, alignment: .top)
                section.boundarySupplementaryItems = [headerElement]
            }
            
            return section
        case .gridVertical(let isHeaderAvailable):
            let columns: CGFloat = 2
            let padding: CGFloat = .padding2x
            let sectionPaddings = 2 * padding
            let itemTotalPaddings = (columns - 1) * (padding / 2)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(environment.container.contentSize.width / columns - (sectionPaddings - itemTotalPaddings)),
                                                  heightDimension: .estimated(100))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .flexible(0)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = padding
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding)
        
            if isHeaderAvailable {
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
                let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: TitleCollectionReusableView.reuseIdentifier, alignment: .top)
                section.boundarySupplementaryItems = [headerElement]
            }
            
            return section
        }
    }
}

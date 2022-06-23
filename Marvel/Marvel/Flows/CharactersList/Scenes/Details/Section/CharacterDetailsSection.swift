//
//  CharacterDetailsSection.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import Foundation

// MARK: - Section

struct CharacterDetailsSection: Hashable {
    
    // MARK: - SectionType
    
    enum `Type`: Hashable {
        
        // MARK: - Cases
        
        case header
        case personalInformation
        case comics
    }
    
    // MARK: - Item
    
    enum Item: Hashable {
        
        // MARK: - Cases
        
        case headerItem(CharacterListCellViewModel)
        case descriptionItem(String)
        case comicsItem(CharacterComicCellViewModel)
    }
    
    // MARK: - LayoutType
    
    enum LayoutType {
        
        // MARK: - Cases
        
        case squareWithFullWidthList
        case fullWidthList(isHeaderAvailable: Bool)
        case gridVertical(isHeaderAvailable: Bool)
        
        // MARK: - Static Properties
        
        static let fullWidthList: LayoutType = .fullWidthList(isHeaderAvailable: false)
        static let gridVertical: LayoutType = .gridVertical(isHeaderAvailable: false)
    }
    
    // MARK: - Public Properties
    
    let type: Type
    let title: String?
    
    var layoutType: LayoutType {
        switch type {
        case .header:
            return .squareWithFullWidthList
        case .personalInformation:
            return .fullWidthList(isHeaderAvailable: title != nil)
        case .comics:
            return .gridVertical(isHeaderAvailable: title != nil)
        }
    }

    // MARK: - Static Properties

    static let header = Self(type: .header)
    static let personalInformation = Self(type: .personalInformation, title: L10n.Characters.personalInformationSectionTitle)
    static let comics = Self(type: .comics, title: L10n.Characters.comicsSectionTitle)
    
    // MARK: - Init
    
    init(type: Type, title: String? = nil) {
        self.type = type
        self.title = title
    }
}

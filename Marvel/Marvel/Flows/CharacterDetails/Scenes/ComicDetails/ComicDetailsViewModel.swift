//
//  ComicDetailsViewModel.swift
//  Marvel
//
//  Created by Andrei Olteanu on 24.06.2022.
//

import Foundation

protocol ComicDetailsFlowDelegate: AnyObject {
    func shouldCloseComicDetails()
}

protocol ComicDetailsViewModelInputs {
    func closeTouched()
}

protocol ComicDetailsViewModelOutputs {
    var title: String { get }
    var imageURL: URL? { get }
}

protocol ComicDetailsViewModel: ObservableObject {
    var inputs: ComicDetailsViewModelInputs { get }
    var outputs: ComicDetailsViewModelOutputs { get }
}

final class ComicDetailsViewModelImpl: ComicDetailsViewModel, ComicDetailsViewModelInputs, ComicDetailsViewModelOutputs {

    // MARK: - FlowDelegate

    weak var flowDelegate: ComicDetailsFlowDelegate?

    // MARK: - Inputs

    var inputs: ComicDetailsViewModelInputs { self }
    
    // MARK: - Outputs

    var outputs: ComicDetailsViewModelOutputs { self }

    @Published var title: String
    @Published var imageURL: URL?

    // MARK: - Init

    init(characterComic: MarvelComic) {
        self.title = characterComic.title ?? L10n.Characters.emptyComicTitlePlaceholder
        self.imageURL = characterComic.thumbnail?.url
    }

    // MARK: - Public Methods

    func closeTouched() {
        flowDelegate?.shouldCloseComicDetails()
    }
}

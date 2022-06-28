//
//  ComicDetailsView.swift
//  Marvel
//
//  Created by Andrei Olteanu on 24.06.2022.
//

import SwiftUI
import Kingfisher

struct ComicDetailsView<ViewModel: ComicDetailsViewModel>: View {

    // MARK: - Public Properties

    @ObservedObject var viewModel: ViewModel

    // MARK: - Body

    var body: some View {
        ZStack {
            
            VStack(alignment: .center, spacing: .padding3x) {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        viewModel.inputs.closeTouched()
                    }, label: {
                        Image(Asset.icnClose.name)
                    })
                }
                .padding(.top, .padding)

                Spacer()

                KFImage(viewModel.outputs.imageURL)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 300)

                Text(viewModel.outputs.title)
                    .font(Font(.bodyMedium))
                    .foregroundColor(Color(.primaryText))
                    .multilineTextAlignment(.center)

                Spacer()
            }
        }
        .foregroundColor(Color(.clear))
        .padding([.leading, .trailing], .padding3x)
        .preferredColorScheme(.dark)
    }
}

struct ComicDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let characterComic = MarvelComic(id: 100,
                                         title: "Avengers: The Initiative (2007) #19",
                                         thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/d/03/58dd080719806",
                                                              extension: "jpg"))
        return ComicDetailsView(viewModel: ComicDetailsViewModelImpl(characterComic: characterComic))
    }
}

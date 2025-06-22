//
//  ProductRow.swift
//  StockIt
//
//  Created by Ignacio Galliano on 28/02/2025.
//

import SwiftUI

struct ProductRow: View {
    private let product: ProductModel
    private let delegate: ProductListViewDelegate

    init(product: ProductModel,
         delegate: ProductListViewDelegate) {
        self.product = product
        self.delegate = delegate
    }

    var body: some View {
        HStack(alignment: .top) {
            let url = URL(string: product.photo)
            AsyncImage(url: url) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: Constants.imageDimensions, height: Constants.imageDimensions)
                        .cornerRadius(Constants.commonRadius)
                }
                else {
                    Rectangle()
                        .frame(width: Constants.imageDimensions, height: Constants.imageDimensions)
                        .cornerRadius(Constants.commonRadius)
                        .foregroundColor(.gray)
                }
            }
            Text(product.name)
                .foregroundColor(.black)
                .font(.callout)
                .lineLimit(Constants.nameMaxeLines)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .padding(.top, Constants.commonPadding)
                .accessibilityIdentifier(Constants.productTitleIdentifier)

        }
        .frame(height: Constants.rowHeight, alignment: .top)
        .frame(maxWidth: .infinity)
        .padding([.leading, .top], Constants.commonPadding)
        .background(Rectangle().fill(Color.white))
        .foregroundColor(.white)
        .cornerRadius(Constants.commonRadius)
        .shadow(color: .gray,
                radius: Constants.shadowRadius,
                x: Constants.shadowXRadius,
                y: Constants.shadowYRadius)
        .onTapGesture {
            delegate.rowTapped(product: product)
        }
    }
}

fileprivate struct Constants {
    static let imageDimensions: CGFloat = 70
    static let commonRadius: CGFloat = 10
    static let commonPadding: CGFloat = 10
    static let rowHeight: CGFloat = 100
    static let nameMaxeLines: Int = 1
    static let shadowRadius: CGFloat = 3
    static let shadowXRadius: CGFloat = 2
    static let shadowYRadius: CGFloat = 2
    static let productTitleIdentifier: String = "ProductCellTitle"
}

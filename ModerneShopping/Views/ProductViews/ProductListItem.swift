//
//  ProductListItem.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import Clickstream
import SwiftUI
import Firebase

struct ProductListItem: View {
    let product: Product
    var body: some View {
        VStack {
            SmallProductImage(imageURL: product.imageURL)
            Text(product.title)
                .foregroundColor(.darkText)
                .bold()
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Text("\(product.price.format(f: ".2"))$").bold()
                .foregroundColor(.darkText)
            HStack(spacing: 2) {
                Text("\(product.formatedRating)").font(.title3)
                    .foregroundColor(.darkText)
                Text("(\(product.rating.count))").font(.caption2)
                    .foregroundColor(.secondary)
                    .offset(y: 3)
            }
        }.padding(8).onAppear {
            let attributes: ClickstreamAttribute = [
                "product_id": product.id,
                "product_title": product.title,
                "product_price": product.price,
                "product_category": product.category,
            ]
            ClickstreamAnalytics.recordEvent(eventName: "product_exposure", attributes: attributes)
            Analytics.logEvent("product_exposure", parameters: attributes)
        }
    }
}

struct ProductListItem_Previews: PreviewProvider {
    static var previews: some View {
        ProductListItem(product: Product.sampleProducts[0])
    }
}

struct SmallProductImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 170, height: 190, alignment: .center)
                .cornerRadius(12)
                .overlay(
                    ZStack {
                        ProgressView()
                        if imageLoader.image != nil {
                            HStack {
                                Spacer()
                                Image(uiImage: imageLoader.image!)
                                    .resizable()
                                    .compositingGroup()
                                    .aspectRatio(contentMode: .fit)
                                Spacer()
                            }
                        }
                    }.padding()
                )
        }
        .cornerRadius(12)
        .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}

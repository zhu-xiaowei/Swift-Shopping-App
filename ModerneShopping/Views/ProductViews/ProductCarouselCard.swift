//
//  ProductCarouselCard.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-08.
//

import Clickstream
import Firebase
import SwiftUI

struct ProductCarouselCard: View {
    let product: Product
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack {
                    ProductCarouselImage(imageURL: product.imageURL)
                    VStack(alignment: .leading) {
                        Text(product.title)
                            .font(.subheadline)
                            .lineLimit(3)
                        Text("\(product.price.format(f: ".2"))$")
                            .bold()
                            .padding(4)
                        HStack(spacing: 2) {
                            Text("\(product.formatedRating)")
                                .font(.footnote)
                            Text("(\(product.rating.count))")
                                .font(.caption)
                                .offset(y: 2)
                        }
                    }.foregroundColor(.darkText)
                    Spacer()
                }
                Color.secondaryBackground
                    .blendMode(.overlay)
            }.frame(height: 140)
                .cornerRadius(18)
                .shadow(color: .darkText.opacity(0.1), radius: 4, x: 1, y: 2).onAppear {
                    if !isViewCovered(in: geometry) {
                        let event_uuid = UUID().uuidString
                        let event_timestamp = Date().timestamp
                        let attributes: ClickstreamAttribute = [
                            "product_id": product.id,
                            "product_title": product.title,
                            "product_price": product.price,
                            "product_category": product.category,
                            "event_uuid": event_uuid,
                            "event_timestamp": event_timestamp
                        ]
                        ClickstreamAnalytics.recordEvent("product_exposure", attributes)
                        Analytics.logEvent("product_exposure", parameters: attributes)
                        AppDelegate.addEvent()
                    }
                }
        }
    }

    func isViewCovered(in geometry: GeometryProxy) -> Bool {
        let viewFrame = geometry.frame(in: .global)
        return viewFrame.origin.y < 0 || ProductView.isShow
    }
}

struct ProductCarouselCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCarouselCard(product: Product.sampleProducts[2])
    }
}

struct ProductCarouselImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 100, height: 140, alignment: .center)
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
                                    .clipped(antialiased: true)
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .cornerRadius(12)
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                )
        }
        .cornerRadius(12)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}

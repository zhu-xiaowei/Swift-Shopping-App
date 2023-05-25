//
//  MainView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import Clickstream
import SwiftUI

struct MainView: View {
    @StateObject var products = ProductsListObject()
    @StateObject var cartItems = CartViewModel()
    @StateObject var user = UserViewModel()
    var body: some View {
        TabView {
            HomeView(productsList: products, user: user).environmentObject(cartItems)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.onAppear {
                    ClickstreamAnalytics.recordEvent(eventName: "view_home")
                }
            CartView(cartProducts: cartItems)
                .environmentObject(user)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }.onAppear {
                    ClickstreamAnalytics.recordEvent(eventName: "view_cart")
                }
            ProfilView()
                .environmentObject(user)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }.onAppear {
                    ClickstreamAnalytics.recordEvent(eventName: "view_profile")
                }
        }
        .zIndex(10)
    }

    enum Tab {
        case home, cart, profile
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

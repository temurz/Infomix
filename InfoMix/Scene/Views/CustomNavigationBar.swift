//
//  CustomNavigationBar.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 21/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import SwiftUI
import Combine
struct CustomNavigationBar: View {
    var title: String
    var backButtonColor: Color = Colors.appMainColor
    var rightBarTitle: String?
    var rightBarImage: String?
    var onBackTapAction: () -> Void
    var onRightBarButtonTapAction: (() -> Void)?

    var body: some View {
        VStack {
            ViewWithShadowOnBottom {
                HStack {
                    ZStack {
                            Text(title)
                                .font(.headline)
                                .truncationMode(.middle)
                                .foregroundStyle(.black)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width - 80)
                        HStack {
                            Button {
                                onBackTapAction()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .foregroundStyle(backButtonColor)
                                    .aspectRatio(contentMode: .fit)
//                                    .background(Color.white)
                                    .padding(2)
                            }
                            .frame(width: 24, height: 24)
                            .padding(.leading)

                            Spacer(minLength: 10)
                            Text(title)
                                .font(.headline)
                                .foregroundStyle(.clear)
                                .padding()
                            Spacer(minLength: 10)
                            if let rightBarImage {
                                Image(rightBarImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(Colors.appMainColor)
                                    .frame(width: 24, height: 24)
                                    .onTapGesture {
                                        onRightBarButtonTapAction?()
                                    }
                                    .padding()
//                                    .background(Color.white)
                            } else if let rightBarTitle {
                                Text(rightBarTitle)
                                    .foregroundStyle(Colors.appMainColor)
                                    .font(.callout)
                                    .lineLimit(1)
                                    .bold()
                                    .onTapGesture {
                                        onRightBarButtonTapAction?()
                                    }
                                    .padding(.trailing)
//                                    .background(Color.white)
                            }
                        }
                    }
                }
            }
        }
        .background(Color.white)
    }
}

struct CustomNavigationBarWithMenu<Content: View>: View {
    var title: String
    var menu: Content
    var backButtonColor: Color = Colors.appMainColor
    var onBackTapAction: () -> Void

    var body: some View {
        VStack {
            ViewWithShadowOnBottom {
                HStack {
                    Button {
                        onBackTapAction()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .foregroundStyle(backButtonColor)
                            .aspectRatio(contentMode: .fit)
                            .background(Color.white)
                            .padding(2)
                    }
                    .frame(width: 24, height: 24)
                    .padding()

                    Spacer()

                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)

                    Spacer()

                    menu
                        .padding(.trailing)
                }
            }

        }
        .background(Color.white)
    }
}


struct ModuleNavigationBar: View {
    var title: String
    var rightBarTitle: String?
    var rightBarImage: String?
    var onRightBarButtonTapAction: (() -> Void)?

    var body: some View {
        VStack {
            ViewWithShadowOnBottom {
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.black)
                        .padding()
                    Spacer()
                    if let rightBarImage {
                        Image(rightBarImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Colors.appMainColor)
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                onRightBarButtonTapAction?()
                            }
                            .padding(8)
                            .background(Color.white)
                    } else if let rightBarTitle {
                        Text(rightBarTitle)
                            .foregroundStyle(Colors.appMainColor)
                            .font(.callout)
                            .lineLimit(1)
                            .bold()
                            .onTapGesture {
                                onRightBarButtonTapAction?()
                            }
                            .padding()
                            .background(Color.white)
                    }
                }
            }
        }
        .background(Color.white)

    }
}

struct ViewWithShadowOnBottom<Content: View>: View {

    var content: () -> Content
    var body: some View {
        VStack {

            content()
            Spacer()
            Colors.borderGrayColor2
                .frame(height: 1)
                .shadow(color: .black.opacity(0.1),radius: 1, x: 0, y: 1)
        }
        .frame(height: 62)

    }
}

func getTopSafeAreaInset() -> CGFloat {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else {
        return 0
    }
    return window.safeAreaInsets.top
}

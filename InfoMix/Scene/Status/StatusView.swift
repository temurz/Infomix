//
//  StatusView.swift
//  InfoMix
//
//  Created by Temur on 16/12/2024.
//  Copyright © 2024 InfoMix. All rights reserved.
//

import SwiftUI
import Localize_Swift
import Combine
struct StatusView: View {
    @ObservedObject var output: StatusViewModel.Output
    private let popViewTrigger = PassthroughSubject<Void, Never>()
    private let loadTrigger = PassthroughSubject<Void, Never>()
    private let loadLoyaltyTrigger = PassthroughSubject<Void, Never>()
    private let loadMoreTrigger = PassthroughSubject<Void, Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            ZStack(alignment: .top) {
                RoundedCorner(color: Colors.appMainColor, tl: 0, tr: 0, bl: 0, br: 60)
                    .frame(maxWidth: .infinity, maxHeight: 240)
                    .ignoresSafeArea(.all)
                VStack {
                    HStack {
                        Button {
                            popViewTrigger.send(())
                        } label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .foregroundStyle(.white)
                                .aspectRatio(contentMode: .fit)
                                .padding(4)
                        }
                        .frame(width: 24, height: 24)
                        .padding(.leading)
                        Spacer()
                    }

                    VStack {
                        Text("Your level".localized())
                            .foregroundStyle(Color.secondary)
                            .padding(.top)
                        if (output.loyalty?.id ?? 0) == 0 {
                                Image("na_icon")
                                    .resizable()
                                    .centerCropped()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(radius: 30, corners: .allCorners)
                        } else {
                            if let iconUrl = output.loyalty?.icon {
                                if let url = URL(string: iconUrl) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .centerCropped()
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(radius: 30, corners: .allCorners)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                        }

                        Text(output.loyalty?.displayName() ?? "")
                            .font(.body)
                            .bold()
                            .foregroundStyle(Color.primary)

                        Text(output.loyalty?.displayDescription() ?? "")
                            .font(.footnote)
                            .bold()
                            .padding(.top, 4)
                            .multilineTextAlignment(.center)

                        if let loyalty = output.loyalty {
                            HStack {
                                ZStack {
                                    Capsule()
                                        .fill(Colors.appMainColor.opacity(0.3))
                                        .frame(height: 30)

                                    GeometryReader { geometry in
                                        let progress = CGFloat(loyalty.serialCardCount ?? 0) / CGFloat(loyalty.nextLevel?.targetCount ?? 1)
                                        Capsule()
                                            .fill(Colors.appMainColor)
                                            .frame(width: geometry.size.width * progress, height: 30)
                                    }
                                    .frame(height: 30)

                                    Text("\(loyalty.serialCardCount ?? 0)/\(loyalty.nextLevel?.targetCount ?? 0)")
                                        .foregroundStyle(.white)
                                        .bold()
                                        .frame(maxWidth: .infinity)
                                        .padding(4)
                                }
                                .frame(height: 30)
                                .cornerRadius(15)
                                if let iconUrl = output.loyalty?.nextLevel?.icon {
                                    if let url = URL(string: iconUrl) {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .centerCropped()
                                                .frame(width: 36, height: 36)
                                                .cornerRadius(radius: 18, corners: .allCorners)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                } else {
                                    Image("na_icon")
                                        .resizable()
                                        .centerCropped()
                                        .frame(width: 36, height: 36)
                                        .cornerRadius(radius: 18, corners: .allCorners)
                                }
                            }
                            .padding()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                    .padding(12)

                    HStack {
                        Text("Leaderboard".localized())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title3)
                            .bold()
                            .padding()
                        Spacer()
                        if output.page > 0 {
                            Button {
                                output.page -= 1
                                loadTrigger.send(())
                            } label: {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(Colors.appMainColor)
                                    .frame(width: 20, height: 20)
                                    .padding(.vertical, 8)
                                    .padding(.trailing, 4)
                            }
                            .padding(.trailing)
                        }
                        if output.hasMorePages {
                            Button {
                                output.page += 1
                                loadTrigger.send(())
                            } label: {
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(Colors.appMainColor)
                                    .frame(width: 20, height: 20)
                                    .padding(.vertical, 8)
                                    .padding(.trailing, 4)
                            }
                            .padding(.trailing)
                        }
                    }
                    .background(Colors.lightGrayColor)
                    ZStack(alignment: .center) {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(output.leaderboard, id: \.position) { loyalUser in
                                    LoyalUserRow(loyalUser: loyalUser)
                                        .frame(maxWidth: .infinity)
                                        .background(.white)
                                        .cornerRadius(radius: 12, corners: .allCorners)
                                        .shadow(radius: 1, y: 1)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .onAppear {
                                            if output.leaderboard.last?.masterId ?? -1 == loyalUser.masterId && output.hasMorePages {
                                                self.loadMoreTrigger.send()
                                            }
                                        }
                                }
                            }
                        }
                        if output.isLoadingUsers {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .scaleEffect(2)
                        }
                    }
                    .ignoresSafeArea(.all)
                }
            }
            .onAppear {
                if output.loyalty == nil {
                    loadLoyaltyTrigger.send()
                }
                loadTrigger.send(())
            }
        }

    }

    init(viewModel: StatusViewModel) {
        let input = StatusViewModel.Input(
            popViewTrigger: popViewTrigger.asDriver(),
            loadLoyaltyTrigger: loadLoyaltyTrigger.asDriver(),
            loadTrigger: loadTrigger.asDriver(),
            loadMoreTrigger: loadMoreTrigger.asDriver()
        )

        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}


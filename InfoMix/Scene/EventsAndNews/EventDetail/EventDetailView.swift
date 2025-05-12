//
//  EventDetailView.swift
//  CleanArchitecture
//
//  Created by Temur on 18/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import WebKit
import URLImage

struct EventDetailView: View {
    @ObservedObject var output: EventDetailViewModel.Output
    private let viewModel: EventDetailViewModel
    private let cancelBag = CancelBag()
    private let loadTrigger = PassthroughSubject<Int32, Never>()
    private let popViewTrigger = PassthroughSubject<Void, Never>()
    @State private var webViewHeight: CGFloat = .zero
    var body: some View {
        let url = URL(string: output.event.imageUrl ?? "")
        LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "Event detail".localized()) {
                    popViewTrigger.send(())
                }
                ScrollView{
                    VStack {
                        if let urlImage = url {
                            AsyncImage(url: urlImage) { image in
                                image
                                    .resizable()
                                    .centerCropped()
                            } placeholder: {
                                Image("logo")
                                    .centerCropped()
                            }
                            .frame(height: 200)
                        }
                        VStack{
                            Spacer().frame(height: 15.0)
                            HStack{
                                Spacer().frame(width: 10.0)
                                Text(output.event.title ?? "")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20))
                                    .bold()


                                Spacer()
                            }
                            Spacer().frame(height: 10.0)
                        }.background(Color.gray)


                        HStack{

                            Spacer().frame(width:10.0)
                            if let createDate = output.event.createDate {
                                VStack{
                                    Spacer().frame(height: 10.0)
                                    HStack{
                                        Text("Date of start".localized())
                                            .bold()
                                            .foregroundColor(Color.gray)
                                        Spacer()
                                    }
                                    HStack{
                                        Text(createDate.toShortFormat())
                                            .bold()
                                        Spacer()
                                    }
                                    Spacer().frame(height: 10.0)
                                }
                            }

                            Spacer()
                            if let endDate = output.event.endEventDate {
                                VStack{
                                    Spacer().frame(height: 10.0)
                                    HStack{
                                        Spacer()
                                        Text("Date of end".localized())
                                            .bold()
                                            .foregroundColor(Color.gray)
                                        Spacer().frame(width:10.0)
                                    }


                                    HStack{
                                        Spacer()

                                        Text(endDate.toShortFormat())
                                            .bold()
                                        Spacer().frame(width:10.0)
                                    }
                                    Spacer().frame(height: 10.0)
                                }
                            }

                            Spacer().frame(width:10.0)
                        }.border(Color.red)


                    }

                    WebView(dynamicHeight: $webViewHeight, html:output.event.content ?? "")
                        .frame(height: webViewHeight)
                }.edgesIgnoringSafeArea([.bottom, .trailing, .leading])
            }
            
        }
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    init(viewModel: EventDetailViewModel) {
        self.viewModel = viewModel
        let input = EventDetailViewModel.Input(loadTrigger: loadTrigger.asDriver(), popViewTrigger: popViewTrigger.asDriver())
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        loadTrigger.send(viewModel.event.id ?? 0)
        
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let event = Event(id: 1, title: "Akfa", shortDescription: "iPhone", content: "", imageUrl: "car", endEventDate: Date(timeIntervalSince1970: 123), createDate: Date(timeIntervalSince1970: 234), type: EventType(id: 1, name: "Akfaa"), ads: false)
        return EventDetailView(
            viewModel: PreviewAssembler().resolve(navigationController: UINavigationController(), event: event)
        )
    }
}

struct WebView: UIViewRepresentable{
    var webview: WKWebView = WKWebView()
    @Binding var dynamicHeight: CGFloat

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
                DispatchQueue.main.async {
                    self.parent.dynamicHeight = height as! CGFloat
                }
            })
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var html: String
      
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: CGRect.zero)
        
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.navigationDelegate = context.coordinator
        
        return webView
        
        
    }
      
     func updateUIView(_ uiView: WKWebView, context: Context) {
         let body = """
         <html>
         <head>
         <meta name="viewport" content="width=device-width, initial-scale=1">
         <style> body { font-size: 100%; } </style>
         </head>
         <body>
         \(html)
         </body>
         </html>
         """
         uiView.loadHTMLString(body, baseURL: nil)
     }
}


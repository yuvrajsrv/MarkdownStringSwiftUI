//
//  ContentView.swift
//  MarkdownStringSwiftUI
//
//  Created by Yuvraj Sorav on 29/10/24.
//

import SwiftUI

struct ContentView: View {
    
    private let markdownStringOpenedAction: ((WebLink) -> Void)?
    @Environment(\.openURL) private var openURL
    
    enum  WebLink: String {
        case appleWebsite = "https://www.apple.com"
        case googleWebsite = "https://www.google.com"
    }
    
    init(markdownStringOpenedAction: ((WebLink) -> Void)? = nil) {
        self.markdownStringOpenedAction = markdownStringOpenedAction
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text(.init(markdownText))
                    .font(.title2)
                    .environment(\.openURL, OpenURLAction { url in
                        handleURL(url)
                        openURL(url)
                        return .handled
                    })
            }
            .padding()
        }
    }
    
    private func handleURL(_ url: URL) {
        guard let webLink = WebLink(rawValue: url.absoluteString) else { return }
        markdownStringOpenedAction?(webLink)
    }
    
}

extension ContentView {
    
    private var markdownText: String {
        "Learning is the process of acquiring new understanding, knowledge, behaviors, skills, values, attitudes, and preferences.\n\n[Apple](\(WebLink.appleWebsite.rawValue)) - The ability to learn is possessed by humans, non-human animals, and some machines; there is also evidence for some kind of learning in certain plants.\n\n[Google](\(WebLink.googleWebsite.rawValue)) - Some learning is immediate, induced by a single event (e.g. being burned by a hot stove), but much skill and knowledge accumulate from repeated experiences."
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

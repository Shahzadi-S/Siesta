//
//  ExternalLink.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 11/12/2023.
//

import Foundation

struct ExternalLink: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let url: String
}

let reviewLink: ExternalLink = ExternalLink(icon: "star.bubble",
                                                title: "Review",
                                                url: "https://www.apple.com")

let socialLinks: [ExternalLink] = [ExternalLink(icon: "Instagram_icon",
                                                title: "Instagram",
                                                url: "https://www.instagram.com/thesiestaapp"),
                                   ExternalLink(icon: "Tiktok_icon",
                                                title: "TikTok",
                                                url: "https://www.tiktok.com/@siesta.app")]

import Foundation

struct App: Decodable {
    let id: Int
    let nome: String
    let empresa: String
    let avaliacao: String?
    let descricao: String?
    let comentarios: [AppComentario]?
    let iconeUrl: String
    let screenshotUrls: [String]?
}

struct FeaturedApp: Decodable {
    let id: Int
    let nome: String
    let empresa: String
    let imagemUrl: String
    let descricao: String
}


struct AppGroup: Decodable {
    let id: String
    let titulo: String
    let apps: [App]
}


struct AppComentario: Decodable {
    let id: Int
    let titulo: String
    let avaliacao: Int
    let descricao: String?
}


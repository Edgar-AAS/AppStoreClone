
import Foundation

class TodayService {
    static func fetchFeaturedToday(completion: @escaping (Result<[TodayApp], Error>) -> ()) {
        let service = AppService()
        
        var todayApps: Array<TodayApp> = [
            TodayApp(
                id: 1,
                categoria: "VIAGEM",
                titulo: "Explore o mundo \n sem medo",
                imagemUrl: "destaque-1",
                descricao: "Pode viajar o mundo o mundo em busca da beleza, mas nunca a encontraremos se nao a carregarmos dentro de nos.",
                backgroundColor: "#FFFFFF",
                apps: nil
            ),
            
            TodayApp(
                id: 2,
                categoria: "PRATIQUE HOJE",
                titulo: "Mantenha o corpo \ne mente saudáveis",
                imagemUrl: "destaque-2",
                descricao: "Quanto mias se rema, maiores sao a chances de pegar as melhores ondas, tanto no surf quanto na vida.",
                backgroundColor: "#69CCE0",
                apps: nil
            )
        ]
        
        service.fetchApp { (app, error) in
            if let app = app {
                todayApps.append(
                    TodayApp(
                        id: 3,
                        categoria: "A LISTA DO DIA",
                        titulo: "Pedale melhor com \n Apple",
                        imagemUrl: nil,
                        descricao: nil,
                        backgroundColor: nil,
                        apps: app
                    )
                )
            }
            
            completion(.success(todayApps))
        }
    }
}

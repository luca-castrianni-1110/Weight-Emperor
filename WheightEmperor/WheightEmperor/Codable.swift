import Foundation
import SwiftUI

// MARK: - Esercizio
class Esercizio: ObservableObject, Identifiable, Codable {
    @Published var id: UUID
    @Published var nome: String
    @Published var serie: String
    @Published var ripetizioni: String
    @Published var peso: String
    @Published var commento: String?

    init(id: UUID = UUID(), nome: String = "", serie: String = "", ripetizioni: String = "", peso: String = "", commento: String? = "") {
        self.id = id
        self.nome = nome
        self.serie = serie
        self.ripetizioni = ripetizioni
        self.peso = peso
        self.commento = commento
    }

    // MARK: Codable con @Published
    enum CodingKeys: CodingKey {
        case id, nome, serie, ripetizioni, peso, commento
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        nome = try container.decode(String.self, forKey: .nome)
        serie = try container.decode(String.self, forKey: .serie)
        ripetizioni = try container.decode(String.self, forKey: .ripetizioni)
        peso = try container.decode(String.self, forKey: .peso)
        commento = try container.decodeIfPresent(String.self, forKey: .commento)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(nome, forKey: .nome)
        try container.encode(serie, forKey: .serie)
        try container.encode(ripetizioni, forKey: .ripetizioni)
        try container.encode(peso, forKey: .peso)
        try container.encode(commento, forKey: .commento)
    }
}

// MARK: - MuscoloAllenamento
class MuscoloAllenamento: ObservableObject, Identifiable, Codable {
    @Published var id: UUID
    @Published var nome: String
    @Published var numeroEsercizi: Int
    @Published var esercizi: [Esercizio]

    init(id: UUID = UUID(), nome: String = "", numeroEsercizi: Int = 1, esercizi: [Esercizio] = [Esercizio()]) {
        self.id = id
        self.nome = nome
        self.numeroEsercizi = numeroEsercizi
        self.esercizi = esercizi
    }

    enum CodingKeys: CodingKey {
        case id, nome, numeroEsercizi, esercizi
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        nome = try container.decode(String.self, forKey: .nome)
        numeroEsercizi = try container.decode(Int.self, forKey: .numeroEsercizi)
        esercizi = try container.decode([Esercizio].self, forKey: .esercizi)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(nome, forKey: .nome)
        try container.encode(numeroEsercizi, forKey: .numeroEsercizi)
        try container.encode(esercizi, forKey: .esercizi)
    }
}

// MARK: - GiornoAllenamento
class GiornoAllenamento: ObservableObject, Identifiable, Codable {
    @Published var id: UUID
    @Published var giorno: String
    @Published var muscoli: [MuscoloAllenamento]

    init(id: UUID = UUID(), giorno: String, muscoli: [MuscoloAllenamento] = []) {
        self.id = id
        self.giorno = giorno
        self.muscoli = muscoli
    }

    enum CodingKeys: CodingKey {
        case id, giorno, muscoli
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        giorno = try container.decode(String.self, forKey: .giorno)
        muscoli = try container.decode([MuscoloAllenamento].self, forKey: .muscoli)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(giorno, forKey: .giorno)
        try container.encode(muscoli, forKey: .muscoli)
    }
}

// MARK: - SchedaAllenamentoModel
class SchedaAllenamentoModel: ObservableObject, Identifiable, Codable {
    @Published var id: UUID
    @Published var nome: String
    @Published var giorni: [GiornoAllenamento]

    init(id: UUID = UUID(), nome: String, giorni: [GiornoAllenamento]) {
        self.id = id
        self.nome = nome
        self.giorni = giorni
    }

    enum CodingKeys: CodingKey {
        case id, nome, giorni
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        nome = try container.decode(String.self, forKey: .nome)
        giorni = try container.decode([GiornoAllenamento].self, forKey: .giorni)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(nome, forKey: .nome)
        try container.encode(giorni, forKey: .giorni)
    }
}

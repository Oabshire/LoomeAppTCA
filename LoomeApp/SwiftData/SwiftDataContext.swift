//
//  SwiftDataContext.swift
//  LoomeApp
//
//  Created by Onie on 7/18/25.
//

import Foundation
import SwiftData
import ComposableArchitecture

extension DependencyValues {
    var databaseService: Database {
        get { self[Database.self] }
        set { self[Database.self] = newValue }
    }
}

fileprivate let appContext: ModelContext = {
    do {

        let url = URL.applicationSupportDirectory.appending(path: "Model.sqlite")
        let config = ModelConfiguration(url: url)

        let container = try ModelContainer(for: HabitEntity.self, configurations: config)
        return ModelContext(container)
    } catch {
        fatalError("Failed to create container.")
    }
}()

struct Database {
    var context: () throws -> ModelContext
}

extension Database: DependencyKey {
    public static let liveValue = Self(
        context: { appContext }
    )
}

extension Database: TestDependencyKey {
    public static var previewValue = Self.noop

    public static let testValue = Self(
        context: unimplemented("\(Self.self).context")
    )

    static let noop = Self(
        context: unimplemented("\(Self.self).context")
    )
}

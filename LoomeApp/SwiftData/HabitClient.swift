//
//  HabitClient.swift
//  LoomeApp
//
//  Created by Onie on 7/17/25.
//

import Foundation
import SwiftData
import ComposableArchitecture

extension DependencyValues {
    var swiftData: HabitSwiftDataClient {
        get { self[HabitSwiftDataClient.self] }
        set { self[HabitSwiftDataClient.self] = newValue }
    }
}

struct HabitSwiftDataClient {
    var fetchAll: @Sendable () throws -> [Habit]
    //    var fetch: @Sendable (FetchDescriptor<Movie>) throws -> [Movie]
    var add: @Sendable (Habit) throws -> Void
    var delete: @Sendable (UUID) throws -> Void

    enum HabitSwiftDataError: Error {
        case add
        case delete
    }
}

extension HabitSwiftDataClient: DependencyKey {
    public static var liveValue: HabitSwiftDataClient {
        @Dependency(\.databaseService.context) var context

        return HabitSwiftDataClient(
            fetchAll: {
                do {
                    let habitContext = try context()

                    let descriptor = FetchDescriptor<HabitEntity>(sortBy: [SortDescriptor(\.title)])
                    let entities = try habitContext.fetch(descriptor)

                    return entities.map { $0.toDomain() }
                } catch {
                    return []
                }
            },
            //        fetch: { descriptor in
            //            do {
            //                let movieContext = try context()
            //                return try movieContext.fetch(descriptor)
            //            } catch {
            //                return []
            //            }
            //        },

            add: { habit in
                do {
                    let habitContext = try context()
                    let entity = habit.toEntity()
                    habitContext.insert(entity)
                    try habitContext.save()
                } catch {
                    throw HabitSwiftDataError.add
                }
            },

            delete: { id in
                do {
                    let habitContext = try context()
                    let descriptor = FetchDescriptor<HabitEntity>(predicate: #Predicate { $0.id == id })
                    if let entity = try habitContext.fetch(descriptor).first {
                        habitContext.delete(entity)
                        try habitContext.save()
                    } else {
                        throw HabitSwiftDataError.delete
                    }
                } catch {
                    throw HabitSwiftDataError.delete
                }
            }
        )
    }
}

extension HabitSwiftDataClient: TestDependencyKey {
    public static var previewValue = Self.noop

    public static let testValue = Self(
        fetchAll: unimplemented("\(Self.self).fetch"),
        //        fetch: unimplemented("\(Self.self).fetchDescriptor"),
        add: unimplemented("\(Self.self).add"),
        delete: unimplemented("\(Self.self).delete")
    )

    static let noop = Self(
        fetchAll: { [] },
        //        fetch: { _ in [] },
        add: { _ in },
        delete: { _ in }
    )
}

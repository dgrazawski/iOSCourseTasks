//
//  ContentView.swift
//  state_object_2
//
//  Created by Dawid Grazawski on 18/08/2025.
//

import SwiftUI

final class TaskManager: ObservableObject {
    @Published var tasks: [String] = ["Walk a dog", "Do groceries"]
}

struct ContentView: View {
    @StateObject private var taskManager = TaskManager()
    var body: some View {
        VStack(spacing: 20) {
            TaskListView()
            AddTaskView()
            RemoveTaskView()
        }
        .padding()
        .environmentObject(taskManager)
        .navigationTitle("Tasks")
    }
}

struct TaskListView: View {
    @EnvironmentObject var taskManager: TaskManager
    var body: some View {
        List(taskManager.tasks, id: \.self) { task in
            Text(task)
                .font(.title3)
        }
        .listStyle(.plain)
    }
}

struct AddTaskView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var text = ""
    var body: some View {
        VStack(spacing: 10) {
            Text("Add new task")
            TextField("New task...", text: $text)
                .textFieldStyle(.roundedBorder)
            Button {
                taskManager.tasks.append(text)
                text = ""
            } label: {
                Label("Add new task", systemImage: "plus")
            }
            .buttonStyle(.borderedProminent)
            .disabled(text.isEmpty)

        }
    }
}

struct RemoveTaskView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var indexToSelect = 0
    var body: some View {
        Text("Remove task")
        if !taskManager.tasks.isEmpty {
            Picker("Task number to delete", selection: $indexToSelect) {
                ForEach(taskManager.tasks.indices, id: \.self) { index in
                    Text("\(index + 1)")
                }
            }
            .pickerStyle(.menu)
        } else {
            Text("No tasks to delete")
                .foregroundStyle(.red)
        }
        
        Button {
            if indexToSelect < taskManager.tasks.count {
                taskManager.tasks.remove(at: indexToSelect)
                indexToSelect = 0
            }
        } label: {
            Label("Delete task", systemImage: "trash")
        }
        .buttonStyle(.borderedProminent)
        .disabled(taskManager.tasks.isEmpty)

    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}

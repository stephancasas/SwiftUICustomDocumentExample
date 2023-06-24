//
//  SwiftUICustomDocumentExampleApp.swift
//  SwiftUICustomDocumentExample
//
//  Created by Stephan Casas on 6/24/23.
//

import SwiftUI;
import UniformTypeIdentifiers;

// MARK: - Main App

@main
struct SwiftUICustomDocumentExampleApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: SwiftUIExampleDocument(), editor: {file in
            ExampleEditorView(file.$document);
        })
    }
}

// MARK: - Document Definition

extension UTType {
    static var stephanFile: UTType {
        .init("com.stephancasas.SwiftUICustomDocumentExample.swiftuiexample")!
    }
}

struct SwiftUIExampleDocument: FileDocument {
    
    static var readableContentTypes: [UTType] = [.stephanFile];
    
    var data: [String: Any];
    
    var exampleStringValue: String {
        set {
            self.data["ExampleStringValue"] = newValue;
        }
        get {
            self.data["ExampleStringValue"] as? String ?? ""
        }
    }

    var exampleBoolValue: Bool {
        set {
            self.data["ExampleBoolValue"] = newValue;
        }
        get {
            self.data["ExampleBoolValue"] as? Bool ?? false;
        }
    }
    
    init() {
        self.data = [:];
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let dictionary = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
            throw CocoaError(.fileReadCorruptFile);
        }
        
        self.data = dictionary;
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let plistData = try PropertyListSerialization.data(
            fromPropertyList: self.data,
            format: .xml,
            options: 0);
        return FileWrapper(regularFileWithContents: plistData);
    }
    
}


// MARK: - Document Editor

struct ExampleEditorView: View {
    @Binding var document: SwiftUIExampleDocument;
    
    init(_ document: Binding<SwiftUIExampleDocument>) {
        self._document = document
    }
    
    var body: some View {
        VStack(content:{
            TextField("String Value", text: self.$document.exampleStringValue)
            Toggle("Bool Value", isOn: self.$document.exampleBoolValue)
        })
        .padding()
    }
}

//
//  WordScramble.swift
//  Challenges
//
//  Created by Kid Kid on 1/23/23.
//

import SwiftUI

struct WordScramble: View {
    @State private var wordList: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var title = ""
    @State private var message = ""
    @State private var showMessage = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                }
                
                Section {
                    ForEach(wordList, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(title, isPresented: $showMessage) {
                Button("OK") { }
            } message: {
                Text(message)
            }
        }
    }
    
    func addNewWord() {
        let input = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard input.count > 0 else {
            newWord = ""
            return
        }
        
        guard !alreadyUsed(input) else {
            title = "Word is already used."
            message = "Please find another word."
            showMessage = true
            return
        }
        
        guard isAllowed(input) else {
            title = "Word is not allowed."
            message = "You cannot spell this word from the \(rootWord)."
            showMessage = true
            return
        }
        
        guard isReal(input) else {
            title = "Word is not recognized."
            message = "Please use real English word."
            showMessage = true
            return
        }
         
        withAnimation {
            wordList.insert(input, at: 0)
        }
        
        newWord = ""
    }
    
    func startGame() {
        if let wordURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
           let content = try? String(contentsOf: wordURL) {
            let words = content.components(separatedBy: "\n")
            rootWord = words.randomElement() ?? ""
            return
        }
        
        fatalError("Could not load file")
    }
    
    func alreadyUsed(_ word: String) -> Bool {
        return wordList.contains(word)
    }
    
    func isAllowed(_ word: String) -> Bool {
        var tempWord = rootWord
        for char in word {
            if let index = tempWord.firstIndex(of: char) {
                tempWord.remove(at: index)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word,
                                                            range: range,
                                                            startingAt: 0,
                                                            wrap: false,
                                                            language: "en")
        return misspelledRange.location == NSNotFound
    }
}

struct WordScramble_Previews: PreviewProvider {
    static var previews: some View {
        WordScramble()
    }
}

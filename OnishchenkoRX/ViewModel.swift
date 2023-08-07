//
//  ViewModel.swift
//  OnishchenkoRX
//
//  Created by lera on 20.02.2023.
//

import Foundation
import RxSwift

final class ViewModel {
    private var currentWord = ""
    let inClick = PublishSubject<Void>()
    let inDot = PublishSubject<Void>()
    let inDash = PublishSubject<Void>()
    let inPause = PublishSubject<Void>()
    let inReset = PublishSubject<Void>()
    let outValue = PublishSubject<(word: String, isCorrect: Bool)>()
    let disposeBag = DisposeBag()
    init(){
        inPause
            .subscribe(
                onNext: {[weak self] in
                    guard let self else {return}
                    guard self.letterToMorse[self.currentMorseInput] != nil
                    else{
                        (self.outValue.onNext((self.currentWord, false)))
                        self.currentMorseInput = ""
                        return
                    }
                    self.currentWord += self.letterToMorse[self.currentMorseInput]!
                    self.outValue.onNext((self.currentWord, true))
                    self.currentMorseInput = ""
                })
            .disposed(by: self.disposeBag)
        inDot
            .subscribe(
                onNext: {[weak self] in
                    guard let self else {return}
                    self.currentMorseInput += "."
                })
            .disposed(by: self.disposeBag)
        inDash
            .subscribe(
                onNext: {
                    [weak self] in
                        guard let self else {return}
                        self.currentMorseInput += "-"
                })
            .disposed(by: self.disposeBag)
        inReset
            .subscribe(
                onNext: {[weak self] in
                    guard let self else {return}
                    self.currentWord = ""
                    self.currentMorseInput = ""
                    self.outValue.onNext((self.currentWord, true))
                    
                    
                })
            .disposed(by: self.disposeBag)
        
    }

    
    let letterToMorse: [String: String] = [
      ".-": "a",
      "-...": "b",
      "-.-.": "c",
      "-..": "d",
      ".": "e",
      "..-.": "f",
      "--.": "g",
      "....": "h",
      "..": "i",
      ".---": "j",
      "-.-": "k",
      ".-..": "l",
      "--": "m",
      "-.": "n",
      "---": "o",
      ".--.": "p",
      "--.-": "q",
      ".-.": "r",
      "...": "s",
      "-": "t",
      "..-": "u",
      "...-": "v",
      ".--": "w",
      "-..-": "x",
      "-.--": "y",
      "--..": "z",
      ".----": "1",
      "..---": "2",
      "...--": "3",
      "....-": "4",
      ".....": "5",
      "-....": "6",
      "--...": "7",
      "---..": "8",
      "----.": "9",
      "-----": "0"
    ]
    private var currentMorseInput = ""
    
    
    
}

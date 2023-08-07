//
//  ViewController.swift
//  OnishchenkoRX
//
//  Created by lera on 20.02.2023.
//

import UIKit
import RxSwift

final class ViewController: UIViewController {
    
    // MARK: - Private properties
    private let vm = ViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - IBOutlets
    @IBOutlet private weak var generatingText: UILabel!
    
    // MARK: - IBActions
    @IBAction func dot(_ sender: Any) {
        vm.inDot.onNext(())
    }
    
    @IBAction func dash(_ sender: Any) {
        vm.inDash.onNext(())
    }
    
    @IBAction func pause(_ sender: Any) {
        vm.inPause.onNext(())
    }
    
    @IBAction func resetButton(_ sender: Any) {
        vm.inReset.onNext(())
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureRx()
    }
    
    private func configureRx() {
        vm.outValue.subscribe(onNext: {[weak self] in
            self?.generatingText.text = $0.word
            if $0.isCorrect == false{
                let alert = UIAlertController(title: "Alert", message: "Your letter is incorrect", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default))
                self!.present(alert, animated: true, completion: nil)
            }
        }
        )
        .disposed(by: self.disposeBag)
        
    }


}


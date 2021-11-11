//
//  ViewController.swift
//  6
//
//  Created by Toshiyana on 2021/11/08.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var targetNumLabel: UILabel!
    @IBOutlet private weak var selectNumSlider: UISlider!

    private var answer = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        resetGames()
    }

    @IBAction private func checkButtonPressed(_ sender: UIButton) {
        let selectedNum = Int(selectNumSlider.value)
        let resultText: String

        if answer == selectedNum {
            resultText = "あたり！"
        } else {
            resultText = "はずれ！"
        }
        let alert = UIAlertController(title: "結果",
                                      message: "\(resultText)\nあなたの値：\(selectedNum)",
                                      preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "再挑戦", style: .cancel) { [weak self] _ in
            // 今回の場合、weak selfをつけなくてもメモリリークは起きない。
            // ただ、一般的にこのクロージャをプロパティにしたときにはメモリリークが発生してしまうので、安全面を考えて、
            // selfを参照するクロージャにはとりあえず、[weak self]をつけた方が良い（by あきおさん）

            // selfの場合、unownedの方が良いのでは？
            self?.resetGames()
        }

        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    private func resetGames() {
        answer = Int.random(in: 1...100)
        targetNumLabel.text = String(answer)
        selectNumSlider.value = 50
    }
}

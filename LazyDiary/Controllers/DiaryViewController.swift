//
//  DiaryViewController.swift
//  LazyDiary
//
//  Created by 김선규 on 12/21/23.
//

import UIKit

class DiaryViewController: UIViewController {

    lazy var button: UIButton = {
        let btn = UIButton(frame: CGRect(x: view.frame.width/2 - 75, y: 400, width: 150, height: 50),
                           primaryAction: UIAction(handler: { _ in
            // 서브스크립트로 접근하기
            let fisrtIndex = self.navigationController!.viewControllers.startIndex
            let firstVC = self.navigationController?.viewControllers[fisrtIndex] as! ViewController
            
            
            self.navigationController?.popViewController(animated: true)
        }))
        btn.setTitle("전달하고 뒤로가기", for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(button)
        
        self.navigationItem.title = "SecondVC"
    }

}

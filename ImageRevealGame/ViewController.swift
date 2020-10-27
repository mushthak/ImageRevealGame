//
//  ViewController.swift
//  ImageRevealGame
//
//  Created by Mushthak Ibrahim on 10/17/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var pointsLabel: UILabel!
    
    var revealedButtons:[UIButton] = []
    var imageIndex:Int = 0
    var images:[String] = []

    let assetImagesCount = 16
    let startingPoint = 100
    let perPoint = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initImage()
        loadImage()
        loadRevealButtons()
    }

    @IBAction func revealAction(_ sender: UIButton) {
        verticalStack.alpha = (verticalStack.alpha == 0) ? 1 : 0
    }

    @IBAction func nextAction(_ sender: UIButton) {
        if(imageIndex < images.count - 1){
            verticalStack.alpha = 1
            resetButtons()
            imageIndex += 1
            loadImage()
            pointsLabel.text = "--"
        }
    }

    @objc func buttonClicked(_ sender:UIButton){
        revealedButtons.append(sender)
        sender.alpha = 0
        let points = (startingPoint + perPoint) - (revealedButtons.count) * perPoint
        if(points >= 0){
            pointsLabel.text = "\(points)"
        }
    }

    private func initImage(){
        for i in 1...assetImagesCount {
            images.append("\(i)")
        }
    }

    private func loadImage(){
        imageView.image = UIImage.init(named: images[imageIndex])
        imageView.contentMode = .scaleAspectFill
    }

    private func loadRevealButtons(){
        let itemSize = imageContainer.frame.width/10

        for i in 0...9 {
            let horizontalStack:UIStackView = UIStackView.init(frame: CGRect.init(x: 0, y: 0, width: imageContainer.frame.width, height: itemSize))
            for j in 1...10 {
                let tag = (i*10)+j
                let button:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: itemSize, height: itemSize))
                button.tag = tag
                button.backgroundColor = .red
                button.setTitle("\(tag)", for: UIControl.State.normal)
                button.addTarget(self, action:#selector(self.buttonClicked), for: .touchDown)
                horizontalStack.addArrangedSubview(button)
                horizontalStack.distribution = .fillEqually
            }
            verticalStack.addArrangedSubview(horizontalStack)
        }
        verticalStack.distribution = .fillEqually

    }

    private func resetButtons(){
        for button in revealedButtons {
            button.alpha = 1
        }
        revealedButtons.removeAll()
    }

}


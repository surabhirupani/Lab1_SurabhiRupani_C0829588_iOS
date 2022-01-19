//
//  ViewController.swift
//  Lab1_SurabhiRupani_C0829588_iOS
//
//  Created by Surabhi Rupani on 2022-01-18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblResult: UILabel!
    var initialState = [0,0,0,0,0,0,0,0,0]
    @IBOutlet weak var btnPlayAgin: UIButton!
    var game_flag = true
    var player = 1
    @IBOutlet weak var crossResult: UILabel!
    @IBOutlet weak var circleResult: UILabel!
    let combinations_to_win = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]
    var count = 1
    var cross_win_count = 0
    var circle_win_count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblResult.isHidden = true
        btnPlayAgin.isHidden = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(swipeRight)
        
    }
    
    
    //Swipe left or right make board clean
    @objc func swiped(gesture: UISwipeGestureRecognizer) {
        let swipeGesture = gesture as UISwipeGestureRecognizer
        switch swipeGesture.direction {
        case UISwipeGestureRecognizer.Direction.left:
            lblResult.isHidden = true
            resetBoard()
        case UISwipeGestureRecognizer.Direction.right:
            lblResult.isHidden = true
            resetBoard()
        default:
            break
        }
    }
    
    
    //place circle or cross on board and update score
    @IBAction func btnPressed(_ sender: AnyObject) {
        print("Ongoing game")
        lblResult.isHidden = true
        if initialState[sender.tag-1] == 0 && game_flag == true {
            initialState[sender.tag-1] = player
            if player == 1 {
                sender.setImage(UIImage(named: "cross.png"), for: UIControl.State())
                player = 2
            } else {
                sender.setImage(UIImage(named: "circle.png"), for: UIControl.State())
                player = 1
            }
        }
        
        for combination in combinations_to_win {
//            print(combination)
            if initialState[combination[0]] != 0 && initialState[combination[0]] == initialState[combination[1]] && initialState[combination[1]] == initialState[combination[2]] {
                //update score of cross and circle
                if initialState[combination[0]] == 1 {
                    cross_win_count += 1;
                    crossResult.text = "\(cross_win_count)";
                    lblResult.text = "Cross win!"
                } else if initialState[combination[0]] == 2{
                    circle_win_count += 1;
                    circleResult.text = "\(circle_win_count)";
                    lblResult.text = "Circle win!"
                }
                print("Game over")
                game_flag = false
                lblResult.isHidden = false
                resetBoard()
            }
            
//            print(initialState[combination[0]])
//            print(initialState[combination[1]])
//            print(initialState[combination[2]])
//            print(game_flag)
            
            if game_flag == true {
                count = 1
                for i in initialState {
                    count = i*count
                }
//                print(initialState)
//                print(count)
                if count != 0 {
                    //even game it's draw
                    print("Game over")
                    lblResult.text = "Draw!"
                    lblResult.isHidden = false
                    btnPlayAgin.isHidden = false
                    resetBoard()
                }
            }
            
            btnPlayAgin.isHidden = false
        }
    }
    
    
    @IBAction func btnPlayAgain(_ sender: Any) {
        resetBoard()
    }
    
    func resetBoard() {
        initialState = [0,0,0,0,0,0,0,0,0]
        game_flag = true
        player = 1
        btnPlayAgin.isHidden = true
        
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }
    }
        
   
}



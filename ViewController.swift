//
//  ViewController.swift
//  TicTacToe
//
//  Created by Jessie on 2018-04-12.
//  Copyright © 2018 Jessie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var squares = [UIImageView]()  // Holds the images of each square
    
    var blocks = [Block?]()        // Holds the info regarding ownership of the blocks
    
    var block1: String?
    var block2: String?
    var block3: String?
    var block4: String?
    var block5: String?
    var block6: String?
    var block7: String?
    var block8: String?
    var block9: String?
    
    var user: Player?              // Holds the player info for user
    var computer: Player?          // Holds the player info for computer
   
    // All the image views for "X" and "O" placement
    @IBOutlet weak var square1: UIImageView!
    @IBOutlet weak var square2: UIImageView!
    @IBOutlet weak var square3: UIImageView!
    @IBOutlet weak var square4: UIImageView!
    @IBOutlet weak var square5: UIImageView!
    @IBOutlet weak var square6: UIImageView!
    @IBOutlet weak var square7: UIImageView!
    @IBOutlet weak var square8: UIImageView!
    @IBOutlet weak var square9: UIImageView!
    
    // View for the winner message
    @IBOutlet weak var winnerMessage: UILabel!
    
    // Keeps track of how many turns the user has taken
    var turns: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // All the image views for the 9 squares
        squares = [square1, square2, square3, square4, square5, square6, square7, square8, square9]
        
        // All the blocks for the 9 squares are set as "unassigned" blocks at start of game
        blocks = [
            Block(blockOwnedBy: "unassigned", squareOccupied: 1),
            Block(blockOwnedBy: "unassigned", squareOccupied: 2),
            Block(blockOwnedBy: "unassigned", squareOccupied: 3),
            Block(blockOwnedBy: "unassigned", squareOccupied: 4),
            Block(blockOwnedBy: "unassigned", squareOccupied: 5),
            Block(blockOwnedBy: "unassigned", squareOccupied: 6),
            Block(blockOwnedBy: "unassigned", squareOccupied: 7),
            Block(blockOwnedBy: "unassigned", squareOccupied: 8),
            Block(blockOwnedBy: "unassigned", squareOccupied: 9)
        ]
        
        // Sets the turns to 0 at the beginning of the game
        turns = 0
        
        // Sets the winner message and its background to empty at start
        winnerMessage.text = ""
        winnerMessage.backgroundColor = UIColor (white: 1, alpha: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function that makes the plays
    func playTurn(squareChoice: Int) {
        
        // Initializes the user and computer players
        user = Player(playerName: "Player", playerPoints: 0, playerPiece: "xPiece", ownerID: Block(blockOwnedBy: "playerOwned"))
        computer = Player(playerName: "Roro", playerPoints: 0, playerPiece: "oPiece", ownerID: Block(blockOwnedBy: "computerOwned"))
        
        
        // Logic that assigns player's piece to that square
        // if the 1st blocked hasn't been played, it gets assigned to user and image is updated
        if blocks[squareChoice-1]?.ownership == "unassigned" {
            
            turns = turns! + 1 // For debuging. Adds one to the turn each time user hits a new square
            
            print ("The block you chose is unassigned; you have now played it!") // debug msg
            print ("This is the \(turns!) turn") //debug msg to show the turn
            
            var computerChoice: Int? //  this will be the computer's "choice"
            
            // Updates the image and assigns the block ownership based on what "button" user clicked
            squares[squareChoice-1].image = UIImage(named: user!.piece)
            blocks[squareChoice-1] = user!.ownedID
            
            // If there is a winner, the game stops. computerChoice is set to 0 to stop the game
            // Otherwise the computer will flow through the following logic (all contained within runOptionA):
            // runOptionA: First computer tries to complete its own line. If not possible then...
            // runOptionB: Computer tries to block user's line. If user doesn't have a line then...
            // runOptionC: Computer tries to initiate its own line. If that's not possible...
            // runOptionD: Computer randomly picks an available square.
            
            if determineWinner(player: user!) == "Winner!" { // If user's a winner, game stops
                print ("\(user!.name!) is the winner!") // Prints whether user is winner
                computerChoice = 0
            } else if runOptionA() != 0 {
                 computerChoice = runOptionA() // As long as optionA doesn't return 0, all other options are tried
            } else {
                print ("Looks like it was a draw!") // Only other scenario is that it is a draw
                computerChoice = 0
                winnerMessage.text = "Looks like a tie!" // Updates the winner message, overlaid onto the board
                winnerMessage.backgroundColor = UIColor (white: 0, alpha: 0.70) // Updates the message background
            }


            // Based on computer choice, the block is updated
            if computerChoice == 0 {
                print ("The game is over!")
            } else if blocks[computerChoice!-1]?.ownership == "unassigned" { // Makes sure the computer's choice is available
                squares[computerChoice!-1].image = UIImage (named: computer!.piece) // Runs the code that updates the computer's choice
                blocks[computerChoice!-1]! = computer!.ownedID // Changes the assignment of the block to "computerOwned"
                if determineWinner(player: computer!) == "Winner!" {
                    print ("\(computer!.name!) is the winner!") // Prints whether user is winner
                }
                
            } else {
                print ("Something went wrong with the game") // debug msg
            }
        } else {
            print ("That block has already been assigned") // Block has been assigned already- debug msg
        }
        
    }
    
    // Cleans up the code by assigning variables to each square's ownership
    func makeVariables () {
        block1 = blocks[1-1]!.ownership!
        block2 = blocks[2-1]!.ownership!
        block3 = blocks[3-1]!.ownership!
        block4 = blocks[4-1]!.ownership!
        block5 = blocks[5-1]!.ownership!
        block6 = blocks[6-1]!.ownership!
        block7 = blocks[7-1]!.ownership!
        block8 = blocks[8-1]!.ownership!
        block9 = blocks[9-1]!.ownership!
    }
  
    func determineWinner (player: Player) -> String {
        
        makeVariables () // Gives block ownership variables
        
        // Sets the winning string (ex: "playerOwned playerOwned playerOwned")
        let winner: String = "\(player.ownedID.ownership!) \(player.ownedID.ownership!) \(player.ownedID.ownership!)"
        
        
        // Checks to see if the following combos match the "winner" string
        switch winner {
        case "\(block1!) \(block4!) \(block7!)",
            "\(block1!) \(block2!) \(block3!)",
            "\(block7!) \(block8!) \(block9!)",
            "\(block7!) \(block5!) \(block3!)",
            "\(block1!) \(block5!) \(block9!)",
            "\(block3!) \(block6!) \(block9!)",
            "\(block2!) \(block5!) \(block8!)",
            "\(block4!) \(block5!) \(block6!)":
            
            // Loops over the array of blocks to see which are unassigned and makes them unplayable
            for i in blocks {
                // print (i!.ownership!) // debug msg
                if i!.ownership == "unassigned"{
                    i!.ownership = "unplayable as game is over"
                }
            }
            winnerMessage.text = "\(player.name!) is the winner!" // Updates the winner message, overlaid onto the board
            winnerMessage.backgroundColor = UIColor (white: 0, alpha: 0.70) // Updates the message background
            return "Winner!"
            
        default:
            return "Not the winner!"
            
        }
    }
    
    // Function where computer attempts to block the user's line
    func runOptionB () -> Int {
        
        print ("option B ran") // debug msg
        makeVariables () // Givees block ownership variables
        
        let nextMove: String = "playerOwned playerOwned unassigned"
        
        switch nextMove {
            case "\(block4!) \(block7!) \(block1!)",
                "\(block2!) \(block3!) \(block1!)",
                "\(block5!) \(block9!) \(block1!)":
                return 1
            
            case "\(block1!) \(block3!) \(block2!)",
                "\(block5!) \(block8!) \(block2!)":
                return 2

            case "\(block1!) \(block2!) \(block3!)",
                "\(block7!) \(block5!) \(block3!)",
                "\(block6!) \(block9!) \(block3!)":
                return 3
            
            case "\(block1!) \(block7!) \(block4!)",
                "\(block5!) \(block6!) \(block4!)":
                return 4
            
            case "\(block3!) \(block7!) \(block5!)",
                "\(block1!) \(block9!) \(block5!)",
                "\(block2!) \(block8!) \(block5!)",
                "\(block4!) \(block6!) \(block5!)":
                return 5
            
            case "\(block3!) \(block9!) \(block6!)",
                "\(block4!) \(block5!) \(block6!)":
                return 6
            
            case "\(block1!) \(block4!) \(block7!)",
                "\(block8!) \(block9!) \(block7!)",
                "\(block5!) \(block3!) \(block7!)":
                return 7
            
            case "\(block7!) \(block9!) \(block8!)",
                "\(block2!) \(block5!) \(block8!)":
                return 8
            
            case "\(block7!) \(block8!) \(block9!)",
                "\(block1!) \(block5!) \(block9!)",
                "\(block3!) \(block6!) \(block9!)":
                return 9
            
            default:
                print ("User didn't play smart")
                return 0 // If 0, then optionC will run
        }
        
    }
    
    
    // Function where computer attempts to make its own line in the case where user didn't try to create a line
    func runOptionC () -> Int {
        
        makeVariables () // Givees block ownership variables
        
        //makeVariables () // Givees block ownership variables
        
        print ("option C is running. Computer is going to try to win!!!") // debug msg
        print ("\(block5!) \(block6!) \(block4!)") // debug msg
        
        // If the line has two available slots, computer tries to form its own line
        let line: String = "unassigned unassigned computerOwned"
        var compChoices: [Int] = []
        
        
        if "\(block4!) \(block7!) \(block1!)" == line {compChoices += [4,7]}
        if "\(block2!) \(block3!) \(block1!)" == line {compChoices += [2,3]}
        if "\(block5!) \(block9!) \(block1!)" == line {compChoices += [5,9]}
        
        
        if "\(block1!) \(block3!) \(block2!)" == line {compChoices += [1,3]}
        if "\(block5!) \(block8!) \(block2!)" == line {compChoices += [5,8]}
        
        
        if "\(block1!) \(block2!) \(block3!)" == line {compChoices += [1,2]}
        if "\(block7!) \(block5!) \(block3!)" == line {compChoices += [7,5]}
        if "\(block6!) \(block9!) \(block3!)" == line {compChoices += [6,9]}
        
        if "\(block1!) \(block7!) \(block4!)" == line {compChoices += [1,7]}
        if "\(block5!) \(block6!) \(block4!)" == line {compChoices += [5,6]}
        
        if "\(block3!) \(block7!) \(block5!)" == line {compChoices += [3,7]}
        if "\(block1!) \(block9!) \(block5!)" == line {compChoices += [1,9]}
        if "\(block2!) \(block8!) \(block5!)" == line {compChoices += [2,8]}
        if "\(block4!) \(block6!) \(block5!)" == line {compChoices += [4,6]}
        
        if "\(block3!) \(block9!) \(block6!)" == line {compChoices += [3,9]}
        if "\(block4!) \(block5!) \(block6!)" == line {compChoices += [4,5]}
        
        if "\(block1!) \(block4!) \(block7!)" == line {compChoices += [1,4]}
        if "\(block8!) \(block9!) \(block7!)" == line {compChoices += [8,9]}
        if "\(block5!) \(block3!) \(block7!)" == line {compChoices += [5,3]}
        
        if "\(block7!) \(block9!) \(block8!)" == line {compChoices += [7,9]}
        if "\(block2!) \(block5!) \(block8!)" == line {compChoices += [2,5]}
        
        if "\(block7!) \(block8!) \(block9!)" == line {compChoices += [7,8]}
        if "\(block1!) \(block5!) \(block9!)" == line {compChoices += [1,5]}
        if "\(block3!) \(block6!) \(block9!)" == line {compChoices += [3,6]}
            
        // else {compChoices = [0]}
        print ("The computer choice array: \(compChoices)") // debug msg
 
        var myRandNum: Int?
        var compChoice: Int?
        
        // Little snippet in case there are no C options
        if compChoices.count == 0 {
            compChoice = 0 // This will have the funtion return 0, which then prompts option D
        } else {
            // From the array that's created, one is randomly selected
            myRandNum = Int(arc4random_uniform (UInt32(compChoices.count)))
            compChoice = compChoices[myRandNum!]
        }
        
        return compChoice!
    }
    
    
    // Function where computer attempts complete its own line
    func runOptionA () -> Int {
        
        makeVariables () // Gives block ownership variables
        print ("option A is running") // debug msg
        let nextMove: String = "computerOwned computerOwned unassigned"
        // print ("\(block9!) \(block5!) \(block1!)") //debug msg
        
        switch nextMove {
        case "\(block4!) \(block7!) \(block1!)",
            "\(block2!) \(block3!) \(block1!)",
            "\(block5!) \(block9!) \(block1!)":
            return 1
            
        case "\(block1!) \(block3!) \(block2!)",
            "\(block5!) \(block8!) \(block2!)":
            return 2
            
        case "\(block1!) \(block2!) \(block3!)",
            "\(block7!) \(block5!) \(block3!)",
            "\(block6!) \(block9!) \(block3!)":
            
            return 3
            
        case "\(block1!) \(block7!) \(block4!)",
            "\(block5!) \(block6!) \(block4!)":
            return 4
            
        case "\(block3!) \(block7!) \(block5!)",
            "\(block1!) \(block9!) \(block5!)",
            "\(block2!) \(block8!) \(block5!)",
            "\(block4!) \(block6!) \(block5!)":
            return 5
            
        case "\(block3!) \(block9!) \(block6!)",
            "\(block4!) \(block5!) \(block6!)":
            return 6
            
        case "\(block1!) \(block4!) \(block7!)",
            "\(block8!) \(block9!) \(block7!)",
            "\(block5!) \(block3!) \(block7!)":
            return 7
            
        case "\(block7!) \(block9!) \(block8!)",
            "\(block2!) \(block5!) \(block8!)":
            return 8
            
        case "\(block7!) \(block8!) \(block9!)",
            "\(block1!) \(block5!) \(block9!)",
            "\(block3!) \(block6!) \(block9!)":
            return 9
            
        default:
            
            // If none of the above work, ie computer can't win, first the computer tries to block the user (optionB);
            // otherwise, it tries to create its own line (optionC)
            print ("Option A didn't yield results. Looking at other options")
            if runOptionB () != 0 {
                return runOptionB() // Computer tries to block user's winning line
            } else if runOptionC() != 0 {
                // If user doesn't have a line to make (because user blocked the computer), computer tries to make its own line
                print ("Looks like user tried to block computer! This is optionC where there where no opportunities to block A")
                return runOptionC() // Returns the slightly randomized choice so that computer can make its own line
            } else if runOptionC() == 0 {
                return runOptionD() // Loops through remaining options and chooses one randomly
            } else {
                print ("There's no more options at all!")
                return 0 // In this case, it's a tie
            }
        }
        
    }
    
    func runOptionD () -> Int {
        
        makeVariables () // Givees block ownership variables
        
        let blockArray: [String] = [block1!, block2!, block3!, block4!, block5!, block6!, block7!, block8!, block9!]
        var compChoices: [Int] = []

        // Loop over available blocks and returns one that hasn't been assigned
        print ("There are no more winning options left. optionB == 0")
        var count: Int = 0
        for i in blockArray {
            count = count + 1 // Increments the counter until computer finds an unassigned block
                if i == "unassigned" {
                print ("Computer looped through the choices and found \(count) was available")
                compChoices += [count]
            }
        }
        
        var myRandNum: Int?
        var compChoice: Int?
        
        // Little snippet in case there are no D options
        if compChoices.count == 0 {
            compChoice = 0
        } else {
            // From the array that's created, one is randomly selected
            myRandNum = Int(arc4random_uniform (UInt32(compChoices.count)))
            compChoice = compChoices[myRandNum!]
        }
        
        return compChoice!
    
    }
    
    
    // Resets everything if button is clicked
    @IBAction func startOver(_ sender: Any) {
        
        // Resets the blocks
        blocks = [
            Block(blockOwnedBy: "unassigned", squareOccupied: 1),
            Block(blockOwnedBy: "unassigned", squareOccupied: 2),
            Block(blockOwnedBy: "unassigned", squareOccupied: 3),
            Block(blockOwnedBy: "unassigned", squareOccupied: 4),
            Block(blockOwnedBy: "unassigned", squareOccupied: 5),
            Block(blockOwnedBy: "unassigned", squareOccupied: 6),
            Block(blockOwnedBy: "unassigned", squareOccupied: 7),
            Block(blockOwnedBy: "unassigned", squareOccupied: 8),
            Block(blockOwnedBy: "unassigned", squareOccupied: 9)
        ]
        
        turns = 0 //resets the turns
        winnerMessage.text = "" // resets the winner message to be empty
        winnerMessage.backgroundColor = UIColor (white: 1, alpha: 0) // resets the winner message to be 100% transparent

        
        // Resets the squares
        squares[0].image = UIImage ()
        squares[1].image = UIImage ()
        squares[2].image = UIImage ()
        squares[3].image = UIImage ()
        squares[4].image = UIImage ()
        squares[5].image = UIImage ()
        squares[6].image = UIImage ()
        squares[7].image = UIImage ()
        squares[8].image = UIImage ()
    }
    
    // All the button areas (same size as images)
    @IBAction func but1(_ sender: Any) {
        playTurn(squareChoice: 1)
    }
    
    @IBAction func but2(_ sender: Any) {
        playTurn(squareChoice: 2)
    }
    
    @IBAction func but3(_ sender: Any) {
        playTurn(squareChoice: 3)
    }
    
    @IBAction func but4(_ sender: Any) {
        playTurn(squareChoice: 4)
    }
    
    @IBAction func but5(_ sender: Any) {
        playTurn(squareChoice: 5)
    }
    
    @IBAction func but6(_ sender: Any) {
        playTurn(squareChoice: 6)
    }
    
    @IBAction func but7(_ sender: Any) {
        playTurn(squareChoice: 7)
    }
    
    @IBAction func but8(_ sender: Any) {
        playTurn(squareChoice: 8)
    }
    
    @IBAction func but9(_ sender: Any) {
        playTurn(squareChoice: 9)
    }
}

//
//  ViewController.m
//  sc01-ShakeMeGame
//
//  Created by user on 10/2/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSTimer *timer;
    int     counter;
    int     score;
    int     gameMode; // 1 - BeingPlayed // 2 - Game Over
}
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UILabel *lblTimer;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmtSecondsChoice;
@property (weak, nonatomic) IBOutlet UILabel *lblAcumulatedScore;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // if (self)
    if (self.sgmtSecondsChoice.selectedSegmentIndex == 0) {
        self.lblTimer.text = @"10";
        counter = 10;
    } else if (self.sgmtSecondsChoice.selectedSegmentIndex == 1){
        self.lblTimer.text = @"15";
        counter = 15;
    }
    score = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startGamePressed:(id)sender {
    if (score == 0) {
        gameMode = 1; // we started the game
        
        self.lblTimer.text = [NSString stringWithFormat:@"%i", counter];
        // create a timer
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self
                                               selector:@selector(startCounter)
                                               userInfo:nil repeats:YES];
        self.btnStart.enabled = NO;
        
        if (counter == 0) {
            score = 0;
    
            if (self.sgmtSecondsChoice.selectedSegmentIndex == 0) {
                self.lblTimer.text = @"10";
                counter = 10;
            } else if (self.sgmtSecondsChoice.selectedSegmentIndex == 1){
                self.lblTimer.text = @"15";
                counter = 15;
            }
            self.lblTimer.text = [NSString stringWithFormat:@"%i", counter];
            self.lblScore.text = [NSString stringWithFormat:@"%i", score];
        }
    }
}

-(void)startCounter {
   // decrement the counter
    counter -= 1;
    
    self.lblTimer.text = [NSString stringWithFormat:@"%i", counter];
    
    if (counter == 0){
        [timer invalidate];
        gameMode =2;        // game is over
        accumulatedScore += score;
        self.lblAcumulatedScore.text = [NSString stringWithFormat:@"Accumulated: %i", accumulatedScore];
        
        // toggle the start button to "Restart", enable it
        [self.btnStart setTitle:@"Restart" forState:UIControlStateNormal];
        self.btnStart.enabled = YES;
        score = 0;
        gameMode = 1;
        
    }
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if(event.subtype == UIEventSubtypeMotionShake){
        if(gameMode == 1 ){
            // increment the score
            score += 1;
            
            // display
            self.lblScore.text = [NSString stringWithFormat:@"%i", score];
        }
    }
}

- (IBAction)sgmtSecondsChoicePressed:(id)sender {
    if (self.sgmtSecondsChoice.selectedSegmentIndex == 0) {
        self.lblTimer.text = @"10";
        counter = 10;
    } else if (self.sgmtSecondsChoice.selectedSegmentIndex == 1) {
        self.lblTimer.text = @"15";
        counter = 15;
    }
    score = 0;
}
@end

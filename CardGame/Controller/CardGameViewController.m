//
//  GameViewController.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 28/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "CardGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardGame *game;
@property (nonatomic) int flipCount;
@property (nonatomic) BOOL gameStarted;
@end

@implementation CardGameViewController

- (GameResult *) gameResult {
    if (!_gameResult) {
        _gameResult = [[GameResult alloc] init];
    }
    
    return _gameResult;
}

- (void) updateUI {}

- (void) setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", flipCount];
}

- (IBAction)dealPressed:(UIButton *)sender {
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    self.gameStarted = NO;
    [self updateUI];
}

- (IBAction)flipCard:(UIButton *)sender {
    self.gameStarted = YES;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    if (!sender.selected) {
        self.flipCount++;
    }
    
    self.gameResult.score = self.game.score;
    [self updateUI];
}

@end

//
//  CardGameViewController.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 17/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) BOOL gameStarted;
@property (nonatomic) NSUInteger lastScore;
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation CardGameViewController

- (GameResult *) gameResult {
    if (!_gameResult) {
        _gameResult = [[GameResult alloc] init];
    }
    
    return _gameResult;
}

- (CardMatchingGame *) game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    }
    
    return _game;
}

- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:[card contents] forState:UIControlStateSelected];
        [cardButton setTitle:[card contents] forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    
    NSString *matchingString = @"Last flip: ";
    
    if (self.game.cardsPlayed) {
        if (self.game.cardsPlayed.count == 1) {
            matchingString = [matchingString stringByAppendingString:[[self.game.cardsPlayed lastObject] contents]];
        } else {
            if (self.game.cardsPlayed.count == 2) {
                int points = self.game.score - self.lastScore;
                
                if (points >= 0) {
                    matchingString = [matchingString stringByAppendingString:@" Matched "];
                    
                    for (Card *card in self.game.cardsPlayed) {
                        matchingString = [matchingString stringByAppendingFormat:@"%@ ", [card contents]];
                    }
                    
                    matchingString = [matchingString stringByAppendingFormat:@"for %d points", points];
                } else {
                    matchingString = [matchingString stringByAppendingString:@" Didn't match "];
                    
                    for (Card *card in self.game.cardsPlayed) {
                        matchingString = [matchingString stringByAppendingFormat:@"%@ ", [card contents]];
                    }
                }
                
                self.lastScore = self.game.score;
            } else {
                for (Card *card in self.game.cardsPlayed) {
                    matchingString = [matchingString stringByAppendingFormat:@"%@ ", [card contents]];
                }
            }

        }
    }
    
    self.scoresLabel.text = [NSString stringWithFormat:@"Scores: %d", self.game.score];
}

- (void) setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", flipCount];
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

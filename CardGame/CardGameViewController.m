//
//  CardGameViewController.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 17/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) int lastScore;
@end

@implementation CardGameViewController

- (CardGame *) game {
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

@end

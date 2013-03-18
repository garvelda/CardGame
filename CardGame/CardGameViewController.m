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

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation CardGameViewController

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
        
        NSLog(@"score: %d", [self.game score]);
        self.scoresLabel.text = [NSString stringWithFormat:@"Scores: %d", [self.game score]];
    }
}

- (void) setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    if (!sender.selected) {
        self.flipCount++;
    }
    
    [self updateUI];
}

@end

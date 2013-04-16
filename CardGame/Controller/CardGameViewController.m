//
//  GameViewController.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 28/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardGameViewController.h"
#import "SetCardGameViewController.h"
#import "PlayingCardGame.h"
#import "SetCardGame.h"
#import "CardCollectionViewCell.h"
#import "CardView.h"
#import "Deck.h"

@implementation CardGameViewController

- (NSInteger) collectionView:(UICollectionView *)collectionView
      numberOfItemsInSection:(NSInteger)section {
    return [self.game.cards count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView
                   cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"card" forIndexPath:indexPath];
    
    if ([cell isKindOfClass:[CardCollectionViewCell class]]) {
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:(CardCollectionViewCell *)cell usingCard:card];
    }
    
    return cell;
}

- (void) updateCell:(CardCollectionViewCell *)cell usingCard:(Card *)card {}

- (Deck *) createDeck {
    return nil;
} 

- (CardGame *) game {
    if (!_game) {
        if ([self isKindOfClass:[PlayingCardGameViewController class]]) {
            _game = [[PlayingCardGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self createDeck]];
        } else if ([self isKindOfClass:[SetCardGameViewController class]]) {
            _game = [[SetCardGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self createDeck]];
        }
    }
    
    return _game;
}

- (GameResult *) gameResult {
    if (!_gameResult) {
        _gameResult = [[GameResult alloc] init];
    }
    
    return _gameResult;
}

- (void) updateUI {}

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", flipCount];
}

- (IBAction)dealPressed:(UIButton *)sender {
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    
    NSMutableArray *indexesToDelete = [[NSMutableArray alloc] init];
    
    for (int i=[self.game.cards count]; i<[self.cardCollectionView numberOfItemsInSection:0]; i++) {
        [indexesToDelete addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    if ([indexesToDelete count] > 0) {
        [self.cardCollectionView deleteItemsAtIndexPaths:indexesToDelete];
    }
    
    [self updateUI];
}

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture {
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        self.gameResult.score = self.game.score;
        self.flipCount++;
        [self updateUI];
    }
}

@end

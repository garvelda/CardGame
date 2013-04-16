//
//  CardGameViewController.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 17/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardGame.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "CardCollectionViewCell.h"

@implementation PlayingCardGameViewController

- (Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (NSInteger) startingCardCount {
    return 20;
}

- (void) updateCell:(CardCollectionViewCell *)cell usingCard:(Card *)card {
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *) card;
        
        if ([cell.cardView isKindOfClass:[PlayingCardView class]]) {
            PlayingCardView *playingCardView = (PlayingCardView *) cell.cardView;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            playingCardView.faceUp = playingCard.faceUp;
            playingCardView.alpha = playingCard.isUnplayable ? 0.3 : 1.0;
        }
    }
}

- (void) updateUI {
    for (CardCollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    
    NSString *matchingString = @"Last Flip: ";
    
    if (self.game.cardsPlayed) {
        if (self.game.cardsPlayed.count == 1) {
            matchingString = [matchingString stringByAppendingString:[[self.game.cardsPlayed lastObject] contents]];
        } else {
            if (self.game.cardsPlayed.count == 2) {
                if (self.game.isMatched) {
                    matchingString = [matchingString stringByAppendingString:@" Matched "];
                    
                    for (Card *card in self.game.cardsPlayed) {
                        matchingString = [matchingString stringByAppendingFormat:@"%@ ", [card contents]];
                    }
                } else {
                    matchingString = [matchingString stringByAppendingString:@" Didn't match "];
                    
                    for (Card *card in self.game.cardsPlayed) {
                        matchingString = [matchingString stringByAppendingFormat:@"%@ ", [card contents]];
                    }
                }
            } else {
                for (Card *card in self.game.cardsPlayed) {
                    matchingString = [matchingString stringByAppendingFormat:@"%@ ", [card contents]];
                }
            }

        }
    }
    
    self.lastFlipLabel.text = matchingString;
    self.scoresLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

@end

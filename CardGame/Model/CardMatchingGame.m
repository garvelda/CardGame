//
//  CardMatchingGame.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 18/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic,readwrite) NSUInteger score;
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int index=0; index<count; index++) {
            Card *card = [deck drawRamdonCard];
            
            if (card) {
                self.cards[index] = card;
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

#define MATCH_BONUS 4;
#define MISMATCH_PENALTY 1;
#define FLIP_COST 1;

- (void) flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    
                    if (matchScore) {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                }
            }
            
            self.score -= FLIP_COST;
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *) cardAtIndex:(NSUInteger)index {
    return index > self.cards.count ? nil : self.cards[index];
}

@end

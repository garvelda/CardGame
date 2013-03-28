//
//  CardGame.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 27/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "CardGame.h"

@interface CardGame()
@property (nonatomic, readwrite) NSUInteger score;
@property (nonatomic, readwrite) NSArray *cardsPlayed;
@end

@implementation CardGame

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

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 1
#define FLIP_COST 1

- (void) flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    NSMutableArray *othercardsFaceUpFound = [[NSMutableArray alloc] init];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [othercardsFaceUpFound addObject:otherCard];
                    
                    if (othercardsFaceUpFound.count == self.numberOfCardsToPlay-1) {
                        int matchScore = [card match:[othercardsFaceUpFound copy]];
                        
                        if (matchScore) {
                            card.unplayable = YES;
                            int points = matchScore * MATCH_BONUS;
                            self.score += points;
                            
                            for (Card *otherCard in othercardsFaceUpFound) {
                                otherCard.unplayable = YES;
                            }
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            
                            for (Card *otherCard in othercardsFaceUpFound) {
                                otherCard.faceUp = NO;
                            }
                        }
                    } else {
                        self.score -= FLIP_COST;
                    }
                }
            }
            
            [othercardsFaceUpFound addObject:card];
            self.cardsPlayed = [othercardsFaceUpFound copy];
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *) cardAtIndex:(NSUInteger)index {
    return index > self.cards.count ? nil : self.cards[index];
}

@end

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
@property (nonatomic, readwrite) NSUInteger score;
@property (nonatomic, readwrite) NSArray *cardsPlayed;
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

- (void) flipCardAtIndex:(NSUInteger)index withNumberOfMatchingCards:(NSUInteger)numberOfCards {
    Card *card = [self cardAtIndex:index];
    NSMutableArray *cardsFaceUpFound = [[NSMutableArray alloc] init];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [cardsFaceUpFound addObject:otherCard];
                    
                    if (cardsFaceUpFound.count == numberOfCards) {
                        int matchScore = [card match:[cardsFaceUpFound copy]];
                        
                        if (matchScore) {
                            card.unplayable = YES;
                            int points = matchScore * MATCH_BONUS
                            self.score += points;
                           
                            for (Card *otherCard in cardsFaceUpFound) {
                                otherCard.unplayable = YES;
                            }
                        } else {
                            self.score -= MISMATCH_PENALTY;

                            for (Card *otherCard in cardsFaceUpFound) {
                                otherCard.faceUp = NO;
                            }
                        }
                    }
                }
            }

            if (cardsFaceUpFound.count != numberOfCards) {
                self.score -= FLIP_COST;
            }
            
            [cardsFaceUpFound addObject:card];
            self.cardsPlayed = [cardsFaceUpFound copy];
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *) cardAtIndex:(NSUInteger)index {
    return index > self.cards.count ? nil : self.cards[index];
}

@end

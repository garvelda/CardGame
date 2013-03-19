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
@property (nonatomic, readwrite) NSString *matching;
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
    BOOL twoCards = NO;

    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    twoCards = YES;
                    int matchScore = [card match:@[otherCard]];
                    
                    if (matchScore) {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        int points = matchScore * MATCH_BONUS
                        self.score += points;
                        self.matching = [NSString stringWithFormat:@"Last flip: Matched %@ and %@ for %d points", [card contents], [otherCard contents], points];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.matching = [NSString stringWithFormat:@"Last flip: Didn't match %@ and %@", [card contents], [otherCard contents]];
                    }
                }
            }

            if (!twoCards) {
                self.matching = [NSString stringWithFormat:@"Last flip:  %@", [card contents]];
                self.score -= FLIP_COST;
            }
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

- (void) flipCardAtIndex:(NSUInteger)index withNumberOfMatchingCards:(NSUInteger)numberOfCards {
    Card *card = [self cardAtIndex:index];
    NSMutableArray *cardsFaceUpFound = [[NSMutableArray alloc] init];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            NSString *matchingString = @"Last flip: ";

            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [cardsFaceUpFound addObject:otherCard];
                    
                    if (cardsFaceUpFound.count == numberOfCards) {
                        int matchScore = [card match:[cardsFaceUpFound copy]];
                        
                        if (matchScore) {
                            card.unplayable = YES;
                            int points = matchScore * MATCH_BONUS
                            self.score += points;
                            matchingString = [matchingString stringByAppendingString:@" Matched "];
                           
                            for (Card *otherCard in cardsFaceUpFound) {
                                otherCard.unplayable = YES;
                                matchingString = [matchingString stringByAppendingFormat:@"%@ ", [otherCard contents]];
                            }
                            
                            matchingString = [matchingString stringByAppendingFormat:@"%@ for %d points", [card contents], points];
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            matchingString = [matchingString stringByAppendingString:@" Didn't match "];

                            for (Card *otherCard in cardsFaceUpFound) {
                                otherCard.faceUp = NO;
                                matchingString = [matchingString stringByAppendingFormat:@"%@ ", [otherCard contents]];
                            }
                            
                            matchingString = [matchingString stringByAppendingFormat:@"%@", [card contents]];
                        }
                    }
                }
            }
            
            if (cardsFaceUpFound.count != numberOfCards) {
                self.matching = [matchingString stringByAppendingFormat:@"%@", [card contents]];
                self.score -= FLIP_COST;
            } else {
                self.matching = matchingString;
            }
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *) cardAtIndex:(NSUInteger)index {
    return index > self.cards.count ? nil : self.cards[index];
}

@end

//
//  CardSetGame.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 27/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "SetCardGame.h"

@interface SetCardGame()
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSArray *cardsPlayed;
@property (nonatomic, readwrite, getter=isMatched) BOOL matched;
@end

@implementation SetCardGame

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 10
#define FLIP_COST 1

- (void) flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    NSMutableArray *othercardsFaceUpFound = [[NSMutableArray alloc] init];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [othercardsFaceUpFound addObject:otherCard];
                    
                    if (othercardsFaceUpFound.count == 2) {
                        int matchScore = [card match:[othercardsFaceUpFound copy]];
                        
                        if (matchScore) {
                            self.matched = YES;
                            self.score += matchScore * MATCH_BONUS;
                            card.unplayable = YES;
                            
                            for (Card *otherCard in othercardsFaceUpFound) {
                                otherCard.unplayable = YES;
                            }
                        } else {
                            self.matched = NO;
                            self.score -= MISMATCH_PENALTY;
                            card.faceUp = YES;
                            
                            for (Card *otherCard in othercardsFaceUpFound) {
                                otherCard.faceUp = NO;
                            }
                        }
                    }
                }
            }
            
            [othercardsFaceUpFound addObject:card];
            self.cardsPlayed = [othercardsFaceUpFound copy];
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

- (void) addCardUsingDeck:(SetCardDeck *)deck {
    Card *card = [deck drawRamdonCard];
    
    if (card) {
        [self.cards addObject:card];
    }
}

@end

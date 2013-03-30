//
//  CardMatchingGame.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 18/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "PlayingCardGame.h"

@interface PlayingCardGame()
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSArray *cardsPlayed;
@property (nonatomic, readwrite, getter=isMatched) BOOL matched;
@end

@implementation PlayingCardGame

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
                    
                    if (othercardsFaceUpFound.count == 1) {
                        int matchScore = [card match:[othercardsFaceUpFound copy]];
                        
                        if (matchScore) {
                            self.matched = YES;
                            card.unplayable = YES;
                            int points = matchScore * MATCH_BONUS;
                            self.score += points;
                            
                            for (Card *otherCard in othercardsFaceUpFound) {
                                otherCard.unplayable = YES;
                            }
                        } else {
                            self.matched = NO;
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

@end

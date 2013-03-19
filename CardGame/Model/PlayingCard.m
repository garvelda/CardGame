//
//  PlayingCard.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 17/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit;

- (NSString *) contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void) setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *) suit {
    return _suit ? _suit : @"?";
}

- (void) setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int) match: (NSArray *) otherCards {
    int score = 0;
    
    if (otherCards.count == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        
        if ([self.suit isEqualToString:otherCard.suit]) {
            score += 1;
        } else if (self.rank == otherCard.rank) {
            score += 4;
        }
    } else if (otherCards.count == 2) {
        PlayingCard *otherCard1 = otherCards[0];
        PlayingCard *otherCard2 = otherCards[1];
        
        if (self.rank == otherCard1.rank && self.rank == otherCard2.rank) {
            score += 8;
        } else if (self.rank == otherCard1.rank || self.rank == otherCard2.rank || otherCard1.rank == otherCard2.rank) {
            score += 4;
        }
        
        if ([self.suit isEqualToString:otherCard1.suit] && [self.suit isEqualToString:otherCard2.suit]) {
            score += 4;
        } else if ([self.suit isEqualToString:otherCard1.suit] || [self.suit isEqualToString:otherCard2.suit] || [otherCard1.suit isEqualToString:otherCard2.suit]) {
            score += 1;
        } 
    }
    
    return score;
}

+ (NSArray *) validSuits {
    return @[@"♣", @"♠", @"♦", @"♥"];
}

+ (NSArray *) rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank {
    return [PlayingCard rankStrings].count-1;
}

@end

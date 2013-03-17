//
//  PlayingCardDeck.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 17/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "PlayingCardDeck.h"

@implementation PlayingCardDeck

- (id) init {
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank=1; rank<=[PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                [super addcard:card atTop:YES];
            }
        }
    }
    
    return self;
}

@end

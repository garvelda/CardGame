//
//  SetCardDeck.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 27/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id) init {
    self = [super init];
    
    if (self) {
        for (NSString *symbol in [SetCard validSymbols]) {
            for (NSString *color in [SetCard validColors]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSUInteger rank=1; rank<=[SetCard maxRank]; rank++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.color = color;
                        card.shading = shading;
                        card.rank = rank;
                        [super addcard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

@end

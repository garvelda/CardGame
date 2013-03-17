//
//  Deck.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 17/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray *) cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (void) addcard:(Card *) card atTop:(BOOL) top {
    if (top) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (Card *) drawRamdonCard {
    Card *randomCard;
    
    if (self.cards.count) {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
    }
    
    return randomCard;
}

@end

//
//  CardGame.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 27/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "CardGame.h"

@interface CardGame()
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSArray *cardsPlayed;
@property (nonatomic, readwrite, getter=isMatched) BOOL matched;
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

- (void) flipCardAtIndex:(NSUInteger)index {}

- (Card *) cardAtIndex:(NSUInteger)index {
    return index > self.cards.count ? nil : self.cards[index];
}

@end

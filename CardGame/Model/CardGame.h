//
//  CardGame.h
//  CardGame
//
//  Created by David Eleazar García Santiago on 27/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardGame : NSObject
- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck*) deck;
- (void) flipCardAtIndex:(NSUInteger)index;
- (Card *) cardAtIndex:(NSUInteger)index;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readonly) NSArray *cardsPlayed;
@property (nonatomic, readonly, getter=isMatched) BOOL matched;
@property (nonatomic, readonly) int score;
@end

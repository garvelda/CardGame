//
//  CardMatchingGame.h
//  CardGame
//
//  Created by David Eleazar García Santiago on 18/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject
- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck*) deck;
- (void) flipCardAtIndex:(NSUInteger)index;
- (Card *) cardAtIndex:(NSUInteger)index;
@property (nonatomic,readonly) NSUInteger score;
@end

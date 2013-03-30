//
//  PlayingCard.h
//  CardGame
//
//  Created by David Eleazar García Santiago on 17/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card
@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;
+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;
@end

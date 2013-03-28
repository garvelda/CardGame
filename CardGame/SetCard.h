//
//  SetCard.h
//  CardGame
//
//  Created by David Eleazar García Santiago on 27/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (nonatomic) NSUInteger number;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *shading;
@property (nonatomic, strong) NSString *color;
+ (NSUInteger) maxNumber;
+ (NSArray *) validSymbols;
+ (NSArray *) validColors;
+ (NSArray *) validShadings;
@end

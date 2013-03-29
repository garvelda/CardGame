//
//  SetCard.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 27/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize symbol = _symbol;
@synthesize shading = _shading;
@synthesize color = _color;

- (void) setNumber:(NSUInteger) number {
    if (number <= [SetCard maxNumber]) {
        _number = number;
    }
}

- (NSString *) symbol {
    return _symbol ? _symbol : @"?";
}

- (void) setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *) shading {
    return _shading ? _shading : @"?";
}

- (void) setShading:(NSString *)shading {
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSString *) color {
    return _color ? _color : @"?";
}

- (void) setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (NSString *) contents {
    return [NSString stringWithFormat:@"%@|%@|%@|%@", [SetCard numberStrings][self.number], self.symbol, self.color, self.shading];
}

#define SET_FOUND 4
#define NUMBER_CARDS_IN_SET 3

- (int) match: (NSArray *) otherCards {
    int score = 0;
    
    if (otherCards.count == NUMBER_CARDS_IN_SET-1) {
        SetCard *otherCard1 = otherCards[0];
        SetCard *otherCard2 = otherCards[1];
        
        BOOL numbersEqual = self.number == otherCard1.number && self.number == otherCard2.number ? YES : NO;
        BOOL numbersDiffer = self.number != otherCard1.number && self.number != otherCard2.number && otherCard1.number != otherCard2.number ? YES : NO;
        BOOL colorsEqual = [self.color isEqualToString:otherCard1.color] && [self.color isEqualToString:otherCard2.color] ? YES : NO;
        BOOL colorsDiffer = ![self.color isEqualToString:otherCard1.color] && ![self.color isEqualToString:otherCard2.color] && ![otherCard1.color isEqualToString:otherCard2.color] ? YES : NO;
        BOOL symbolsEqual = [self.symbol isEqualToString:otherCard1.symbol] && [self.symbol isEqualToString:otherCard2.symbol] ? YES : NO;
        BOOL symbolsDiffer = ![self.symbol isEqualToString:otherCard1.symbol] && ![self.symbol isEqualToString:otherCard2.symbol] && ![otherCard1.symbol isEqualToString:otherCard2.symbol] ? YES : NO;
        BOOL shadingsEqual = [self.shading isEqualToString:otherCard1.shading] && [self.shading isEqualToString:otherCard2.shading] ? YES : NO;
        BOOL shadingsDiffer = ![self.shading isEqualToString:otherCard1.shading] && ![self.shading isEqualToString:otherCard2.shading] && ![otherCard1.shading isEqualToString:otherCard2.shading] ? YES : NO;

        if ((numbersEqual || numbersDiffer) && (colorsEqual || colorsDiffer) && (symbolsEqual || symbolsDiffer) && (shadingsEqual || shadingsDiffer)) {
            score += SET_FOUND;
        }
    }
    
    return score;
}

+ (NSUInteger) maxNumber {
    return [SetCard numberStrings].count-1;
}

+ (NSArray *) numberStrings {
    return @[@"?", @"1", @"2", @"3"];
}

+ (NSArray *) validSymbols {
    return @[@"▲", @"■", @"●"];
}

+ (NSArray *) validColors {
    return @[@"red", @"green", @"blue"];
}

+ (NSArray *) validShadings {
    return @[@"solid", @"stripped", @"open"];
}

@end

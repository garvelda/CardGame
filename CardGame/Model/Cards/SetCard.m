//
//  SetCard.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 27/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()
+ (NSDictionary *) uiColors;
+ (NSDictionary *) shadings;
+ (CGFloat) floatShading:(NSString *)shading;
@end

@implementation SetCard

@synthesize symbol = _symbol;
@synthesize shading = _shading;
@synthesize color = _color;

- (void) setNumber:(NSUInteger) rank {
    if (rank <= [SetCard maxRank]) {
        _rank = rank;
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
    return [NSString stringWithFormat:@"%@|%@|%@|%@", [SetCard rankStrings][self.rank], self.symbol, self.color, self.shading];
}

#define SET_FOUND 4
#define NUMBER_CARDS_IN_SET 3
#define SOLID_SHADING 1.0
#define STRIPPED_SHADING 0.3
#define OPEN_SHADING 0

- (int) match: (NSArray *) otherCards {
    int score = 0;
    
    if (otherCards.count == NUMBER_CARDS_IN_SET-1) {
        SetCard *otherCard1 = otherCards[0];
        SetCard *otherCard2 = otherCards[1];
        
        BOOL ranksEqual = self.rank == otherCard1.rank && self.rank == otherCard2.rank ? YES : NO;
        BOOL ranksDiffer = self.rank != otherCard1.rank && self.rank != otherCard2.rank && otherCard1.rank != otherCard2.rank ? YES : NO;
        BOOL colorsEqual = [self.color isEqualToString:otherCard1.color] && [self.color isEqualToString:otherCard2.color] ? YES : NO;
        BOOL colorsDiffer = ![self.color isEqualToString:otherCard1.color] && ![self.color isEqualToString:otherCard2.color] && ![otherCard1.color isEqualToString:otherCard2.color] ? YES : NO;
        BOOL symbolsEqual = [self.symbol isEqualToString:otherCard1.symbol] && [self.symbol isEqualToString:otherCard2.symbol] ? YES : NO;
        BOOL symbolsDiffer = ![self.symbol isEqualToString:otherCard1.symbol] && ![self.symbol isEqualToString:otherCard2.symbol] && ![otherCard1.symbol isEqualToString:otherCard2.symbol] ? YES : NO;
        BOOL shadingsEqual = [self.shading isEqualToString:otherCard1.shading] && [self.shading isEqualToString:otherCard2.shading] ? YES : NO;
        BOOL shadingsDiffer = ![self.shading isEqualToString:otherCard1.shading] && ![self.shading isEqualToString:otherCard2.shading] && ![otherCard1.shading isEqualToString:otherCard2.shading] ? YES : NO;

        if ((ranksEqual || ranksDiffer) && (colorsEqual || colorsDiffer) && (symbolsEqual || symbolsDiffer) && (shadingsEqual || shadingsDiffer)) {
            score += SET_FOUND;
        }
    }
    
    return score;
}

+ (NSUInteger) maxRank {
    return [SetCard rankStrings].count-1;
}

+ (NSArray *) rankStrings {
    return @[@"?", @"1", @"2", @"3"];
}

+ (NSArray *) validSymbols {
    return @[@"diamond", @"oval", @"squiggle"];
}

+ (NSArray *) validColors {
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *) validShadings {
    return @[@"solid", @"stripped", @"open"];
}

+ (UIColor *) uiColor:(NSString *)color {
    return [SetCard uiColors][color];
}

+ (UIColor *) uiColor:(NSString *)color withShading:(NSString *)shading {
    return [[SetCard uiColor:color] colorWithAlphaComponent:[self floatShading:shading]];
}

+ (NSDictionary *) uiColors {
    return @{@"red" : [UIColor redColor], @"green" : [UIColor greenColor], @"purple" : [UIColor purpleColor]};
}

+ (CGFloat) floatShading:(NSString *)shading {
    return [[SetCard shadings][shading] floatValue];
}

+ (NSDictionary *) shadings {
    return @{@"solid" : @SOLID_SHADING, @"stripped" : @STRIPPED_SHADING, @"open" : @OPEN_SHADING};
}

@end

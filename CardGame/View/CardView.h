//
//  CardView.h
//  CardGame
//
//  Created by David Eleazar García Santiago on 30/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView
@property (nonatomic) NSUInteger rank;
@property (nonatomic) BOOL faceUp;
- (NSString *)rankAsString; // abstract
@end

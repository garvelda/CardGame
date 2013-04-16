//
//  SetCardView.h
//  CardGame
//
//  Created by David Eleazar García Santiago on 30/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "CardView.h"
#import "SetCard.h"

@interface SetCardView : CardView
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;
@end

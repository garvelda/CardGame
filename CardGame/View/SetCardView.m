//
//  SetCardView.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 30/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

#define CORNER_RADIUS 12
#define CORNER_OFFSET_X 5
#define CORNER_OFFSET_Y 25
#define SYMBOL_WIDTH 10.0
#define SYMBOL_HEIGHT 20.0
#define SYMBOL_SHIFT 5

- (void)setSymbol:(NSString *)symbol {
    _symbol = symbol;
    [self setNeedsDisplay];
}

- (void)setShading:(NSString *)shading {
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setColor:(NSString *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect {
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];

    int initialOffset = self.rank == 3 ? CORNER_OFFSET_X : CORNER_OFFSET_X + (2*SYMBOL_WIDTH - SYMBOL_SHIFT)/self.rank;
    
    for (int i=0; i<self.rank; i++) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, initialOffset + (SYMBOL_WIDTH + SYMBOL_SHIFT)*i, CORNER_OFFSET_Y);
        
        [self drawSymbolWithContext:context
                         usingColor:self.color
                         andShading:self.shading];
        
        CGContextRestoreGState(UIGraphicsGetCurrentContext());
    }
}

- (void) drawSymbolWithContext:(CGContextRef)context
                    usingColor:(NSString *)color
                    andShading:(NSString *)shading {
    if ([self.symbol isEqualToString:@"oval"]) {
        [self drawOvalWithContext:context usingColor:color andShading:shading];
    } else if ([self.symbol isEqualToString:@"diamond"]) {
        [self drawDiamondWithContext:context usingColor:color andShading:shading];
    } else if ([self.symbol isEqualToString:@"squiggle"]) {
        [self drawSquiggleWithContext:context usingColor:color andShading:shading];
    }
}

- (void) drawOvalWithContext:(CGContextRef)context
                  usingColor:(NSString *)color
                  andShading:(NSString *)shading {
    CGRect drawingRectangle;
    drawingRectangle.origin.x = 0;
    drawingRectangle.origin.y = 0;
    drawingRectangle.size.width = SYMBOL_WIDTH;
    drawingRectangle.size.height = SYMBOL_HEIGHT;
    
    UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:drawingRectangle];
    [[SetCard uiColor:color] setStroke];
    [oval stroke];
    UIColor *colorDeRelleno = [SetCard uiColor:color withShading:shading];
    [colorDeRelleno setFill];
    [oval fill];
}

- (void) drawDiamondWithContext:(CGContextRef)context
                     usingColor:(NSString *)color
                     andShading:(NSString *)shading {
    CGContextMoveToPoint(context, SYMBOL_WIDTH / 2, 0);
    CGContextAddLineToPoint(context, SYMBOL_WIDTH, SYMBOL_HEIGHT / 2);
    CGContextAddLineToPoint(context, SYMBOL_WIDTH / 2, SYMBOL_HEIGHT);
    CGContextAddLineToPoint(context, 0, SYMBOL_HEIGHT / 2);
    CGContextClosePath(context);
    
    CGContextSetStrokeColorWithColor(context, [SetCard uiColor:color].CGColor);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, SYMBOL_WIDTH / 2, 0);
    CGContextAddLineToPoint(context, SYMBOL_WIDTH, SYMBOL_HEIGHT / 2);
    CGContextAddLineToPoint(context, SYMBOL_WIDTH / 2, SYMBOL_HEIGHT);
    CGContextAddLineToPoint(context, 0, SYMBOL_HEIGHT / 2);
    CGContextClosePath(context);

    CGContextSetFillColorWithColor(context, [SetCard uiColor:color withShading:shading].CGColor);
    CGContextFillPath(context);
}

- (void) drawSquiggleWithContext:(CGContextRef)context
                      usingColor:(NSString *)color
                      andShading:(NSString *)shading {
    UIBezierPath *squiggle = [UIBezierPath bezierPath];
    
    [squiggle moveToPoint:CGPointMake(0, SYMBOL_HEIGHT/8)];
    [squiggle addArcWithCenter:CGPointMake(SYMBOL_WIDTH/4, SYMBOL_HEIGHT/8) radius:SYMBOL_WIDTH/4 startAngle:M_PI endAngle:3*M_PI/2 clockwise:YES];
    [squiggle addLineToPoint:CGPointMake(SYMBOL_WIDTH/2, 0)];
    [squiggle addArcWithCenter:CGPointMake(SYMBOL_WIDTH/2, SYMBOL_HEIGHT/8) radius:SYMBOL_WIDTH/4 startAngle:3*M_PI/2 endAngle:0 clockwise:YES];
    [squiggle addLineToPoint:CGPointMake(3*SYMBOL_WIDTH/4, 6*SYMBOL_HEIGHT/8)];
    [squiggle addArcWithCenter:CGPointMake(SYMBOL_WIDTH, 6*SYMBOL_HEIGHT/8) radius:SYMBOL_WIDTH/4 startAngle:M_PI endAngle:M_PI/2 clockwise:NO];
    [squiggle addArcWithCenter:CGPointMake(3*SYMBOL_WIDTH/4, 7*SYMBOL_HEIGHT/8) radius:SYMBOL_WIDTH/4 startAngle:0 endAngle:M_PI/2 clockwise:YES];
    [squiggle addLineToPoint:CGPointMake(SYMBOL_WIDTH/2, SYMBOL_HEIGHT)];
    [squiggle addArcWithCenter:CGPointMake(SYMBOL_WIDTH/2, 7*SYMBOL_HEIGHT/8) radius:SYMBOL_WIDTH/4 startAngle:M_PI/2 endAngle:M_PI clockwise:YES];
    [squiggle addLineToPoint:CGPointMake(SYMBOL_WIDTH/4, SYMBOL_HEIGHT/4)];
    [squiggle addArcWithCenter:CGPointMake(0, SYMBOL_HEIGHT/4) radius:SYMBOL_WIDTH/4 startAngle:0 endAngle:3*M_PI/2 clockwise:NO];

    [[SetCard uiColor:color] setStroke];
    [squiggle stroke];
    [[SetCard uiColor:color withShading:shading] setFill];
    [squiggle fill];
}

@end

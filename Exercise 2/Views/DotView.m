//
//  DotView.m
//  Exercise 2
//
//  Created by Mike on 2/10/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import "DotView.h"

@implementation DotView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSInteger colorIndex = 0;
    NSInteger dotWidth = MAX((self.bounds.size.width / _coloumns.integerValue), 2);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < _rows.integerValue; i++) {
        for (int j = 0; j < _coloumns.integerValue; j++) {
            CGRect rect = CGRectMake(j * dotWidth, i * dotWidth, dotWidth, dotWidth);
            CGContextAddEllipseInRect(ctx, rect);
            CGContextSetFillColorWithColor(ctx, ((UIColor *)[_colors objectAtIndex:colorIndex]).CGColor);
            CGContextFillPath(ctx);
            
            CGContextSetLineWidth(ctx, 1);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextStrokeEllipseInRect(ctx, rect);
            
            colorIndex = (colorIndex >= _colors.count - 1) ? 0 : colorIndex + 1;
        }
    }
}

-(UIImage *)imageRepresentation
{
    UIGraphicsBeginImageContext(self.frame.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    return UIGraphicsGetImageFromCurrentImageContext();
}

-(void)clearDots
{
    _coloumns = 0;
    _rows = 0;
    [self setNeedsDisplay];
}

@end

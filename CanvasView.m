//
//  CanvasView.m
//  Paint App
//
//  Created by Ben Flannery on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CanvasView.h"


@implementation CanvasView
{
    BOOL drawing;
    Line *lineBuffer;
}

@synthesize lines, currentLine;


#pragma mark ReaderContentPage class methods

+ (Class)layerClass
{
	return [CanvasContentTile class];
}

-(id)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        
        self.currentLine = [[Line alloc] init];
        self.lines = [NSMutableArray arrayWithCapacity:10];
        
        self.autoresizesSubviews = NO;
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeRedraw;
        self.autoresizingMask = UIViewAutoresizingNone;
        self.backgroundColor = [UIColor clearColor];

        
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context
{
    drawing = YES;
    UIGraphicsBeginImageContext(self.frame.size);
    
    if ([self.lines count] > 0) {
        for (Line *tempLine in self.lines){
            CGContextSetAlpha(context, tempLine.opacity);
            CGContextSetStrokeColorWithColor(context, tempLine.lineColor.CGColor);
            CGContextSetLineWidth(context, tempLine.lineWidth);
            CGContextSetLineCap(context, kCGLineCapRound);
            CGContextSetLineJoin(context, kCGLineJoinRound);
            CGContextAddPath(context, tempLine.linePath);
            CGContextStrokePath(context);
            
        }
    }
    
    if (lineBuffer)
    {
        [self.lines addObject:lineBuffer];
        CGContextSetAlpha(context, lineBuffer.opacity);
        CGContextSetStrokeColorWithColor(context, lineBuffer.lineColor.CGColor);
        CGContextSetLineWidth(context, lineBuffer.lineWidth);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextAddPath(context, lineBuffer.linePath);
        CGContextStrokePath(context);
        lineBuffer = NULL;
        NSLog(@"LineBuffer");
    }
    
    
    //draw current line
    CGContextSetAlpha(context, self.currentLine.opacity);
  
    CGContextSetStrokeColorWithColor(context, self.currentLine.lineColor.CGColor);
    CGContextSetLineWidth(context, self.currentLine.lineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextBeginPath(context);
    CGContextAddPath(context, self.currentLine.linePath);
    CGContextStrokePath(context);
 
    UIGraphicsEndImageContext();
    drawing = NO;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint cPoint = [touch locationInView:self];
    
	CGPathMoveToPoint(self.currentLine.linePath, NULL, cPoint.x, cPoint.y);
    
    [self calcDrawRectWithTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];	
	CGPoint currentPoint = [touch locationInView:self];
    
    CGPathAddLineToPoint(self.currentLine.linePath, NULL, currentPoint.x, currentPoint.y);
	
    [self calcDrawRectWithTouches:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {	
	UITouch *touch = [touches anyObject];
    CGPoint cPoint = [touch locationInView:self];
    CGPathAddLineToPoint(self.currentLine.linePath, NULL, cPoint.x, cPoint.y);

    if (!drawing)
    {
        [self.lines addObject:self.currentLine];
        lineBuffer = NULL;
    }
    else
    {
        lineBuffer = self.currentLine;
    }
    
    Line *nextLine = [[Line alloc] initWithOptions:self.currentLine.lineWidth color:self.currentLine.lineColor opacity:self.currentLine.opacity];
    self.currentLine = nextLine;
    
    [self calcDrawRectWithTouches:touches];
   }

- (void)removeFromSuperview
{
	self.layer.delegate = nil;
	[super removeFromSuperview];
}

#pragma mark redraw rect

-(void)calcDrawRectWithTouches:(NSSet*)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint cPoint = [touch locationInView:self];
    
    CGRect rDraw = CGRectMake(cPoint.x-16, cPoint.y-16, 32, 32);
    
    [self setNeedsDisplayInRect:rDraw];
}



@end

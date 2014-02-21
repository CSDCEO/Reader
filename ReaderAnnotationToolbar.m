//
//  ReaderAnnotationToolbar.m
//  Reader
//
//  Created by Benoit Gour on 2/18/2014.
//
//

#import "ReaderAnnotationToolbar.h"

#import <QuartzCore/QuartzCore.h>

@implementation ReaderAnnotationToolbar
{
    UILabel     *lblSize;
    UISlider    *slSize;
}


#pragma mark Constants

#define SIZE_LABEL_WIDTH 40.0f
#define SIZE_LABEL_HEIGHT 15.0f

#define SIZE_SLIDE_WIDTH 100.0f

#define BAR_SPACE  20.0f
#define BAR_SMALL_SPACE 4.0

@synthesize delegate;

#pragma mark ReaderAnnoatation class methods
+ (Class)layerClass
{
    return [CAGradientLayer class];
}


#pragma mark ReaderAnnotation instance methods
- (id) initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        self.autoresizesSubviews = YES;
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeRedraw;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat posX = BAR_SPACE/4;
        CGFloat posY = (self.bounds.size.height / 2) - (SIZE_LABEL_HEIGHT/2);
   
        CGRect sizeFrame = CGRectMake(posX, posY, SIZE_LABEL_WIDTH, SIZE_LABEL_HEIGHT);
        
        lblSize = [[UILabel alloc] initWithFrame:sizeFrame];
        lblSize.text = @"Size:";
        lblSize.autoresizesSubviews = NO;
		lblSize.autoresizingMask = UIViewAutoresizingNone;
		lblSize.textAlignment = NSTextAlignmentLeft;
		lblSize.backgroundColor = [UIColor clearColor];
		lblSize.textColor = [UIColor whiteColor];
		lblSize.font = [UIFont boldSystemFontOfSize:16.0f];
		lblSize.shadowOffset = CGSizeMake(0.0f, 1.0f);
		lblSize.shadowColor = [UIColor blackColor];
		lblSize.adjustsFontSizeToFitWidth = YES;
		lblSize.minimumScaleFactor = 0.75f;

        [self addSubview:lblSize];
        
        posX += BAR_SMALL_SPACE + SIZE_LABEL_WIDTH;
        
        CGRect slSizeFrame =  CGRectMake(posX, posY, SIZE_SLIDE_WIDTH, SIZE_LABEL_HEIGHT);
        slSize = [[UISlider alloc]initWithFrame:slSizeFrame];
        slSize.minimumValue = 1.0f;
        slSize.maximumValue = 10.0f;


        [self addSubview:slSize];
        
    }
    
    return  self;
}


-(void)hideToolbar
{
    if (self.hidden == NO)
    {
        [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^(void)
        {
            self.alpha=0.0f;
        }
        completion:^(BOOL finished)
        {
            self.hidden = YES;
        }];
    }
}

-(void)showToolbar
{
    if (self.hidden == YES) // Only if hidden
	{
		//[self updatePagebarViews]; // Update views first
        
		[UIView animateWithDuration:0.25 delay:0.0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^(void)
         {
             self.hidden = NO;
             self.alpha = 1.0f;
         }
                         completion:NULL
         ];
	}

}




@end
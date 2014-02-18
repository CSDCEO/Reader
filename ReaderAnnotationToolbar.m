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
    
}

@synthesize delegate;

#pragma mark ReaderAnnoatation class methods
+ (Class)layerClass
{
    return [CAGradientLayer class];
}

@end
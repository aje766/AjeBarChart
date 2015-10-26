//
//  ViewController.m
//  MyBarChartC
//
//  Created by Aurionpro2 on 15/05/15.
//  Copyright (c) 2015 Aurionpro. All rights reserved.
//

#import "ViewController.h"




@interface ViewController ()
{

    UIScrollView *ScrollViewForHorLegend;
    UIScrollView *ScrollViewForVerLegend;
    
    UIView *clViewBarSet1;
    UILabel *clViewBarSetLabel1;
    
    NSMutableArray *clArrMainData;
    
    
    ////Data for Bar
    
    CGFloat clMaxBarValue;
    CGFloat clMaxBarPx;
    int clMaxBarCountInBarSets;
    
    
    ///Pixel Height for value 1 bar
    CGFloat clPixelValForSingleVale;
    CGFloat clBarSetWidth;
    CGFloat clBarSetHeight;
    
     CGFloat clBarSetTopSpace;
    CGFloat clBarSetLeftSpace;
    
    CGFloat clBarSetLabelHeight;
    
    
    //manually Inithalize First
    ///Space between every bar in graph
    CGFloat clBarSpace;
    ///Width of every bar in graph
    CGFloat clBarWidth;
    
    CGFloat clGraphHeight;
    CGFloat clGraphWidth;
    
    
    
    CGSize clOriginalContentViewSize;
    
    NSMutableArray *clArrBarAndLabel;
    
    CGFloat clSpaceBetweenBarAndBarCountLabel;
    
    
    NSMutableArray *clArrYAxisLineAndLabel;
    
    CGFloat clYAxisLegendWidth;
    
    CGFloat clGraphLeftPadding;
    
    
    
    UIView * clYAxisGraphLine;
    UIView * clXAxisGraphLine;
    
    NSMutableArray *clBarTypeName;
    
    NSMutableArray *colorArray;
    
}
@end

@implementation ViewController
@synthesize barView ;

@synthesize scrollView = _scrollView;
@synthesize containerView = _containerView;
@synthesize propViewLagendYHolder;


-(void)makDataForAccount:(NSString*)accNo A:(NSString*)a B:(NSString*)b C:(NSString*)c D:(NSString*)d E:(NSString*)e F:(NSString*)f
{
    
    NSMutableArray *arrAcVolList = [[NSMutableArray alloc] init];
    
    if(![a  isEqualToString: @""] && ![a  isEqualToString: @"0"])
    {
        NSMutableDictionary *innerData1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"GBP",@"debitCurrencyCode", @"A", @"paymentMethodName",a, @"totalCount", nil];
        [arrAcVolList addObject:innerData1];
    }
    
    if(![b  isEqualToString: @""] && ![b  isEqualToString: @"0"])
    {
        NSMutableDictionary *innerData2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"GBP",@"debitCurrencyCode", @"B", @"paymentMethodName",b, @"totalCount", nil];
        [arrAcVolList addObject:innerData2];
    }
                                    
    if(![c  isEqualToString: @""] && ![c  isEqualToString: @"0"])
    {
        NSMutableDictionary *innerData3 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"GBP",@"debitCurrencyCode", @"C", @"paymentMethodName",c, @"totalCount", nil];
        [arrAcVolList addObject:innerData3];
    }
    
    if(![d  isEqualToString: @""] && ![d  isEqualToString: @"0"])
    {
        NSMutableDictionary *innerData4= [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"GBP",@"debitCurrencyCode", @"D", @"paymentMethodName",d, @"totalCount", nil];
        [arrAcVolList addObject:innerData4];
    }

    
    
    if(![e  isEqualToString: @""] && ![e  isEqualToString: @"0"])
    {
        NSMutableDictionary *innerData5 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"GBP",@"debitCurrencyCode", @"E", @"paymentMethodName",e, @"totalCount", nil];
        [arrAcVolList addObject:innerData5];
    }


    if(![f  isEqualToString: @""] && ![f isEqualToString: @"0"])
    {
            NSMutableDictionary *innerData6 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"GBP",@"debitCurrencyCode", @"F", @"paymentMethodName",f, @"totalCount", nil];
            [arrAcVolList addObject:innerData6];
    }

    

    
    NSMutableDictionary *barSet = [[NSMutableDictionary alloc] initWithObjectsAndKeys:accNo, @"accountNo", arrAcVolList, @"accountVolumeList", nil];
    
    if(clArrMainData == nil)
    {
        clArrMainData  = [[NSMutableArray alloc] init];
    }
    
    [clArrMainData addObject:barSet];
}

-(void)myMainData
{
    [self makDataForAccount:@"9757036075" A:@"4" B:@"10" C:@"0" D:@"2" E:@"0" F:@"0"];
    [self makDataForAccount:@"8655442377" A:@"2" B:@"3" C:@"7" D:@"7" E:@"0" F:@"0"];
    [self makDataForAccount:@"9757062517" A:@"1" B:@"2" C:@"3" D:@"13" E:@"5" F:@"6"];
    [self makDataForAccount:@"9987602314" A:@"0" B:@"0" C:@"0" D:@"0" E:@"0" F:@"0"];
    [self makDataForAccount:@"3231100" A:@"8" B:@"8" C:@"4" D:@"2" E:@"4" F:@"4"];
    [self makDataForAccount:@"1111111111" A:@"5" B:@"5" C:@"5" D:@"5" E:@"5" F:@"5"];
    
}


-(UIColor*)setColorOfBar:(UIView*)barObject forKey:(NSString*)strKey
{
    UIColor *SelectedColor = [UIColor blackColor];
    @try {
        BOOL identicalStringFound = NO;
        for (int i = 0; i<clBarTypeName.count; i++) {
            if ([[clBarTypeName objectAtIndex:i] isEqualToString:strKey]) {
                identicalStringFound = YES;
                if(i<colorArray.count)
                {
                    barObject.backgroundColor = [colorArray objectAtIndex:i];
                    SelectedColor = barObject.backgroundColor;
                }
                else
                {
                    int modVal = (int)(clBarTypeName.count % colorArray.count) - 1;
                    barObject.backgroundColor = [colorArray objectAtIndex:modVal];
                    SelectedColor = barObject.backgroundColor;
                    
                }
                break;
            }
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(exception.description,nil);
        NSLog(@"SetColor Error",nil);
    }
    @finally {
        return SelectedColor;
    }
    
    
}




//Inititalize parameters
-(void)initializeGraphParameterWithView:(CGRect)frame barWidth:(CGFloat) bWidth barSpcae:(CGFloat) bSpace
{
    
    [self myMainData];
    
    //initialize required variable
    clBarWidth = bWidth;
    clBarSpace = bSpace;
    
    //initialize clMaxBarValue
    clMaxBarValue = [self getMaxValueFromMainData];
  
    //change the bar top spcae
    CGFloat topSpaceOfHighestBar = 20; //CHANGE
   // CGFloat bottomSpaceOfHighestBar = 20; //CHANGE  i.e. use for label of barSet
    
    clBarSetTopSpace = topSpaceOfHighestBar;
    
    clBarSetLeftSpace = 10;
    clMaxBarPx = frame.size.height - topSpaceOfHighestBar;
    
    clBarSetHeight = clMaxBarPx;
    clPixelValForSingleVale = clMaxBarPx / clMaxBarValue;
    
    clBarSetLabelHeight = 20;
    
    clSpaceBetweenBarAndBarCountLabel = 2;
    
    
    

    
}

-(CGFloat)getMaxValueFromMainData
{
    CGFloat MaxVal = 0.0;
    int countMaxNoOfBarInBarSet = 0;
    
    clBarTypeName = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<clArrMainData.count; i++) {
        NSDictionary *barSet = (NSDictionary*)[clArrMainData objectAtIndex:i];
        NSString *strAccountNo = [barSet objectForKey:@"accountNo"];
        NSLog(@"***accountNo:-->%@", strAccountNo);
        
        NSArray *tempArrAcVolumnList = (NSArray*)[barSet objectForKey:@"accountVolumeList"];
        
        int tempCountBar = (int)tempArrAcVolumnList.count;
        if(tempCountBar > countMaxNoOfBarInBarSet)
        {
            countMaxNoOfBarInBarSet = tempCountBar;
        }
        
        for (int j = 0; j<tempArrAcVolumnList.count; j++) {
            NSDictionary *tempDictACVolumn = (NSDictionary*)[tempArrAcVolumnList objectAtIndex:j];
            
            NSString *strCurCode = [tempDictACVolumn objectForKey:@"debitCurrencyCode"];
            NSLog(@"     ***debitCurrencyCode:-->%@", strCurCode);
            
            NSString *strPayMethod = [tempDictACVolumn objectForKey:@"paymentMethodName"];
            NSLog(@"     ***paymentMethodName:-->%@", strPayMethod);
            
            NSString *strCount = [tempDictACVolumn objectForKey:@"totalCount"];
            NSLog(@"     ***totalCount:-->%@", strCount);
            
            
            BOOL identicalStringFound = NO;
            for (NSString *someString in clBarTypeName) {
                if ([someString isEqualToString:strPayMethod]) {
                    identicalStringFound = YES;
                    break;
                }
            }
            
            if(identicalStringFound == NO)
            {
                [clBarTypeName addObject:strPayMethod];
            }
            
            CGFloat tempMaxVal = 0.0;
            @try {
                tempMaxVal = strCount.floatValue;
                if(tempMaxVal > MaxVal)
                {
                    MaxVal = tempMaxVal;
                }
            }
            @catch (NSException *exception) {
                NSLog(exception.description,nil);
                NSLog(@"     ***Conversion Error:-->\"%@\"", strCount);
            }
            @finally {
                
            }
            
        }
        
    }
    
    clMaxBarCountInBarSets = countMaxNoOfBarInBarSet;
    
    clBarSetWidth = (clBarWidth * clMaxBarCountInBarSets) + (clBarSpace * (clMaxBarCountInBarSets + 1));
    
    return MaxVal;
}


-(void)addBarOnBarSet:(UIView*)tempBarSet barSetLabel:(UILabel*)lblBarSet
{
    int intbarCountTag = (int)clArrBarAndLabel.count * 100;
    int barIndex = (int)tempBarSet.tag - 1;
    if(barIndex < clArrMainData.count)
    {
        //ajay
        
        
        NSDictionary *barSet = (NSDictionary*)[clArrMainData objectAtIndex:barIndex];
        NSString *strAccountNo = [barSet objectForKey:@"accountNo"];
        NSLog(@"***accountNo:-->%@", strAccountNo);
        lblBarSet.text = strAccountNo;
        
        NSArray *tempArrAcVolumnList = (NSArray*)[barSet objectForKey:@"accountVolumeList"];
        
        for (int j = 0; j<tempArrAcVolumnList.count; j++) {
            NSDictionary *tempDictACVolumn = (NSDictionary*)[tempArrAcVolumnList objectAtIndex:j];
            
            NSString *strCurCode = [tempDictACVolumn objectForKey:@"debitCurrencyCode"];
            NSLog(@"     ***debitCurrencyCode:-->%@", strCurCode);
            
            NSString *strPayMethod = [tempDictACVolumn objectForKey:@"paymentMethodName"];
            NSLog(@"     ***paymentMethodName:-->%@", strPayMethod);
            
            NSString *strCount = [tempDictACVolumn objectForKey:@"totalCount"];
            NSLog(@"     ***totalCount:-->%@", strCount);
            
            CGFloat tempMaxVal = 0.0;
            @try {
                
                int NoOfBarInBarSet = (int)tempArrAcVolumnList.count;
                
                CGFloat totalPixelWidthForAllBar = (clMaxBarCountInBarSets * clBarWidth) + ((clMaxBarCountInBarSets - NoOfBarInBarSet) * clBarSpace);
                
                CGFloat newBarWidthForCurrentBarSet = totalPixelWidthForAllBar/ NoOfBarInBarSet;
                
                tempMaxVal = strCount.floatValue;
                
                CGFloat barHeight = clPixelValForSingleVale * tempMaxVal;
                
                CGFloat x = ((j+1)*clBarSpace) + (j*newBarWidthForCurrentBarSet);
                
                UIView *bar1 = [[UIView alloc] initWithFrame:CGRectMake(x, tempBarSet.frame.size.height - barHeight, newBarWidthForCurrentBarSet, barHeight)];
                
                //bar1.tag = intbarCountTag; // this code cause error in X axis data on zooming graph
                
                UITapGestureRecognizer *singlTapOnBar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(barSingleTapEvent:)];
                singlTapOnBar.numberOfTapsRequired = 1;
                
                [bar1 addGestureRecognizer:singlTapOnBar];
                
                UIColor *barColor = [self setColorOfBar:bar1 forKey:strPayMethod];
               //bar1.backgroundColor = [UIColor redColor];
                [tempBarSet addSubview:bar1];
                
                UILabel *LblCount = [[UILabel alloc]initWithFrame:CGRectMake(tempBarSet.frame.origin.x +bar1.frame.origin.x, bar1.frame.origin.y - clSpaceBetweenBarAndBarCountLabel, newBarWidthForCurrentBarSet, clBarSetLabelHeight)];
                LblCount.backgroundColor = [UIColor clearColor]; //blueColor
                LblCount.textAlignment = NSTextAlignmentCenter;
                LblCount.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:8];
                LblCount.text = strCount;
                
                [self.scrollView addSubview:LblCount];

                
                NSMutableArray *tempBarAndLabel = [[NSMutableArray alloc] init];
                [tempBarAndLabel addObject:bar1];
                [tempBarAndLabel addObject:LblCount];
                
                NSMutableDictionary *barData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:strAccountNo,@"accountNo", strCurCode, @"debitCurrencyCode", strPayMethod, @"paymentMethodName", strCount, @"totalCount", barColor, @"barColor", nil];
                
                [tempBarAndLabel addObject:barData];
                
                [clArrBarAndLabel addObject:tempBarAndLabel];
                intbarCountTag++;
                
                
                
                
            }
            @catch (NSException *exception) {
                NSLog(exception.description,nil);
                NSLog(@"     ***Conversion Error:-->\"%@\"", strCount);
            }
            @finally {
                
            }
            
        }
            
        
    }
    
    
}


- (void)barSingleTapEvent:(UITapGestureRecognizer*)sender {
    UIView *view = sender.view;

    for (NSArray *arritem in clArrBarAndLabel)
    {
        UIView *bar1 = (UIView *)[arritem objectAtIndex:0]; // 0 for bar object
        if(bar1 == view)
        {
            //        UIView *bar1 = (UIView *)[arritem objectAtIndex:0]; // 0 for bar object
            //        UILabel *bar1Label = (UILabel *)[arritem objectAtIndex:1];  // 1 for barCountLabel object
            NSDictionary *BarData = (NSDictionary*)[arritem objectAtIndex:2];  // 3 for bar Data dictionary
            
            NSLog(@"%@",BarData);
            break;
        }
       
    }
    
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];

    colorArray = [[NSMutableArray alloc]init];
    
    [colorArray addObject:[UIColor colorWithRed:0x14/255.f green:0x49/255.f blue:0x9E/255.f alpha:1.f]]; //Red
    [colorArray addObject:[UIColor colorWithRed:0x47/255.f green:0x8F/255.f blue:0xCC/255.f alpha:1.f]]; // Purple
    [colorArray addObject:[UIColor colorWithRed:0xF3/255.f green:0x6F/255.f blue:0x23/255.f alpha:1.f]]; //Pink
    [colorArray addObject:[UIColor colorWithRed:0xF9/255.f green:0x9F/255.f blue:0x1D/255.f alpha:1.f]];//Light Blue
    [colorArray addObject:[UIColor colorWithRed:0x81/255.f green:0x77/255.f blue:0x2F/255.f alpha:1.f]];//Green
    [colorArray addObject:[UIColor colorWithRed:0xAE/255.f green:0xB4/255.f blue:0x35/255.f alpha:1.f]];//Orange shade
    [colorArray addObject:[UIColor colorWithRed:0x87/255.f green:0x1A/255.f blue:0x50/255.f alpha:1.f]];//Brown
    [colorArray addObject:[UIColor colorWithRed:0xF0/255.f green:0x62/255.f blue:0x90/255.f alpha:1.f]];//Dark Purple
    [colorArray addObject:[UIColor colorWithRed:0x4E/255.f green:0x34/255.f blue:0x2E/255.f alpha:1.f]];//Orange
    [colorArray addObject:[UIColor colorWithRed:0xA0/255.f green:0x88/255.f blue:0x7E/255.f alpha:1.f]];//Green
    [colorArray addObject:[UIColor colorWithRed:0x37/255.f green:0x47/255.f blue:0x4F/255.f alpha:1.f]];//Cyan
    [colorArray addObject:[UIColor colorWithRed:0x78/255.f green:0x8F/255.f blue:0x9B/255.f alpha:1.f]];//Dark Blue
    [colorArray addObject:[UIColor colorWithRed:0x00/255.f green:0x83/255.f blue:0x8F/255.f alpha:1.f]];//Grey
    [colorArray addObject:[UIColor colorWithRed:0x35/255.f green:0xC1/255.f blue:0xD6/255.f alpha:1.f]];//Light Green
    [colorArray addObject:[UIColor colorWithRed:0x60/255.f green:0x7d/255.f blue:0x8b/255.f alpha:1.f]];//Blue Grey
    
    
}


-(void)GraphLoad
{
    clArrBarAndLabel = [[NSMutableArray alloc] init];
    
    clYAxisLegendWidth = 25;
    clGraphLeftPadding = 10;
    
    clGraphWidth = 320.0 - (clYAxisLegendWidth + clGraphLeftPadding) - 10;
    clGraphHeight = 400.0;
    
    
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:YES];
    self.scrollView.frame = CGRectMake(0, 40, clGraphWidth, clGraphHeight);
    
    ScrollViewForHorLegend = [[UIScrollView alloc] initWithFrame:CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.size.height + self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    
    ScrollViewForVerLegend = [[UIScrollView alloc] initWithFrame:CGRectMake(200, self.scrollView.frame.origin.y, clYAxisLegendWidth, self.scrollView.frame.size.height)];
    
    
    
    [self.scrollView.superview addSubview:ScrollViewForHorLegend];
    [self.scrollView.superview addSubview:ScrollViewForVerLegend];
    
    
    //initialize
    [self initializeGraphParameterWithView:self.scrollView.frame barWidth:10 barSpcae:5];
    
    ScrollViewForHorLegend.backgroundColor = [UIColor clearColor];
    ScrollViewForVerLegend.backgroundColor = [UIColor clearColor];
    
    
    self.scrollView.backgroundColor = [UIColor cyanColor];
    
    [ScrollViewForHorLegend setBounces:NO];
    [ScrollViewForHorLegend setBouncesZoom:NO];
    ScrollViewForHorLegend.userInteractionEnabled = NO;
    
    [ScrollViewForVerLegend setBounces:NO];
    [ScrollViewForVerLegend setBouncesZoom:NO];
    ScrollViewForVerLegend.userInteractionEnabled = NO;
    
    
    // Set up the container view to hold your custom view hierarchy
    CGSize containerSize = self.scrollView.frame.size; //CGSizeMake(320.0f, 320.0f);
    // Tell the scroll view the size of the contents
    self.scrollView.contentSize = containerSize;
    ScrollViewForHorLegend.contentSize = self.scrollView.contentSize;
    
    ScrollViewForVerLegend.contentSize = CGSizeMake(ScrollViewForVerLegend.frame.size.width, self.scrollView.contentSize.height);
    
    self.containerView = [[UIView alloc] initWithFrame:(CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=containerSize}];
    [self.scrollView addSubview:self.containerView];
    
    
    
    
    
    //clArrMainData.count
    for (int barSetIndex = 0; barSetIndex<clArrMainData.count; barSetIndex++) {
        
        clViewBarSet1 = [[UIView alloc] initWithFrame:CGRectMake(clBarSpace + (barSetIndex*(clBarSetWidth + clBarSetLeftSpace)), clBarSetTopSpace, clBarSetWidth, clBarSetHeight)];
        clViewBarSet1.backgroundColor = [UIColor clearColor]; //green
        clViewBarSet1.tag = barSetIndex + 1;
        [self.containerView addSubview:clViewBarSet1];
        
        //bottom label of barSet on same scrollview
        //clViewBarSetLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(clViewBarSet1.frame.origin.x, clViewBarSet1.frame.origin.y + clViewBarSet1.frame.size.height - clBarSetLabelHeight, clBarSetWidth, clBarSetLabelHeight)];
        //bottom label of barSet on new scrollview
        clViewBarSetLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(clViewBarSet1.frame.origin.x, 0, clBarSetWidth, clBarSetLabelHeight)];
        clViewBarSetLabel1.backgroundColor = [UIColor clearColor]; //blue
        clViewBarSetLabel1.textAlignment = NSTextAlignmentCenter;
        clViewBarSetLabel1.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
        clViewBarSetLabel1.text = @"labeSet";
        clViewBarSetLabel1.tag = barSetIndex + 1;
        [ScrollViewForHorLegend addSubview:clViewBarSetLabel1];
        
        [self addBarOnBarSet:clViewBarSet1 barSetLabel:clViewBarSetLabel1];
        
        
        
        
    }
    
    
    
    
    self.scrollView.contentSize = CGSizeMake(((clArrMainData.count * clBarSetWidth) + (2 * clBarSpace) + (clArrMainData.count * clBarSetLeftSpace)), self.scrollView.frame.size.height);
    containerSize = self.scrollView.contentSize;
    
    self.containerView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=containerSize};
    ScrollViewForHorLegend.contentSize = self.scrollView.contentSize;
    
    ScrollViewForVerLegend.contentSize = CGSizeMake(ScrollViewForVerLegend.frame.size.width, self.scrollView.contentSize.height);
    
    clOriginalContentViewSize = self.containerView.frame.size;
    
    
    //code for line
    
    int yVal = 1;
    
    clArrYAxisLineAndLabel = [[NSMutableArray alloc] init];
    
    for (float i = self.scrollView.frame.size.height - clPixelValForSingleVale; i >= 0; i=i-clPixelValForSingleVale) {
        
        NSMutableArray * tempArrYAxisLineAndLabel = [[NSMutableArray alloc] init];
        
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, i, clOriginalContentViewSize.width, 1)];
        
        UILabel *YAxisLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, i - (clBarSetLabelHeight/2), ScrollViewForVerLegend.frame.size.width - 2, clBarSetLabelHeight)];
        YAxisLabel.backgroundColor = [UIColor clearColor]; //blue
        YAxisLabel.textAlignment = NSTextAlignmentRight;
        YAxisLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
        YAxisLabel.text = [NSString stringWithFormat:@"%d",yVal];
        
        [ScrollViewForVerLegend addSubview:YAxisLabel];
        
        [line setBackgroundColor:[UIColor clearColor]]; //lightGrayColor
        [self.scrollView addSubview:line];
        
        yVal = yVal + 1;
        
        UIView * lineClone  = [[UILabel alloc] initWithFrame:line.frame];
        
        [tempArrYAxisLineAndLabel addObject:line];
        [tempArrYAxisLineAndLabel addObject:YAxisLabel];
        [tempArrYAxisLineAndLabel addObject:lineClone];

        
        [clArrYAxisLineAndLabel addObject:tempArrYAxisLineAndLabel];
        
    }
    
    
    clYAxisGraphLine = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.frame.origin.x -1, self.scrollView.frame.origin.y, 1, self.scrollView.frame.size.height)];
    
    clXAxisGraphLine = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.frame.origin.x -1, self.scrollView.frame.size.height + 1, self.scrollView.frame.size.width + 1 , 1)];
    
    
    
//    //Hide even Y Axis scale when overlap
//    BOOL doHideAction = YES;
//    while (doHideAction) {
//        
//        doHideAction = NO;
//        for (int YAxisLineIndex = 1; YAxisLineIndex<clArrYAxisLineAndLabel.count; YAxisLineIndex++) {
//            @try {
//                
//                if(YAxisLineIndex % 2 != 0)
//                {
//                    NSArray *YAxisElement = (NSArray *)[clArrYAxisLineAndLabel objectAtIndex:YAxisLineIndex];
//                    UIView *Axisline = (UIView *)[YAxisElement objectAtIndex:0]; // 0 for Line object
//                    UILabel *AxisLabel = (UILabel *)[YAxisElement objectAtIndex:1];  // 1 for AxisLabel object
//                    UIView *AxislineOriginal = (UIView *)[YAxisElement objectAtIndex:2]; // 0 for Line object
//                    
//                    if((YAxisLineIndex - 1)<clArrYAxisLineAndLabel.count && (YAxisLineIndex - 1) >= 0)
//                    {
//                        NSArray *YAxisElementPrevious;
//                        UIView *AxislinePrevious;
//                        UILabel *AxisLabelPrevious;
//                        UIView *AxislineOriginalPrevious;
//                        
//                        
//                        for (int j = YAxisLineIndex - 1; j >= 0; j--) {
//                            YAxisElementPrevious = (NSArray *)[clArrYAxisLineAndLabel objectAtIndex:j];
//                            AxislinePrevious = (UIView *)[YAxisElementPrevious objectAtIndex:0]; // 0 for Line object
//                            if(Axisline.hidden == NO) //is visible
//                            {
//                                AxisLabelPrevious = (UILabel *)[YAxisElementPrevious objectAtIndex:1];  // 1 for AxisLabel object
//                                AxislineOriginalPrevious = (UIView *)[YAxisElementPrevious objectAtIndex:2]; // 0 for Line object
//                                
//                                
//                                if((AxisLabelPrevious.frame.origin.y - (AxisLabel.frame.size.height + AxisLabel.frame.origin.y)) < 0)
//                                {
//                                    Axisline.hidden = YES;
//                                    AxisLabel.hidden = YES;
//                                    AxislineOriginal.hidden = YES;
//                                    
//                                    doHideAction = YES;
//                                }
//                                
//                                break;
//                                
//                            }
//                        }
//                        
//                        
//                    }
//                    
//                    
//                }
//                
//                
//            }
//            @catch (NSException *exception) {
//                NSLog(exception.debugDescription, nil);
//                NSLog(@"YAxis line and YAxis Lebel didZoom", nil);
//            }
//            @finally {
//                
//            }
//        }
//    }
//    
//    
    
    
    
}

#pragma mark - custom method

-(void)setBarSetNewPosWhileZoomForBar:(UIView *) barSet
{
    CGRect newSize = CGRectMake(barSet.frame.origin.x, barSet.superview.frame.size.height - barSet.frame.size.height, barSet.frame.size.width, barSet.frame.size.height);
    
    barSet.frame = newSize;
}

-(void)setBarNewPosWhileZoomForBarSet:(UIView *) barSet forBar:(UIView *) bar withRation:(CGFloat)ration
{
    
//    CGFloat newYPos = ration * ((barSet.frame.size.height - clBarSetLabelHeight) - bar.frame.size.height);
//    
// //   CGFloat newYPos = ration * bar.frame.origin.y;
//   // CGRect newSize = CGRectMake(bar.frame.origin.x, (bar.superview.frame.size.height - clBarSetLabelHeight) - bar.frame.size.height, bar.frame.size.width, bar.frame.size.height);
//    CGRect newSize = CGRectMake(bar.frame.origin.x, newYPos, bar.frame.size.width, bar.frame.size.height);
//    
//    bar.frame = newSize;
}



- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.containerView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.containerView.frame = contentsFrame;
}





- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self GraphLoad];
    
    // Set up the minimum & maximum zoom scales
    
    CGFloat scaleWidth = 1;//scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = 1;//scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 15.0f;
    self.scrollView.zoomScale = 1.0f;
    
    [self centerScrollViewContents];

    
    self.scrollView.frame = CGRectMake(clGraphLeftPadding + clYAxisLegendWidth, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
    ScrollViewForHorLegend.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.size.height + self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    ScrollViewForHorLegend.contentSize = self.scrollView.contentSize;
    ScrollViewForHorLegend.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0);
    
    
    ScrollViewForVerLegend.frame = CGRectMake(clGraphLeftPadding, self.scrollView.frame.origin.y, clYAxisLegendWidth, self.scrollView.frame.size.height);
    ScrollViewForVerLegend.contentSize = CGSizeMake(ScrollViewForVerLegend.frame.size.width, self.scrollView.contentSize.height);
    ScrollViewForVerLegend.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y);

    
    
    clYAxisGraphLine.frame = CGRectMake(self.scrollView.frame.origin.x -1, self.scrollView.frame.origin.y, 1, self.scrollView.frame.size.height );
    
    clXAxisGraphLine.frame = CGRectMake(self.scrollView.frame.origin.x -1, self.scrollView.frame.size.height + self.scrollView.frame.origin.y, self.scrollView.frame.size.width + 1 , 1);
    
    clYAxisGraphLine.backgroundColor = [UIColor lightGrayColor];
    clXAxisGraphLine.backgroundColor = [UIColor lightGrayColor];
    
    [self.scrollView.superview addSubview:clYAxisGraphLine];
    [self.scrollView.superview addSubview:clXAxisGraphLine];
    
    
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    NSLog(@"%@", self.containerView);
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
    
    ScrollViewForHorLegend.contentSize = self.scrollView.contentSize;
    ScrollViewForHorLegend.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0);
    
    ScrollViewForVerLegend.contentSize = CGSizeMake(ScrollViewForVerLegend.frame.size.width, self.scrollView.contentSize.height);
    ScrollViewForVerLegend.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y);
    
    
   // NSLog(@"%f -- %f", clViewBarSet1.frame.origin.x, clViewBarSet1.frame.origin.y);

    @try {
        for (int barSetIndex = 0; barSetIndex<clArrMainData.count; barSetIndex++)
        {
            UIView *barSetFromTag = (UIView *)[self.scrollView viewWithTag:barSetIndex+1];
            UILabel *barSetLabelFromTag = (UILabel *)[ScrollViewForHorLegend viewWithTag:barSetIndex+1];
            
            CGFloat newXPos = (self.containerView.frame.size.width / clOriginalContentViewSize.width) * barSetFromTag.frame.origin.x;
            
            //        CGPoint contentPoint = scrollView.contentOffset;
            //        CGFloat newYPos = contentPoint.y + scrollView.frame.size.height;
            
            CGFloat newWidth = (self.containerView.frame.size.width / clOriginalContentViewSize.width) * barSetFromTag.frame.size.width;
            
            barSetLabelFromTag.frame = CGRectMake(newXPos, 0, newWidth, barSetLabelFromTag.frame.size.height);
        }// end for loop
    }
    @catch (NSException *exception) {
        NSLog(exception.debugDescription, nil);
        NSLog(@"BarSet and Footer Lebel didZoom", nil);
    }
    @finally {
        
    }
    
    
    
    @try {
        
        for (int BarWithBarSetIndex = 0; BarWithBarSetIndex < clArrBarAndLabel.count; BarWithBarSetIndex++) {
            
            NSArray *barSetElement = (NSArray *)[clArrBarAndLabel objectAtIndex:BarWithBarSetIndex];
            UIView *bar1 = (UIView *)[barSetElement objectAtIndex:0]; // 0 for bar object
            UILabel *bar1Label = (UILabel *)[barSetElement objectAtIndex:1];  // 1 for barCountLabel object
            
            CGFloat newXPosL = (self.containerView.frame.size.width / clOriginalContentViewSize.width) * (bar1.frame.origin.x + bar1.superview.frame.origin.x);
     
            CGFloat newYPosL = ((self.containerView.frame.size.height / clOriginalContentViewSize.height) * (bar1.frame.origin.y + bar1.superview.frame.origin.y)) - bar1Label.frame.size.height - clSpaceBetweenBarAndBarCountLabel;
            
            
            CGFloat newWidthL = (self.containerView.frame.size.width / clOriginalContentViewSize.width) * bar1.frame.size.width;
            
            bar1Label.frame = CGRectMake(newXPosL, newYPosL, newWidthL, bar1Label.frame.size.height);            
            
        }// end for loop
    }
    @catch (NSException *exception) {
        NSLog(exception.debugDescription, nil);
        NSLog(@"Bar and bar count Lebel didZoom", nil);
    }
    @finally {
        
    }
    
    
    for (int YAxisLineIndex = 0; YAxisLineIndex<clArrYAxisLineAndLabel.count; YAxisLineIndex++) {
        @try {
            NSArray *YAxisElement = (NSArray *)[clArrYAxisLineAndLabel objectAtIndex:YAxisLineIndex];
            UIView *Axisline = (UIView *)[YAxisElement objectAtIndex:0]; // 0 for Line object
            UILabel *AxisLabel = (UILabel *)[YAxisElement objectAtIndex:1];  // 1 for AxisLabel object
            UIView *AxislineOriginal = (UIView *)[YAxisElement objectAtIndex:2]; // 0 for Line object
            
            CGFloat newYPosYAxisLine = (self.containerView.frame.size.height / clOriginalContentViewSize.height) * AxislineOriginal.frame.origin.y;
            
            Axisline.frame = CGRectMake(Axisline.frame.origin.x, newYPosYAxisLine, Axisline.frame.size.width, Axisline.frame.size.height);
            
            AxisLabel.frame = CGRectMake(AxisLabel.frame.origin.x, newYPosYAxisLine - (AxisLabel.frame.size.height/2), AxisLabel.frame.size.width, AxisLabel.frame.size.height);
        }
        @catch (NSException *exception) {
            NSLog(exception.debugDescription, nil);
            NSLog(@"YAxis line and YAxis Lebel didZoom", nil);
        }
        @finally {
            
        }
    }
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    ScrollViewForHorLegend.contentSize = self.scrollView.contentSize;
    ScrollViewForHorLegend.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0);
    
    ScrollViewForVerLegend.contentSize = CGSizeMake(ScrollViewForVerLegend.frame.size.width, self.scrollView.contentSize.height);
    ScrollViewForVerLegend.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y);
    
    CGPoint contentPoint = scrollView.contentOffset;
    CGFloat newYPos = contentPoint.y + scrollView.frame.size.height;
    //clViewBarSetLabel1.frame = CGRectMake(clViewBarSetLabel1.frame.origin.x, newYPos - clViewBarSetLabel1.frame.size.height, clViewBarSetLabel1.frame.size.width, clViewBarSetLabel1.frame.size.height);
    clViewBarSetLabel1.frame = CGRectMake(clViewBarSetLabel1.frame.origin.x, 0, clViewBarSetLabel1.frame.size.width, clViewBarSetLabel1.frame.size.height);
    
//    for (UIView *subview in clViewBarSet1.subviews)
//    {
//        subview.frame = CGRectMake(subview.frame.origin.x, (clViewBarSet1.frame.size.height - 20) - subview.frame.size.height, subview.frame.size.width, subview.frame.size.height);
//    }
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}






@end

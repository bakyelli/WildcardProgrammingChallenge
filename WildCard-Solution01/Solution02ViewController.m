//
//  Solution02ViewController.m
//  WildCard-Solution01
//
//  Created by Basar Akyelli on 12/6/13.
//  Copyright (c) 2013 Basar Akyelli. All rights reserved.
//

#import "Solution02ViewController.h"

@interface Solution02ViewController ()
- (IBAction)btnSolveTapped:(id)sender;

@end

@implementation Solution02ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)btnSolveTapped:(id)sender {
    
    NSInteger result = [self solve];
    
    NSString *message = [NSString stringWithFormat:@"%d",result];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Found a solution!"
                                                       message:message
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
    [alertView show];
    
}

-(NSInteger)solve
{
    NSArray *generation = @[@9, @10, @21, @20, @7, @11, @4, @15, @7, @7, @14, @5, @20, @6, @29, @8, @11, @19, @18, @22, @29, @14, @27, @17, @6, @22, @12, @18, @18, @30];
    
    NSArray *overhead = @[@21, @16, @19, @26, @26, @7, @1, @8, @17, @14, @15, @25, @20, @3, @24, @5, @28, @9, @2, @14, @9, @25, @15, @13, @15, @9, @6, @20, @27, @22];
    
    NSInteger budget = 2912;
    NSInteger totalCost = 0;
    NSInteger cardCount = [generation count];
    
    for(NSInteger j=1; j<cardCount; j++)
    {
    
        for(NSInteger i=0; i<=j; i++)
        {
            totalCost = totalCost + [self calculateTimeWithGeneration:generation[i] overhead:overhead[i] remainingcardCount:j-i];
            if(totalCost > budget)
            {
                return j-1;
            }
        }
        totalCost = 0;
    }
    
    return cardCount;
    
}
-(NSInteger)calculateTimeWithGeneration:(NSNumber *)g overhead:(NSNumber *)o remainingcardCount:(NSInteger)count
{
    return [g integerValue] + ([o integerValue] * count);
}
@end

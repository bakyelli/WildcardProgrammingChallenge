//
//  ViewController.m
//  WildCard-Solution01
//
//  Created by Basar Akyelli on 12/6/13.
//  Copyright (c) 2013 Basar Akyelli. All rights reserved.
//

#import "Solution01ViewController.h"

@interface Solution01ViewController ()
- (IBAction)solveButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tbProblemOneInputFile;
@property (weak, nonatomic) IBOutlet UITextField *tbNumberOfCards;
@end

@implementation Solution01ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)solveButtonPressed:(id)sender {
    NSArray *inputFileLines = [self inputFile];
    NSInteger result = [self calculateWithInputFileArray:inputFileLines];
    NSString *message = [NSString stringWithFormat:@"%d",result];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Found solution!"
                                                       message:message
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
    
    [alertView show];
    
}

-(NSInteger) calculateWithInputFileArray:(NSArray *)inputFile
{
    NSInteger numberOfCards = [self.tbNumberOfCards.text integerValue];
    NSInteger countOfLinesWithEnoughNumberOfEmptySpaces = 0;
    NSInteger countOfColumnsWithEnoughNumberOfEmptySpaces = 0;
    NSInteger numberOfCombinationsForNumberOfCards = [self factorialRecursive:numberOfCards];
    NSInteger numberOfPossibilities = 0;
    
    NSMutableArray *instancesOfMoreThanEnoughEmptySpaces = [NSMutableArray new];
    
    //calculating rows
    for(NSString *line in inputFile)
    {
        if(![line isEqualToString:@""])
        {
            NSInteger countOfEmptySpacesInLine = 0;
            for(NSInteger i=0; i<[line length]; i++)
            {
                if([line characterAtIndex:i] == '*')
                {
                    countOfEmptySpacesInLine++;
                }
            }
            if(countOfEmptySpacesInLine >= numberOfCards)
            {
                countOfLinesWithEnoughNumberOfEmptySpaces++;
                if(countOfEmptySpacesInLine > numberOfCards)
                {
                    [instancesOfMoreThanEnoughEmptySpaces addObject:[NSNumber numberWithInteger:countOfEmptySpacesInLine]];
                }
            }
        }
    }
    
    numberOfPossibilities = countOfLinesWithEnoughNumberOfEmptySpaces * numberOfCombinationsForNumberOfCards;
    
    //calculating columns
    NSInteger numberOfColumns = [(NSString *)inputFile[0] length];
    for(NSInteger i=0; i<numberOfColumns; i++)
    {
        NSInteger countOfEmptySpacesInColumn = [self getNumberOfEmptySpacesForColumn:i ForInputFileArray:inputFile];
        if(countOfEmptySpacesInColumn >= numberOfCards)
        {
            countOfColumnsWithEnoughNumberOfEmptySpaces++;
            
            if(countOfEmptySpacesInColumn > numberOfCards)
            {
                [instancesOfMoreThanEnoughEmptySpaces addObject:[NSNumber numberWithInteger:countOfEmptySpacesInColumn]];
            }
            
        }
    }
    
    numberOfPossibilities = numberOfPossibilities + (countOfColumnsWithEnoughNumberOfEmptySpaces * numberOfCombinationsForNumberOfCards);
    
    for(NSNumber *numberOfEmptySpaces in instancesOfMoreThanEnoughEmptySpaces)
    {
        numberOfPossibilities = numberOfPossibilities + [self calculatePermutationForInteger:numberOfEmptySpaces withCardNumber:numberOfCards combinationCountForCardNumber:numberOfCombinationsForNumberOfCards];
    
    }
    
    return numberOfPossibilities;
}

-(NSInteger)calculatePermutationForInteger:(NSNumber *)number withCardNumber:(NSInteger)cardNumber combinationCountForCardNumber:(NSInteger)combinationCount;
{
    NSInteger factorialOne = [self factorialRecursive:[number integerValue]];
    NSInteger factorialTwo = [self factorialRecursive:[number integerValue]-cardNumber];
    NSInteger factorialThree = [self factorialRecursive:cardNumber];
    
    NSInteger result = (factorialOne / (factorialTwo * factorialThree)) *combinationCount;
    
    return result-combinationCount;
    
}

-(NSInteger)getNumberOfEmptySpacesForColumn:(NSInteger)columnNumber ForInputFileArray:(NSArray *)array
{
    NSInteger count = 0;
    for(NSString *line in array)
    {
        if(![line isEqualToString:@""])
        {
            if([line characterAtIndex:columnNumber] == '*')
            {
                count++;
            }
        }
    }
    
    return count;
    
}
-(NSArray *)inputFile
{
    NSURL *targetURL = [NSURL URLWithString:self.tbProblemOneInputFile.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSArray* allLinedStrings = [dataString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    return allLinedStrings;
}

-(NSInteger)factorialRecursive:(NSInteger)operand
{
    if( operand == 1 || operand == 0) {
        return(1);
    } else if( operand < 0 ) {
        return(-1);
    }
    
    return( operand * [self factorialRecursive:operand-1] );
}

@end

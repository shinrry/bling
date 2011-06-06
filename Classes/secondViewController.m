#import "secondViewController.h"
#import "nstimer.h"
#import "generateQuestion.h"

@implementation secondViewController

@synthesize num1, num2, answer, symbol, question, total, correct;
@synthesize option0, option1, option2, option3;
@synthesize mytimer;
@synthesize answer1,answer2,answer3,answer4;
@synthesize lastAnimation;
@synthesize finshView;

#define speed 2.5
#define TOTAL_QUESTION 5

- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle onPage:(int)button_id
{
    self = [super initWithNibName:nibName bundle:nibBundle];
    if(self == nil)
    {
        return nil;
    }
    selectQuestionSender = button_id;

    NSLog(@"entering second view");
    return self;
}

- (void)play
{
    if (total < TOTAL_QUESTION) {
        [self revealButtonsInLeft];
        [self revealQuestionAndAnswer];
        if (total) {
            [mytimer resume];
        }
        else {
            mytimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(buttonMove) userInfo:nil repeats:YES];
            NSLog(@"selector set");
        }
		total++;
    }
    else {
        [self gameover];
    }
}

-(IBAction)answer1Pressed:(UIButton*)answerButton1{
    [mytimer pause];
    NSString *ans = [[NSString alloc]initWithFormat:@"%d",answer];
    if([answerButton1.titleLabel.text isEqualToString: ans] ) {
        NSLog(@"correct");
        correct++;
    }
    [ans release];
    NSLog(@"you've made an answer, total: %d; correct: %d", total, correct);
    [self play];
}

- (void)timeout
{
    NSLog(@"time out! total: %d; correct: %d", total, correct);
    [mytimer pause];
    [self play];
}

-(void)gameover
{
    double percent;

    answer1.userInteractionEnabled=NO;
    answer2.userInteractionEnabled=NO;
    answer3.userInteractionEnabled=NO;
    answer4.userInteractionEnabled=NO;
    [gameTime invalidate];

    CGRect lastViewFrame=CGRectMake(20, 20, 280, 179);
    finshView = [[UIView alloc] initWithFrame:lastViewFrame];
    finshView.backgroundColor=[UIColor blackColor];
    finshView.alpha = 0.2;	
    
    percent = ((double)correct) / total;
    NSString *questionText;
    if (percent >= 0.99) {
        questionText = [[NSString alloc]initWithFormat:@"perfect"];
    }
    else if (percent >= 0.5) {
        questionText = [[NSString alloc]initWithFormat:@"well done"];
    }
    else if (percent >= 0.5) {
        questionText = [[NSString alloc]initWithFormat:@"good"];
    }
    else if (percent >= 0.2) {
        questionText = [[NSString alloc]initWithFormat:@"bad"];
    }
    else {
        questionText = [[NSString alloc]initWithFormat:@"are you deliberate?"];
    }
    question.text = questionText;
    [questionText release];
    
    UIButton* retryButton = [[UIButton alloc] initWithFrame:CGRectMake(60,142, 72, 37)];
    UIButton* returnButton = [[UIButton alloc] initWithFrame:CGRectMake(174,142, 72, 37)];
    [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [retryButton setBackgroundImage:nil forState:UIControlStateNormal];
    [retryButton addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchDown]; 
    [returnButton setBackgroundImage:nil forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnToMainMenu) forControlEvents:UIControlEventTouchDown];
    [retryButton setBackgroundColor:[UIColor purpleColor]];
    [returnButton setBackgroundColor:[UIColor greenColor]];
    [finshView addSubview:retryButton];
    [finshView addSubview:returnButton];
    [retryButton setTitle:@"retry" forState:UIControlStateNormal];
    [returnButton setTitle:@"return" forState:UIControlStateNormal];
    [retryButton release];
    [returnButton release];
    [self flicker];
    [self.view addSubview:finshView];
    [self flicker];
}

-(void)retry{
    [finshView removeFromSuperview];
    [self viewDidLoad];
}

-(void)returnToMainMenu{
    [self.view removeFromSuperview];
}

-(void)flicker{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 2.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.endProgress = 1;
    animation.removedOnCompletion = NO;
    animation.type = @"rippleEffect";
    [self.view.layer addAnimation:animation forKey:@"animation"];
    self.lastAnimation = animation;

    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];//Just remove, not release or dealloc
}

-(void)revealQuestionAndAnswer {    
    int options_c[4];
	
    generateQuestion(selectQuestionSender, &num1, &num2, &symbol, options_c, &answer);
    option0 = options_c[0];
    option1 = options_c[1];
    option2 = options_c[2];
    option3 = options_c[3];
    
    NSString *ans1 = [[NSString alloc]initWithFormat:@"%d",option0];
    NSString *ans2 = [[NSString alloc]initWithFormat:@"%d",option1];
    NSString *ans3 = [[NSString alloc]initWithFormat:@"%d",option2];
    NSString *ans4 = [[NSString alloc]initWithFormat:@"%d",option3];

    [answer1 setTitle:ans1 forState:NO];
    [answer2 setTitle:ans2 forState:NO];
    [answer3 setTitle:ans3 forState:NO];
    [answer4 setTitle:ans4 forState:NO];

    [ans1 release];
    [ans2 release];
    [ans3 release];
    [ans4 release];
    
    NSString *questionText;
    if ('/' == symbol) {
        questionText = [[NSString alloc]initWithFormat:@"%d ÷ %d", num1, num2];
    }
    else {
        questionText = [[NSString alloc]initWithFormat:@"%d %c %d", num1, symbol, num2];
    }
    question.text = questionText;
    [questionText release];	
}

-(void)buttonMove {
    if (answer2.frame.origin.x<392) {
        answer2.frame = CGRectMake(answer2.frame.origin.x+speed, answer2.frame.origin.y, answer2.frame.size.width, answer2.frame.size.height);
        answer1.frame = CGRectMake(answer1.frame.origin.x+speed, answer1.frame.origin.y, answer1.frame.size.width, answer1.frame.size.height);
        answer3.frame = CGRectMake(answer3.frame.origin.x+speed, answer3.frame.origin.y, answer3.frame.size.width, answer3.frame.size.height);
        answer4.frame = CGRectMake(answer4.frame.origin.x+speed, answer4.frame.origin.y, answer4.frame.size.width, answer4.frame.size.height);
    }
    else {
        [self timeout];
    }
}

-(void) revealButtonsInLeft
{
    answer1.frame = CGRectMake(0, answer1.frame.origin.y, answer1.frame.size.width, answer1.frame.size.height);			
    answer2.frame = CGRectMake(0, answer2.frame.origin.y, answer2.frame.size.width, answer2.frame.size.height);
    answer3.frame = CGRectMake(0, answer3.frame.origin.y, answer3.frame.size.width, answer3.frame.size.height);
    answer4.frame = CGRectMake(0, answer4.frame.origin.y, answer4.frame.size.width, answer4.frame.size.height);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    total = 0;
    correct = 0;
    answer1.userInteractionEnabled=YES;
    answer2.userInteractionEnabled=YES;
    answer3.userInteractionEnabled=YES;
    answer4.userInteractionEnabled=YES;
    [self play];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [finshView release];
    [question release];
    [answer1 release];
    [answer2 release];
    [answer3 release];
    [answer4 release];
    [mytimer release];
    [super dealloc];
}

@end

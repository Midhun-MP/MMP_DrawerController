MMP_DrawerController
====================

It's an iOS re-usable component. You can use it for adding drawer like navigation control in your application.

![demo](/Images/demo.gif)

##Usage

####Step 1

Inherit your BaseViewController class from `MMPHomeViewController`. Add three classes for Left, Center and Right viewcontrollers.

####Step 2

Your BaseViewController class and CenterViewController class should conform to `MMPMainViewDelegate`.
Create a property in your CenterViewController:

```
@property (nonatomic, assign) id<MMPMainViewDelegate> delegate;
```

####Step 3

Implement BaseViewController class like:

```
@implementation ViewController
{
    CenterViewController *center;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    center = [[CenterViewController alloc] initWithNibName:@"Center" bundle:nil];
    center.delegate  = self;
    [self setMainVC:center];
    [self setRightVC:[[UIViewController alloc] initWithNibName:@"Right" bundle:nil]];
    [self setLeftVC:[[UIViewController alloc] initWithNibName:@"Left" bundle:nil]];
    [self setupDrawers];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.rightButton = center.rightButton;
    self.leftButton  = center.leftButton;
}

- (void)moveRight
{
    [super moveRight];
}

- (void)moveLeft
{
    [super moveLeft];
}

- (void)resetMove
{
    [super resetMove];
}

@end
```

####Step 4

In your CenterViewController add two outlets for right and left view. Connect them in interface builder and set the tag to 1.

Set the `IBAction` of `rightButton` as:

```
- (IBAction)moveLeft:(id)sender
{
    UIButton *button = sender;
    switch (button.tag) {
        case 0:
        {
            [_delegate resetMove];
            break;
        }
            
        case 1:
        {
            [_delegate moveLeft];
            break;
        }
            
        default:
            break;
    }
}
```

For `leftButton` as:

```
- (IBAction)moveRight:(id)sender
{
    UIButton *button = sender;
    switch (button.tag) {
        case 0:
        {
            [_delegate resetMove];
            break;
        }
            
        case 1:
        {
            [_delegate moveRight];
            break;
        }
            
        default:
            break;
    }
}
```

Credits
-------
Midhun M P

Email : midhunmp7@gmail.com
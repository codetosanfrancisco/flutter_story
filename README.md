# flutter_social_login

A new Flutter project.

## How this App works?

Basically how it works is that:
1. There is 1 stack widget that stacks one stack widget and a PageView Widget
2. PageView Widget return Empty Container Widget used to detect currentPage upon scrolling
3. The other Stack Widget contains an array of images(which is this case is also a Stack Widget to stack together with other widget such as Text Widget) as child and will change its position according to the scrolling of PageView


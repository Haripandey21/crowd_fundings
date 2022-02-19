Here, there will be a manager who can set up multiple requests for crowdfunding by declaring the target(balance) and the deadline for that request. 
Contributors can send their funds in the smart contract but must be greater than the minimum contribution amount.
If the (block.timestamp>deadline && raisedAmount<target)then the user can refund their balance only if they are contributors.(so that no one other than contributors can withdraw the funds).then their blc will be set to Zero. 

Only the Manager can create requests where he needs to input “the description of request”, “address ”(where the contributors are going to transfer funds), and the “target value”(amount ).then, contributors can vote the request from the Request list. They can vote only once. And payment for the requests can be done only if 1. (raisedAmount>=target) 2. there must be more than 50% votes for a request. 

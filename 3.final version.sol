

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

// get ready  



contract CrowdFund 
{
    mapping(address=>uint) public contributors;
    address public manager;
    uint public mincontribution;
    uint public deadline;
    uint public target;
    uint public raisedamount;
    uint public noofcontributors;

    struct Request{
        
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping(address=>bool) voters;
    }
    mapping(uint=>Request) public requests;
    uint public numRequests;


constructor(uint _target,uint _deadline)
{
    target=_target;
    deadline=block.timestamp+_deadline;
    manager=msg.sender;
    mincontribution=50 wei;
}
function sendeth() public payable 
{
require(block.timestamp<deadline,"deadline crosssed !!!!!!");
require(msg.value>=mincontribution,"must be greater than minimum contribution");

if(contributors[msg.sender]==0)
{
    noofcontributors++;
}
contributors[msg.sender]+=msg.value;      // 0+50  
raisedamount+=msg.value;                  // 0+50
}

function getblc() public view returns(uint)
{
return address(this).balance;
}
 function refund() public{
        require(block.timestamp>deadline && raisedamount<target,"You are not eligible for refund");
        require(contributors[msg.sender]>0);
        address payable user=payable(msg.sender);
        user.transfer(contributors[msg.sender]);
        contributors[msg.sender]=0;

}
modifier onlyManager(){
        require(msg.sender==manager,"Only manager can call this function");
        _;
    }
    function createRequests(string memory _description,address payable _recipient,uint _value) public onlyManager{
        Request storage newRequest = requests[numRequests];
        numRequests++;
        newRequest.description=_description;
        newRequest.recipient=_recipient;
        newRequest.value=_value;
        newRequest.completed=false;
        newRequest.noOfVoters=0;
    }
      function voteRequest(uint _requestNo) public{
        require(contributors[msg.sender]>0,"YOu must be contributor");
        Request storage thisRequest=requests[_requestNo];
        require(thisRequest.voters[msg.sender]==false,"You have already voted");
        thisRequest.voters[msg.sender]=true;
        thisRequest.noOfVoters++;
    }


       function makePayment(uint _requestNo) public onlyManager{
        require(raisedamount>=target);
        Request storage thisRequest=requests[_requestNo];
        require(thisRequest.completed==false,"The request has been completed");
        require(thisRequest.noOfVoters > noofcontributors/2,"Majority does not support");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed=true;
    }


}
 



 



// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;


contract PayPal{

// define the owner of the smart contract

address public owner;

// this runs only once when the contract is deployed. which means the owner is the person who deployed the contract. and this runs only once
constructor(){
    owner = msg.sender;
}

// create a struct  and mapping for request, transaction and name

struct request{
    address requester;
    uint256 amount;
    string message;
    string name;
}

// this is transaction struct. action can be send or receive.
struct sendReceive {
    string action; // send or receive
    uint256 amount;
    string message;
    address otherPartyAddress;
    string otherPartyName;
}

// this will be used to store the names of the users and map it to their wallet address.
struct username {
    bool hasName;
    string name;
}

//Syntax: mapping(keyType => valueType) public variableName;

mapping (address => username)  names;
mapping (address => request[]) requests;
mapping (address => sendReceive[]) history;

// add a name to a wallet address

function addName(string memory _name) public {

    username storage newUser = names[msg.sender];
    newUser.name = _name;
    newUser.hasName = true;

}
// creating a request to ask for money

function createRequest(address _requestReceiver, uint256 _amount, string memory _message) public {
    request memory newRequest;
    newRequest.requester = msg.sender;
    newRequest.amount = _amount;
    newRequest.message = _message;

    if(names[msg.sender].hasName){
        newRequest.name = names[msg.sender].name;
    }

    requests[_requestReceiver].push(newRequest);
}

//  pay for a request

function payRequest (uint256 _requestIndex) public payable {
    
    require(requests[msg.sender].length > _requestIndex, "Request does not exist");

    request storage requestToPay = requests[msg.sender][_requestIndex];

// convert the amount to wei. amount is in ETH(Matic) and we need to convert it to wei
    uint256 amountToPay = requestToPay.amount * 1000000000000000000;
    require(msg.value == (amountToPay), "Amount sent is not matching the request amount");

    payable(requestToPay.requester).transfer(msg.value);


    // add to the history of the sender
    addHistory(msg.sender, requestToPay.requester, requestToPay.amount, requestToPay.message, "send");

    // add to the history of the receiver
    addHistory(requestToPay.requester, msg.sender, requestToPay.amount, requestToPay.message, "receive");

    request[] storage allRequests = requests[msg.sender];
    //moving the last element into the position of the element to be removed.
    allRequests[_requestIndex] = allRequests[allRequests.length - 1];
    allRequests.pop();

}

// add request to the user history

function addHistory (address primaryUser, address secondaryUser, uint256 _amount, string memory _message, string memory _action ) private {

sendReceive memory newTransaction;
newTransaction.action = _action;
newTransaction.amount = _amount;
newTransaction.message = _message;
newTransaction.otherPartyAddress = secondaryUser;

if(names[secondaryUser].hasName){
    newTransaction.otherPartyName = names[secondaryUser].name;
}

history[primaryUser].push(newTransaction);

}

// get all requests sent to a user
function getAllRequests (address _user) public view returns(address[] memory, uint256[] memory, string[] memory, string[] memory) {
    address[] memory requesters = new address[](requests[_user].length);
    uint256[] memory amounts = new uint256[](requests[_user].length);
    string[] memory messages = new string[](requests[_user].length);
    string[] memory namesOfRequesters = new string[](requests[_user].length);

    for(uint256 i = 0; i < requests[_user].length; i++){
        request storage currentRequest = requests[_user][i];
        requesters[i] = currentRequest.requester;
        amounts[i] = currentRequest.amount;
        messages[i] = currentRequest.message;
        namesOfRequesters[i] = currentRequest.name;
    }

    return(requesters, amounts, messages, namesOfRequesters);
}

// get all transactions user has been involved in

function getHistory (address _user) public view returns(sendReceive[] memory) {
    return history[_user];

}

function getUserName (address _user) public view returns(username memory) {
    return names[_user];
}

}
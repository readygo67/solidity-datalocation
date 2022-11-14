/ SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;


/*
  experiments @https://docs.soliditylang.org/en/v0.8.17/types.html#data-location-and-assignment-behaviour
    
                          |  memory  | local storage | storage |  
                  memory  |  copy    |doesn't support|  copy   |
            local storage |  copy    | reference     |  copy   |
                  storage |  copy    | reference     |  copy   |

*/


contract DataLocation {
    // The data location of x is storage.
    // This is the only place where the
    // data location can be omitted.
    uint[] public x;
    uint[] public x1;
    uint[] public x2;


    constructor() {
        x = [uint(1),2,3];
    } 

// assign memory array to memory/localstorage/storage.
    /*
    input:
{
	"uint256[] memoryArray": [
		"4",
		"5",
		"6",
		"7",
		"8"
	],
	"uint256[] memoryArray1": [
		"10",
		"11",
		"12"
	]
}

output:
{
	"0": "uint256[]: 4,5,6,7",
	"1": "uint256[]: 4,5,6,7",
	"2": "uint256[]: 10,11,12",
	"3": "uint256[]: 4,5,6,7,8",
	"4": "uint256[]: 10,11,12",
	"5": "uint256[]: 10,11,12"
}
    */
    function meoryAssignment(uint[] memory memoryArray, uint[] memory memoryArray1) public returns (uint[] memory, uint[] memory, uint[] memory, uint[]memory, uint[] memory, uint[] memory){
        uint[] storage y;
        uint[] memory z;
        uint[] memory z1; 

        x = memoryArray; // memory -> storage, copies the whole array to storage
        // y = memoryArray; // memory -> local storage, doesn't work
        y = x;   //storage -> local storage, reference
        z = memoryArray; // memory -> memory, copy 
        z1 = z; //memory ->memory, copy 

        x.pop();
        memoryArray = memoryArray1;
        z = memoryArray1;
        return (x, y, z, z1, memoryArray, memoryArray1);
    }

// assign localstorage array to memory/localstorage/storage.
    /*
    input:
{
	"uint256[] memoryArray": [
		"4",
		"5",
		"6",
		"7",
		"8",
		"9"
	]
}

output:
{
	"0": "uint256[]: 4,5,6,7,8",
	"1": "uint256[]: 4,5,6,7,8",
	"2": "uint256[]: 4,5,6,7,8",
	"3": "uint256[]: 4,5,6,7,8,9",
	"4": "uint256[]: 4,5,6,7,8,9"
}
    */
    function localStorageAssignment(uint[] memory memoryArray) public returns (uint[] memory, uint[] memory, uint[] memory, uint[]memory, uint[] memory){
        uint[] storage y;
        uint[] storage y1;
        uint[] memory z;

        x = memoryArray; //memory -> storage, copy
        y = x;  //storage -> local storage, reference

        y1 = y; //local storage -> local store,  reference
        z = y; // local storage -> memory, copy 
        x = y; //local storage -> storage, copy

        y.pop();
        return (x, y, y1, z, memoryArray);
    }

    // function f4(uint[] memory memoryArray, uint[] memory memoryArray1) public returns (uint[] memory, uint[] memory, uint[] memory, uint[]memory, uint[] memory, uint[] memory, uint[] memory, uint[] memory, uint[]memory, uint[] memory){
    //     uint[] storage y;
    //     uint[] storage y1;
    //     uint[] storage y2;

    //     uint[] memory z;
    //     uint[] memory z1;
    //     uint[] memory z2;

    //     x = memoryArray; // memory -> storage, copies the whole array to storage
    //     // y = memoryArray; // memory -> local storage, doesn't work
    //     y = x;
    //     z = memoryArray; // memory -> memory, reference 
 
    //     x1 = x; //storage -> storage, copy
    //     y1 =  x1; //storage -> local storage,reference
    //     z1 = x1; //storage -> memory, 
     
    //     x2 = y1; //local storage -> storage 
    //     y2 = y1; //local storage -> local storage 
    //     z2 = y1; //local storage -> memory
        
    //     x1.pop();
    //     y1.pop();

    //     memoryArray = memoryArray1;
    //     return (x, x1, x2, y, y1, y2, z, z1, z2, memoryArray);
    // }

// assign storage array to memory/localstorage/storage.
    /*
    input:
{
	"uint256[] memoryArray": [
		"4",
		"5",
		"6",
		"7",
		"8",
		"9"
	]
}

output:
{
	"0": "uint256[]: 4,5,6,7,8",
	"1": "uint256[]: 4,5,6,7,8,9",
	"2": "uint256[]: 4,5,6,7,8",
	"3": "uint256[]: 4,5,6,7,8,9",
	"4": "uint256[]: 4,5,6,7,8,9"
}
    */
    function globalStorageAssignment(uint[] memory memoryArray) public returns (uint[] memory, uint[] memory, uint[] memory, uint[]memory, uint[] memory){
        uint[] storage y;
        uint[] memory z;

        x = memoryArray; //memory -> storage, copy
        x1 = x; //storage -> storage, copy
        y = x;  //storage -> local storage, reference
        z = x; //storage -> memory, copy

        x.pop();
        return (x, x1, y, z, memoryArray);
    }
}

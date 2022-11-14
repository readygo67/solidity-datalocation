# solidity-datalocation

in https://docs.soliditylang.org/en/v0.8.17/types.html#data-location-and-assignment-behaviour

Data location and assignment behaviour
Data locations are not only relevant for persistency of data, but also for the semantics of assignments:
Assignments between storage and memory (or from calldata) always create an independent copy.
Assignments from memory to memory only create references. This means that changes to one memory variable are also visible in all other memory variables that refer to the same data.
Assignments from storage to a local storage variable also only assign a reference.
All other assignments to storage always copy. Examples for this case are assignments to state variables or to members of local variables of storage struct type, even if the local variable itself is just a reference.

This repo test above statements, the result is 

                             |  memory  | local storage | storage |  
                  memory  -> |  copy    |doesn't support|  copy   |
            local storage -> |  copy    | reference     |  copy   |
                  storage -> |  copy    | reference     |  copy   |

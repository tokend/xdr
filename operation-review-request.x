

%#include "xdr/ledger-entries.h"
%#include "xdr/operation-payment.h"

namespace stellar
{
//: Actions that can be performed on request that is being reviewed
enum ReviewRequestOpAction {
    //: Approve request
    APPROVE = 1,
    //: Reject request
    REJECT = 2,
    //: Permanently reject request
    PERMANENT_REJECT = 3
};

/* ReviewRequestOp

        Approves or rejects reviewable request

        Threshold: high

        Result: ReviewRequestResult
*/

//: Review Request operation
struct ReviewRequestOp
{
    //: ID of a request that is being reviewed
    uint64 requestID;
    //: Hash of a request that is being reviewed
    Hash requestHash;

    //: Review action defines an action performed on the pending ReviewableRequest
    ReviewRequestOpAction action;
    //: Contains reject reason
    longstring reason;

    //: Tasks to add to pending
    uint64 tasksToAdd;
    //: Tasks to remove from pending
    uint64 tasksToRemove;
    //: Details of the current review
    longstring externalDetails;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ReviewRequest Result ********/
//: Result code of the ReviewRequest operation
enum ReviewRequestResultCode
{
    //: Codes considered as "success" for an operation
    //: Operation is applied successfuly 
    SUCCESS = 0,

    //: Codes considered as "failure" for an operation
    //: Reject reason must be empty on approve and not empty on reject/permanent 
    INVALID_REASON = -1,
    //: Unknown action to perform on ReviewableRequest
    INVALID_ACTION = -2,
    //: Actual hash of the request and provided hash are mismatched
    HASH_MISMATCHED = -3,
    //: ReviewableRequest is not found
    NOT_FOUND = -4,
    //: Actual type of a reviewable request and provided type are mismatched
    TYPE_MISMATCHED = -5,
    //: Reject is not allowed. Only permanent reject should be used
    REJECT_NOT_ALLOWED = -6,
    //: External details must be a valid JSON
    INVALID_EXTERNAL_DETAILS = -7,
    //: Source of ReviewableRequest is blocked
    REQUESTOR_IS_BLOCKED = -8,
    //: Permanent reject is not allowed. Only reject should be used
    PERMANENT_REJECT_NOT_ALLOWED = -9,
    //: Trying to remove tasks which are not set
    REMOVING_NOT_SET_TASKS = -10,// cannot remove tasks which are not set
    //: CheckValid or Confirm of operation is failed
    INVALID_OPERATION = -11
};

//: Extended result of a Review Request operation containing details specific to certain request types
struct ExtendedResult {
    //: Indicates whether or not the request that is being reviewed was applied
    bool fulfilled;

    OperationResult operationResults<>;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of applying the review request with result code
union ReviewRequestResult switch (ReviewRequestResultCode code)
{
case SUCCESS:
    ExtendedResult success;
case INVALID_OPERATION:
    OperationResult operationResult;
default:
    void;
};

}




%#include "xdr/ledger-entries.h"

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

//: Details of a request review
struct ReviewDetails {
    //: Tasks to add to pending
    uint32 tasksToAdd;
    //: Tasks to remove from pending
    uint32 tasksToRemove;
    //: Details of the current review
    string externalDetails<>;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Extended result of a Review Request operation containing details specific to certain request types
struct ExtendedResult {
    //: Indicates whether or not the request that is being reviewed was applied
    bool fulfilled;
    //: typeExt is used to pass ReviewableRequestType along with details specific to a request type
    union switch(ReviewableRequestType requestType) 
    {
    default:
        void;
    } typeExt;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Review Request operation
struct ReviewRequestOp
{
    //: ID of a request that is being reviewed
    uint64 requestID;
    //: Hash of a request that is being reviewed
    Hash requestHash;
    //: requestDetails is used to pass request type along with details specific to it.
    union switch(ReviewableRequestType requestType) 
    {
    default:
        void;
    } requestDetails;
    //: Review action defines an action performed on the pending ReviewableRequest
    ReviewRequestOpAction action;
    //: Contains reject reason
    longstring reason;
    //: Details of the ReviewRequest operation
    ReviewDetails reviewDetails;

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
    REMOVING_NOT_SET_TASKS = -100,// cannot remove tasks which are not set

    //: Change role 
    //: Trying to remove zero tasks
    NON_ZERO_TASKS_TO_REMOVE_NOT_ALLOWED = -600,
    //: There is no account role with provided id
    ACCOUNT_ROLE_TO_SET_DOES_NOT_EXIST = -610,

    //KYC
    //:Signer data is invalid - either weight is wrong or details are invalid
    INVALID_SIGNER_DATA = -1600

};
//: Result of applying the review request with result code
union ReviewRequestResult switch (ReviewRequestResultCode code)
{
case SUCCESS:
    ExtendedResult success;
default:
    void;
};

}


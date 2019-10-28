

%#include "xdr/ledger-entries.h"


namespace stellar
{

/* CreateManageLimitsRequestOp

    Create manage limits request

    Threshold: med or high

    Result: CreateManageLimitsRequestResult
*/

//: CreateManageLimitsRequestOp is used to create a reviewable request which, after approval, will update the limits set in the system
struct CreateManageLimitsRequestOp
{
    //: Body of the `UpdateLimits` reviewable request to be created
    LimitsUpdateRequest manageLimitsRequest;

    //: (optional) Bit mask whose flags must be cleared in order for ManageLimits request to be approved, which will be used instead of value from the key-value pair 
    //: by key `limits_update_tasks`
    uint32* allTasks;
    //: ID of the LimitsUpdateRequest
    //: If `requestID == 0`, operation creates a new limits entry; otherwise, it updates the existing one
    uint64 requestID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

/******* CreateManageLimits Result ********/

//: Result codes for CreateManageLimitsRequest operation
enum CreateManageLimitsRequestResultCode
{
    // codes considered as "success" for the operation
    //: Operation was successfully applied and ManageLimitsRequest was successfully created
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is another manage limits request for the source account
    MANAGE_LIMITS_REQUEST_REFERENCE_DUPLICATION = -1,
    //: There is no request with such ID
    MANAGE_LIMITS_REQUEST_NOT_FOUND = -2,
    //: Details must be in a valid JSON format
    INVALID_CREATOR_DETAILS = -3,
    //: Tasks are not set in the system (i.e., it is not allowed to perform the limits update request)
    LIMITS_UPDATE_TASKS_NOT_FOUND = -5,
    //: Cannot set allTasks on the rejected request update
    NOT_ALLOWED_TO_SET_TASKS_ON_UPDATE = -6,
    //: 0 value is either not allowed for `allTasks` or for the value entry received by key `limits_update_tasks`
    LIMITS_UPDATE_ZERO_TASKS_NOT_ALLOWED = -7
};

//: `CreateManageLimitsRequestResult` represents the result of the `CreateManageLimitsRequestOp` with corresponding details based on given `CreateManageLimitsRequestResultCode`
union CreateManageLimitsRequestResult switch (CreateManageLimitsRequestResultCode code)
{
case SUCCESS:
    struct {
        //: ID of the created manage limits request
        uint64 manageLimitsRequestID;
        //: Indicates whether or not the `limits update request` request was auto approved and fulfilled
        bool fulfilled;
        //: reserved for future use
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } success;
default:
    void;
};

}

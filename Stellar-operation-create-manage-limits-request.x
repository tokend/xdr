

%#include "xdr/Stellar-ledger-entries.h"


namespace stellar
{

/* CreateManageLimitsRequestOp

    Create manage limits request

    Threshold: med or high

    Result: CreateManageLimitsRequestResult
*/

//: CreateManageLimitsOp is used to create a reviewable request which, after approval, will update the limits set in the system
struct CreateManageLimitsRequestOp
{
    //: Body of the UpdateLimits reviewable request to be created
    LimitsUpdateRequest manageLimitsRequest;

    //: (optional) Bit mask whose flags must be cleared in order for ManageLimits request to be approved, which will be used by key `limits_update_tasks`
    //: instead of value from the key-value pair
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
    //: Details must be valid json
    INVALID_CREATOR_DETAILS = -3,
    //: Either tasks for the CreateManageLimitsRequest cannot be loaded or configuration restricts creating the manage limits request
    LIMITS_UPDATE_TASKS_NOT_FOUND = -5,
    //: Cannot set allTasks on the rejected request update
    NOT_ALLOWED_TO_SET_TASKS_ON_UPDATE = -6,
    //: 0 value is either not allowed for `allTasks` or for the value entry received by key limits_update_tasks:<asset_code>
    LIMITS_UPDATE_ZERO_TASKS_NOT_ALLOWED = -7
};

//: `CreateManageLimitsRequestResult` represents the result of the `CreateManageLimitsRequestOp` with corresponding details based on given `CreateManageLimitsRequestResultCode`
union CreateManageLimitsRequestResult switch (CreateManageLimitsRequestResultCode code)
{
case SUCCESS:
    struct {
        //: ID of the created manage limits request
        uint64 manageLimitsRequestID;
        //: Boolean value that indicates whether or not the request was auto approved
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

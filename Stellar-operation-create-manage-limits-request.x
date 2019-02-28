

%#include "xdr/Stellar-ledger-entries.h"


namespace stellar
{

/* CreateManageLimitsRequestOp

    Create manage limits request

    Threshold: med or high

    Result: CreateManageLimitsRequestResult
*/

//: `CreateManageLimitsRequestOp` is used to create reviewable request which on approval will update limits set in the system
struct CreateManageLimitsRequestOp
{
    //: Body of the UpdateLimits reviewable request to be created
    LimitsUpdateRequest manageLimitsRequest;

    //: (optional) Bit mask whose flags must be cleared in order for ManageLimits request to be approved, which will be used
    //: instead of key-value by key `limits_update_tasks`
    uint32* allTasks;
    //: ID of the LimitsUpdateRequest\n
    //: If `requestID == 0` - operation creates new `LimitsUpdateRequest`, otherwise - updates existing one
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
    //: ManageLimitsRequest was successfully created and operation was successfully applied
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is another manage limits request for source account
    MANAGE_LIMITS_REQUEST_REFERENCE_DUPLICATION = -1,
    //: There is no request with such ID
    MANAGE_LIMITS_REQUEST_NOT_FOUND = -2,
    //: Details must be valid json
    INVALID_CREATOR_DETAILS = -3,
    //: Cannot load tasks fot the CreateManageLimitsRequest or configuration restricts to create manage limits request
    LIMITS_UPDATE_TASKS_NOT_FOUND = -5,
    //: Cannot set allTasks on rejected request update
    NOT_ALLOWED_TO_SET_TASKS_ON_UPDATE = -6,
    //: 0 not allowed for allTasks if set, or not allowed for value entry, got by key limits_update_tasks:<asset_code>
    LIMITS_UPDATE_ZERO_TASKS_NOT_ALLOWED = -7
};

//: `CreateManageLimitsRequestResult` represents the result of the `CreateManageLimitsRequestOp` with the corresponding details based on the given `CreateManageLimitsRequestResultCode`
union CreateManageLimitsRequestResult switch (CreateManageLimitsRequestResultCode code)
{
case SUCCESS:
    struct {
        //: ID of the created manage limits request
        uint64 manageLimitsRequestID;
        //: Boolean indicator that the request was auto approved
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

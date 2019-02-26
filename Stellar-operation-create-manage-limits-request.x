

%#include "xdr/Stellar-ledger-entries.h"


namespace stellar
{

/* CreateManageLimitsRequestOp

    Create manage limits request

    Threshold: med or high

    Result: CreateManageLimitsRequestResult
*/

//: `CreateManageLimitsRequestOp` represents the operation of limits updating reviewable request
struct CreateManageLimitsRequestOp
{
    //: Manage limits request itself
    LimitsUpdateRequest manageLimitsRequest;

    //: Bitmask of tasks which must be done for request approval
	uint32* allTasks;
	//: ID of the LimitsUpdateRequest
    uint64 requestID;

	// reserved for future use
	union switch (LedgerVersion v)
	{
	case EMPTY_VERSION:
		void;
	}
	ext;

};

/******* CreateManageLimits Result ********/

//: Result codes for CreateManageLimitsRequest operation
enum CreateManageLimitsRequestResultCode
{
    // codes considered as "success" for the operation
    //: ManageLimitsRequest was successfully created
    SUCCESS = 0,

    // codes considered as "failure" for the operation
	//: Pair `reference-source account` of the operation is not unique
	MANAGE_LIMITS_REQUEST_REFERENCE_DUPLICATION = -1,
	//: There is no request with such ID
    MANAGE_LIMITS_REQUEST_NOT_FOUND = -2,
    //: Details must be valid json
    INVALID_CREATOR_DETAILS = -3,
    //: Cannot load tasks fot the CreateManageLimitsRequest
	LIMITS_UPDATE_TASKS_NOT_FOUND = -5,
	//: Cannot set allTasks on request update
    NOT_ALLOWED_TO_SET_TASKS_ON_UPDATE = -6,
    //: Zero value of allTasks is not allowed
    LIMITS_UPDATE_ZERO_TASKS_NOT_ALLOWED = -7

};

//: `CreateManageLimitsRequestResult` represents the result of the `CreateManageLimitsRequestOp` with the corresponding details based on the given `CreateManageLimitsRequestResultCode`
union CreateManageLimitsRequestResult switch (CreateManageLimitsRequestResultCode code)
{
case SUCCESS:
    struct {
        //: ID of the created manage limits request
        uint64 manageLimitsRequestID;
        //: Indicates that the request was auto approved
		bool fulfilled;
		// reserved for future use
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

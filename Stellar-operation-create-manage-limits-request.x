

%#include "xdr/Stellar-ledger-entries.h"


namespace stellar
{

/* CreateManageLimitsRequestOp

    Create manage limits request

    Threshold: med or high

    Result: CreateManageLimitsRequestResult
*/

struct CreateManageLimitsRequestOp
{
    LimitsUpdateRequest manageLimitsRequest;

	uint32* allTasks;
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

enum CreateManageLimitsRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
	MANAGE_LIMITS_REQUEST_REFERENCE_DUPLICATION = -1,
    MANAGE_LIMITS_REQUEST_NOT_FOUND = -2,
    INVALID_DETAILS = -3, // details must be valid json
	LIMITS_UPDATE_TASKS_NOT_FOUND = -5,
    NOT_ALLOWED_TO_SET_TASKS_ON_UPDATE = -6, // can't set allTasks on request update
    LIMITS_UPDATE_ZERO_TASKS_NOT_ALLOWED = -7

};


union CreateManageLimitsRequestResult switch (CreateManageLimitsRequestResultCode code)
{
case SUCCESS:
    struct {
        uint64 manageLimitsRequestID;
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

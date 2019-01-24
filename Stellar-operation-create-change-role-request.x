%#include "xdr/Stellar-types.h"

namespace stellar
{

struct CreateChangeRoleRequestOp
{
    uint64 requestID;

    AccountID destinationAccount;
    uint64 accountRoleToSet;
    longstring kycData;

    uint32* allTasks;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreateUpdateKYCRequest Result ********/

enum CreateChangeRoleRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    ACC_TO_UPDATE_DOES_NOT_EXIST = -1, // account to update does not exist
    REQUEST_ALREADY_EXISTS = -2,
	SAME_ACC_TYPE_TO_SET = -3,
	REQUEST_DOES_NOT_EXIST = -4,
	PENDING_REQUEST_UPDATE_NOT_ALLOWED = -5,
	NOT_ALLOWED_TO_UPDATE_REQUEST = -6, // master account can update request only through review request operation
	INVALID_UPDATE_KYC_REQUEST_DATA = -7,
	INVALID_KYC_DATA = -8,
	KYC_RULE_NOT_FOUND = -9
};

union CreateChangeRoleRequestResult switch (CreateChangeRoleRequestResultCode code)
{
case SUCCESS:
    struct {
		uint64 requestID;
		bool fulfilled;
		// Reserved for future use
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
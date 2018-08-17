%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Creates or deletes an contract

Threshold: med

Result: ManageContractRequestResult

*/

enum ManageContractRequestAction
{
    CREATE = 0,
    REMOVE = 1
};

struct ManageContractRequestOp
{
    union switch (ManageContractRequestAction action){
    case CREATE:
        ContractRequest contractRequest;
    case REMOVE:
        uint64 requestID;
    } details;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageContractRequest Result ********/

enum ManageContractRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,
    NOT_FOUND = -2, // not found contract request, when try to remove
    TOO_MANY_CONTRACTS = -3,
    NOT_ALLOWED_TO_REMOVE = -4, // only contract creator can remove contract
    DETAILS_TOO_LONG = -5
};

struct CreateContractRequestResponse
{
	uint64 requestID;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageContractRequestResult switch (ManageContractRequestResultCode code)
{
case SUCCESS:
    struct
    {
        union switch (ManageContractRequestAction action)
        {
        case CREATE:
            CreateContractRequestResponse response;
        case REMOVE:
            void;
        } details;

        // reserved for future use
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } success;
default:
    void;
};

}

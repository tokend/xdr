%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/*ManageExternalSystemIdProvider

Threshold: high

Result: ManageExternalSystemIdProviderResult

*/

enum ManageExternalSystemIdProviderAction
{
    CREATE = 0
};

struct ManageExternalSystemIdProviderOp
{
    ManageExternalSystemIdProviderAction action;
    ExternalSystemType externalSystemType;
    longstring data;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageExternalSystemIdProvider Result ********/

enum ManageExternalSystemIdProviderResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,
    ALREADY_EXISTS = -2
};

struct ManageExternalSystemIdProviderSuccess {
	uint64 providerID;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageExternalSystemIdProviderResult switch (ManageExternalSystemIdProviderResultCode code)
{
case SUCCESS:
    ManageExternalSystemIdProviderSuccess success;
default:
    void;
};

}
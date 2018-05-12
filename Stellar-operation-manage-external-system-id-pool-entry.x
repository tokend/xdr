%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/*ManageExternalSystemAccountIdPoolEntry

Threshold: high

Result: ManageExternalSystemAccountIdPoolEntryResult

*/

enum ManageExternalSystemAccountIdPoolEntryAction
{
    CREATE = 0,
    DELETE = 1
};

struct CreateExternalSystemAccountIdPoolEntryActionInput
{
    int32 externalSystemType;
    longstring data;
    uint64 parent;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct DeleteExternalSystemAccountIdPoolEntryActionInput
{
    uint64 poolEntryID;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct ManageExternalSystemAccountIdPoolEntryOp
{
    union switch (ManageExternalSystemAccountIdPoolEntryAction action)
    {
    case CREATE:
        CreateExternalSystemAccountIdPoolEntryActionInput createExternalSystemAccountIdPoolEntryActionInput;
    case DELETE:
        DeleteExternalSystemAccountIdPoolEntryActionInput deleteExternalSystemAccountIdPoolEntryActionInput;
    } actionInput;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageExternalSystemAccountIdPoolEntry Result ********/

enum ManageExternalSystemAccountIdPoolEntryResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,
    ALREADY_EXISTS = -2,
    AUTO_GENERATED_TYPE_NOT_ALLOWED = -3,
    NOT_FOUND = -4
};

struct ManageExternalSystemAccountIdPoolEntrySuccess {
	uint64 poolEntryID;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageExternalSystemAccountIdPoolEntryResult switch (ManageExternalSystemAccountIdPoolEntryResultCode code)
{
case SUCCESS:
    ManageExternalSystemAccountIdPoolEntrySuccess success;
default:
    void;
};

}
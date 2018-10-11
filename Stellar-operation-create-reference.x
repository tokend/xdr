%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* CreateReference

    Add unique reference to database

    Threshold: high

    Result: CreateReferenceResult
*/

struct CreateReferenceOp
{
    string64 reference;
    longstring meta;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreateReference Result ********/

enum CreateReferenceResultCode
{
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    INVALID_REFERENCE = -1,
    INVALID_META = -2,
    ALREADY_EXISTS = -3
};

struct CreateReferenceSuccessResult
{
    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union CreateReferenceResult switch (CreateReferenceResultCode code)
{
    case SUCCESS:
        CreateReferenceSuccessResult success;
    default:
        void;
};

}
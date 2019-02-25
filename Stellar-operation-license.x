%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/*

Threshold: master weight

Result: LicenseResult

*/

struct LicenseOp
{
    uint64 adminCount;
    uint64 dueDate;
    Hash ledgerHash;
    Hash prevLicenseHash;
    DecoratedSignature signatures<>;


    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* License Result ********/

enum LicenseResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    INVALID_STAMP = -1,
    INVALID_DUE_DATE = -2,
    INVALID_SIGNATURE = -3
};

struct LicenseSuccess {
    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union LicenseResult switch (LicenseResultCode code)
{
case SUCCESS:
    LicenseSuccess success;
default:
    void;
};

}
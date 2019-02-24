%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/*

Threshold: master weight

Result: Hash

*/

struct StampOp
{
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* StampResult Result ********/

enum StampResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0

    // codes considered as "failure" for the operation
};

struct StampSuccess {

    Hash ledgerHash;
    Hash licenseHash;
    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union StampResult switch (StampResultCode code)
{
case SUCCESS:
    StampSuccess success;
default:
    void;
};

}

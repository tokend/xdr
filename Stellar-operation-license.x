%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/*

Threshold: master weight

Result: LicenseResult

*/
//: LicenseOp is used to perform license prolognation
struct LicenseOp
{
    //: allowed number of admins to set in the system
    uint64 adminCount;
    //: expiration date of the license
    uint64 dueDate;
    //: Stamped ledger hash which must be present in the system
    Hash ledgerHash;
    //: Hash of the previous license
    Hash prevLicenseHash;
    //: Signatures used to prove authenticity of license that is being submitted
    DecoratedSignature signatures<>;

    //: reserved for future use
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
    //: License submit was successful, provided adminCount and dueDate were set in the system
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: No stamp with provided ledger hash and previous license hash was found
    INVALID_STAMP = -1,
    //: Provided due date is in the past
    INVALID_DUE_DATE = -2,
    //: One of the signatures, or all of them, are incorrect
    INVALID_SIGNATURE = -3
};

//: LicenseSuccess is a result returned if operation submit was successful
struct LicenseSuccess {
    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of the applying LicenseOp
union LicenseResult switch (LicenseResultCode code)
{
case SUCCESS:
    LicenseSuccess success;
default:
    void;
};

}

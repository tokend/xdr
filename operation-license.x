%#include "xdr/ledger-entries.h"

namespace stellar
{

/*

Threshold: master weight

Result: LicenseResult

*/
//: License operation is used to increase the allowed number of admins and due date
struct LicenseOp
{
    //: Allowed number of admins to set in the system
    uint64 adminCount;
    //: Expiration date of the license
    uint64 dueDate;
    //: Hash of a stamped ledger  
    Hash ledgerHash;
    //: Hash of the previous license
    Hash prevLicenseHash;
    //: Signatures are used to prove authenticity of license that is being submitted.
    DecoratedSignature signatures<>;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* License Result ********/
//: Result code of the License operation application 
enum LicenseResultCode
{
    //: License submit was successful, provided adminCount and dueDate were set in the system
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Provided ledger hash and license hash were not stamped and are missing in the system.
    INVALID_STAMP = -1,
    //: Provided due date is in the past.
    INVALID_DUE_DATE = -2,
    //: Not enough valid signatures to submit a license (at least one valid signature is required)
    INVALID_SIGNATURE = -3,
    EXTRA_SIGNATURES = -4
};

//: LicenseSuccess is a result of successful LicenseOp application
struct LicenseSuccess {
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of the License operation application
union LicenseResult switch (LicenseResultCode code)
{
case SUCCESS:
    LicenseSuccess success;
default:
    void;
};
}


%#include "xdr/ledger-entries.h"

namespace stellar
{

/*

Threshold: master weight

Result: Hash

*/
//: StampOp is used to save current ledger hash and current license hash
struct StampOp
{
    //: Reserved for future use
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
    //: Stamp was successful 
    SUCCESS = 0

};
//: StampSuccess is used to pass saved ledger hash and license hash
struct StampSuccess {
    //: ledger hash saved into a database
    Hash ledgerHash;

    //: current license hash
    Hash licenseHash;
    
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: StampResult is a result of Stamp operation application
union StampResult switch (StampResultCode code)
{
case SUCCESS:
    StampSuccess success;
default:
    void;
};
}


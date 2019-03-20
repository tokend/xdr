%#include "xdr/Stellar-types.h"

namespace stellar
{

enum PollResult
{
    PASSED = 0,
    FAILED = 1
};

struct FinishPollOp
{
    uint64 pollID;

    PollResult result;
    longstring details;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


enum FinishPollResultCode
{
    // codes considered as "success" for the operation

    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Poll with provided ID not found
    NOT_FOUND = -1,

    NOT_READY = -2,

    INVALID = -3,

    NOT_AUTHORIZED = -4
};

union FinishPollResult switch (FinishPollResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};

}


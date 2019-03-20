%#include "xdr/Stellar-types.h"

namespace stellar
{

//: PollResult is used to specify result of voting
enum PollResult
{
    PASSED = 0,
    FAILED = 1
};

//: FinishPollOp is used to submit poll results
struct FinishPollOp
{
    //: ID of poll to finish
    uint64 pollID;

    //: result of voting
    PollResult result;

    //: Arbitrary stringified json object with details about the result
    longstring details;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result codes of FinishPollOp
enum FinishPollResultCode
{
    // codes considered as "success" for the operation
    //: Submitting of poll result was successful
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Poll with provided ID not found
    NOT_FOUND = -1,
    //:
    NOT_READY = -2
};

//: Result of FinishPollOp application
union FinishPollResult switch (FinishPollResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};

}


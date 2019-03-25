%#include "xdr/Stellar-types.h"

namespace stellar
{

enum ManagePollAction
{
    CLOSE = 0
//    UPDATE_END_TIME = 1,
//    REMOVE = 2,
};


//: PollResult is used to specify result of voting
enum PollResult
{
    PASSED = 0,
    FAILED = 1
};

//: ClosePollData is used to submit poll results
struct ClosePollData
{
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

struct UpdatePollEndTimeData
{
    uint64 newEndTime;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
struct ManagePollOp
{
    //: ID of poll to manage
    uint64 pollID;

    union switch (ManagePollAction action)
    {
    case CLOSE:
        ClosePollData closePollData;
//    case UPDATE_END_TIME:
//        UpdatePollEndTimeData updateTimeData;
//    case REMOVE:
//        EmptyExt ext;
    }
    data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};



enum ManagePollResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    NOT_FOUND = -1, // not found contract request, when try to remove
    POLL_NOT_READY = -2,
    NOT_AUTHORIZED_TO_CLOSE_POLL = -3

};

union ManagePollResult switch (ManagePollResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};

}

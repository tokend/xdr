%#include "xdr/Stellar-types.h"

namespace stellar
{

struct CheckPollOp
{

    uint64 pollID;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


enum CheckPollResultCode
{
    // codes considered as "success" for the operation

    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Poll with provided ID not found
    NOT_FOUND = -1,

    NOT_READY = -2
};

enum PollResult
{
    PASSED = 0,

    FAILED = 1
};

struct PollChoiceResult
{
    uint64 choiceID;

    uint64 votesCount;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
      case EMPTY_VERSION:
        void;
    }
    ext;
};

struct PollPassedResult
{
    PollChoiceResult choicesResults<>;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
      case EMPTY_VERSION:
        void;
    }
    ext;
};

struct CheckPollSuccess
{

    //: Additional information regarding eventual result
    union switch (PollResult result)
    {
    case PASSED:
        PollPassedResult pollPassed;
    case FAILED:
        EmptyExt ext;
    }
    details;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
      case EMPTY_VERSION:
        void;
    }
    ext;
};

union CheckPollResult switch (CheckPollResultCode code)
{
case SUCCESS:
    CheckPollSuccess success;
default:
    void;
};

}


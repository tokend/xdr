%#include "xdr/Stellar-types.h"

namespace stellar
{

enum ManagePollAction
{
    UPDATE_END_TIME = 0,
    REMOVE = 1
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
    uint64 pollID;

    union switch (ManageCreatePollRequestAction action)
    {
    case CREATE:
        UpdatePollEndTimeData updateTimeData;
    case REMOVE:
        EmptyExt ext;
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

    NOT_FOUND = -2, // not found contract request, when try to remove


};

union ManagePollResult switch (ManagePollResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};

}
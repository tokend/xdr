%#include "xdr/Stellar-ledger-entries-vote.h"

namespace stellar
{

enum ManageVoteAction
{
    CREATE = 0,
    REMOVE = 1
};

struct CreateVoteData
{
    uint64 pollID;

    VoteData data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct RemoveVoteData
{
    uint64 voteID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct ManageVoteOp
{

    union switch (ManageVoteAction action)
    {
    case CREATE:
        CreateVoteData createData;
    case REMOVE:
        RemoveVoteData removeData;
    }
    data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

enum ManageVoteResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    INVALID_VOTE = -1, // vote option is invalid
    POLL_NOT_FOUND = -2, // poll not found
    VOTE_EXISTS = -3, // vote to remove  not found
    POLL_TYPE_MISMATCHED = -4


};

struct CreateVoteResponse
{
    uint64 voteID;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct ManageVoteSuccessResult
{
    union switch (ManageVoteAction action)
    {
    case CREATE:
        CreateVoteResponse response;
    case REMOVE:
        void;
    } details;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageVoteResult switch (ManageVoteResultCode code)
{
case SUCCESS:
    ManageVoteSuccessResult success;
default:
    void;
};

}

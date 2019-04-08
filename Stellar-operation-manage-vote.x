%#include "xdr/Stellar-ledger-entries-vote.h"

namespace stellar
{

//: Actions that can be applied to the vote entry
enum ManageVoteAction
{
    CREATE = 0,
    REMOVE = 1
};

//: CreateVoteData is used to pass needed params to create (send) vote
struct CreateVoteData
{
    //: ID of a poll to vote in
    uint64 pollID;

    //: `data` is used to pass choice with functional type of a poll
    VoteData data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: RemoveVoteData is used to pass needed params to remove (cancel) a vote
struct RemoveVoteData
{
    //: ID of a poll
    uint64 pollID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: ManageVoteOp is used to create (send) or remove (cancel) the vote
struct ManageVoteOp
{
    //: `data` is used to pass `ManageVoteAction` with needed params
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

//: Result code of ManageVoteOp
enum ManageVoteResultCode
{
    // codes considered as "success" for the operation
    //: Specified action in `data` of ManageVoteOp has been successfully executed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no vote from the source account in such poll
    VOTE_NOT_FOUND = -1, // vote to remove  not found
    //: There is no poll with such an id
    POLL_NOT_FOUND = -2, // poll not found
    //: It is not allowed to create (send) two votes for one poll
    VOTE_EXISTS = -3,
    //: It is not allowed to create (send) vote with functional type that is different from the poll functional type
    POLL_TYPE_MISMATCHED = -4,
    //: It is not allowed to vote in a poll which has not started yet
    POLL_NOT_STARTED = -5,
    //: It is not allowed to vote in a poll which has already ended
    POLL_ENDED = -6
};

//: Result of the ManageVoteOp application
union ManageVoteResult switch (ManageVoteResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};

}

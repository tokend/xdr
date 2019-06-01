%#include "xdr/ledger-entries-vote.h"

namespace stellar
{

//: Actions that can be applied to a vote entry
enum ManageVoteAction
{
    CREATE = 0,
    REMOVE = 1
};

//: CreateVoteData is used to pass needed params to create (send) vote
struct CreateVoteData
{
    //: ID of poll to vote in
    uint64 pollID;

    //: `data` is used to pass choice with functional type of poll
    VoteData data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: RemoveVoteData is used to pass needed params to remove (cancel) own vote
struct RemoveVoteData
{
    //: ID of poll
    uint64 pollID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: ManageVoteOp is used to create (send) or remove (cancel) vote
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
    //: Specified action in `data` of ManageVoteOp was successfully executed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no vote from source account in such poll
    VOTE_NOT_FOUND = -1, // vote to remove  not found
    //: There is no poll with such id
    POLL_NOT_FOUND = -2, // poll not found
    //: Not allowed to create (send) two votes for one poll
    VOTE_EXISTS = -3,
    //: Not allowed to create (send) vote with functional type that is different from the poll functional type
    POLL_TYPE_MISMATCHED = -4,
    //: Not allowed to vote in poll which not started yet
    POLL_NOT_STARTED = -5,
    //: Not allowed to vote in poll which already was ended
    POLL_ENDED = -6
};

//: Result of ManageVoteOp application
union ManageVoteResult switch (ManageVoteResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};

}

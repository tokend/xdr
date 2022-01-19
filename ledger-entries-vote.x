%#include "xdr/types.h"
%#include "xdr/ledger-entries-poll.h"

namespace stellar
{


struct SingleChoiceVote
{
    uint32 choice;
    EmptyExt ext;
};

/*
struct MultipleChoiceVote {
    uint64 choices<>;
    EmptyExt ext;
};
*/


union VoteData switch (PollType pollType)
{
case SINGLE_CHOICE:
    SingleChoiceVote single;
case CUSTOM_CHOICE:
	longstring custom;
//case MULTIPLE_CHOICE:
//    MultipleChoiceVote multiple;
};

struct VoteEntry
{
    uint64 pollID;

    AccountID voterID;

    VoteData data;

    EmptyExt ext;
};
}

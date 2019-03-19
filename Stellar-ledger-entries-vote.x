%#include "xdr/Stellar-types.h"

namespace stellar
{


struct SingleChoiceVote
{
    uint64 choice;
    EmptyExt ext;
};

/*
struct MultipleChoiceVote {
    uint64 choices<>;
    EmptyExt ext;
};
*/


union VoteData switch (PollType p)
{
case SINGLE_CHOICE:
    SingleChoiceVote single;
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

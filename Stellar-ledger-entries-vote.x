%#include "xdr/Stellar-types.h"

namespace stellar
{

struct VoteEntry
{
    uint64 ID;

    Vote vote;

    longstring details;
    EmptyExt ext;
};

union switch Vote (p PollType)
{
case SINGLE_CHOICE:
    SingleChoiceVote single;
//case MULTIPLE_CHOICE:
//    MultipleChoiceVote multiple;
};

struct SingleChoiceVote {
    uint64 choice;
    EmptyExt ext;
};

/*
struct MultipleChoiceVote {
    uint64<> choices;
    EmptyExt ext;
};
*/
}
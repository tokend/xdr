%#include "xdr/Stellar-types.h"

namespace stellar
{

//: Functional type of poll
enum PollType
{
    SINGLE_CHOICE = 0
};

//: PollData is used to pass `PollType` with necessary params
union PollData switch (PollType type)
{
case SINGLE_CHOICE:
    EmptyExt ext;
};

struct PollEntry
{
    uint64 id;
    uint64 permissionType;

    uint64 numberOfChoices;
    PollData data;

    uint64 startTime;
    uint64 endTime;

    AccountID ownerID;
    AccountID resultProviderID;

    bool voteConfirmationRequired;

    longstring details;

    EmptyExt ext;
};

}